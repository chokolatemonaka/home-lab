# systemd-resolved

## 環境

- OS
  - Ubuntu-22.04
- package
  - systemd
    - 249.11-0ubuntu3.15

## 関連ファイル

### 設定ファイル

```sh
# systemd-resolvedの設定
/etc/systemd/resolved.conf
/etc/systemd/resolved.conf.d/*.conf
/run/systemd/resolved.conf.d/*.conf
/usr/lib/systemd/resolved.conf.d/*.conf

# resolv.conf
## システムが参照するファイル、/run/systemd/resolve配下のファイルへのシンボリックリンク
/etc/resolv.conf
## stubモードの参照ファイル
/run/systemd/resolve/stub-resolv.conf
## uplinkモードの参照ファイル
/run/systemd/resolve/resolv.conf
```

## 設定例

- 前提
  - 内部DNSサーバー(192.168.122.1)をシングルラベル(.なし)指定時に参照する例
  - 記載がない場合はデフォルトのコメントアウトのまま
  - 設定ファイル変更後の反映はすべて`sudo systemctl restart systemd-resolved`を実施
- モード (詳細は man systemd-resolved /ETC/RESOLV.CONFセクション)
  - uplink
    - 従来の/etc/resolv.confの記載を踏襲するモード
    - `resolv.conf`の参照先は`/run/systemd/resolve/resolv.conf`
  - stub
    - DNSSec等に対応した推奨モード、systemd-resolvedをstubとして使う
    - `resolv.conf`の参照先は`/run/systemd/resolve/stub-resolv.conf`

### uplink mode

#### 設定 (uplink mode)

```sh
DNS=192.168.122.1#. 8.8.8.8
```

#### 設定確認 (uplink mode)

```sh
$ resolvectl
Global
       Protocols: -LLMNR -mDNS -DNSOverTLS DNSSEC=no/unsupported
resolv.conf mode: uplink
     DNS Servers: 192.168.122.1#. 8.8.8.8

Link 2 (eth0)
Current Scopes: none
     Protocols: -DefaultRoute +LLMNR -mDNS -DNSOverTLS DNSSEC=no/unsupported

Link 6 (virbr0)
Current Scopes: none
     Protocols: -DefaultRoute +LLMNR -mDNS -DNSOverTLS DNSSEC=no/unsupported

Link 7 (vnet1)
Current Scopes: none
     Protocols: -DefaultRoute +LLMNR -mDNS -DNSOverTLS DNSSEC=no/unsupported

$ cat /etc/resolv.conf
(snip)
nameserver 192.168.122.1
nameserver 8.8.8.8
search .

$ ls -l /etc/resolv.conf
lrwxrwxrwx 1 root root 37 May 18 10:26 /etc/resolv.conf -> /run/systemd/resolve/stub-resolv.conf

$ ls -l /run/systemd/resolve/
total 4
srw-rw-rw- 1 systemd-resolve systemd-resolve   0 May 18 11:50 io.systemd.Resolve
-rw-r--r-- 1 systemd-resolve systemd-resolve 807 May 18 09:39 resolv.conf
lrwxrwxrwx 1 systemd-resolve systemd-resolve  11 May 18 11:50 stub-resolv.conf -> resolv.conf
```

#### 動作確認 (uplink mode)

```sh
$ host -t A debian
debian has address 192.168.122.157
$ host -t A www.google.com
www.google.com has address 142.251.222.4
$ host -t A debian.hoge
Host debian.hoge not found: 3(NXDOMAIN)
$ host -t A www.google.com
www.google.com has address 142.251.222.4
$ host -t A debian
debian has address 192.168.122.157
```

### stub mode

***存在しないドメインを指定するとうまく動かなくなるので要調査***

#### 設定 (stub mode)

```sh
DNS=192.168.122.1#. 8.8.8.8
Domains=~.
ResolveUnicastSingleLabel=yes
```

#### 設定確認 (stub mode)

```sh
$ resolvectl
Global
       Protocols: -LLMNR -mDNS -DNSOverTLS DNSSEC=no/unsupported
resolv.conf mode: stub
     DNS Servers: 192.168.122.1 8.8.8.8
      DNS Domain: ~.

Link 2 (eth0)
Current Scopes: none
     Protocols: -DefaultRoute +LLMNR -mDNS -DNSOverTLS DNSSEC=no/unsupported

Link 6 (virbr0)
Current Scopes: none
     Protocols: -DefaultRoute +LLMNR -mDNS -DNSOverTLS DNSSEC=no/unsupported

Link 7 (vnet1)
Current Scopes: none
     Protocols: -DefaultRoute +LLMNR -mDNS -DNSOverTLS DNSSEC=no/unsupported

$ cat /etc/resolv.conf
(snip)
nameserver 127.0.0.53
options edns0 trust-ad
search .

$ ls -l /etc/resolv.conf
lrwxrwxrwx 1 root root 37 May 18 10:26 /etc/resolv.conf -> /run/systemd/resolve/stub-resolv.conf

$ ls -l /run/systemd/resolve/
total 8
srw-rw-rw- 1 systemd-resolve systemd-resolve   0 May 18 11:35 io.systemd.Resolve
-rw-r--r-- 1 systemd-resolve systemd-resolve 807 May 18 09:39 resolv.conf
-rw-r--r-- 1 systemd-resolve systemd-resolve 920 May 18 11:32 stub-resolv.conf
```

#### 動作確認 (Stub mode)

★：おかしいポイント、参照できていたがNXDOMAINが帰ってきている

```sh
$ host -t A debian
debian has address 192.168.122.157
$ host -t A www.google.com
www.google.com has address 142.251.222.4
$ host -t A debian.hoge
Host debian.hoge not found: 3(NXDOMAIN)
$ host -t A www.google.com
www.google.com has address 142.251.222.4
$ host -t A debian
Host debian not found: 3(NXDOMAIN) ★
```

## debug

### ログレベル変更

```sh
sudo resolvectl log-level debug
```

### ログ確認

```sh
sudo journalctl -u systemd-resolved -f
```