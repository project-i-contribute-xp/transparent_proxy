# 构建一个可以在主要的桌面平台（linux, windows, mac os)运行的透明代理服务
由于shadowsocksr的作者关闭了原始的仓库，在三个平台上找到都可以用的shadowsocksr客户端并不容易。

加上内核的限制，ss-redir并不支持mac os（windows情况不明），想要在除了linux的平台上搭建透明代理也有相当难度。

借助docker技术，我们可以统一三大平台的编译和运行环境，只需要做很少的平台相关实现（主要涉及iptable），就可以实现一个跨平台的透明代理。

不论是自用还是给其他朋友提供帮助，这样一个脚本集合都很有价值。

## 各平台支持情况
- (done) macOS
- (todo) windows
- (todo) linux

## Mac使用方法
```
git clone https://github.com/project-i-contribute-xp/transparent_proxy.git
cd transparent_proxy
./install_dependence_on_mac.sh（首次运行）
将配置文件gui-config.json复制到internal目录下（格式请参照gui-config.sample.json）
./enable_mac.sh（会从gui-config.json中读取出所有服务器列表，提供给用户选择）
./disable_mac.sh（关闭全局代理，路由表的修改是临时的，重启mac应该也会关闭全局代理路由配置）
```

## mac上的路由表修改
目前版本的macOS使用了源自BSD的pf机制管理路由表，发现可以直接通过echo配合管道将配置信息传递给pf，类似以下的语法：

```
echo "
rdr pass on lo0 inet proto tcp from any to !127.0.0.1 -> 127.0.0.1 port 8080
" | sudo pfctl -ef -
```

rdr指令可以将某个网卡接收到的数据转发到另外一个主机的指定端口上，但是对于从这个网卡发出的数据就不会处理。
所以使用了一个变通的方法，首先通过route-to将en0的数据转发到lo0上，再通过rdr指令将数据转发到本地端口：

```
rdr pass on lo0 inet proto tcp from any to !127.0.0.1 -> 127.0.0.1 port 8080
pass out on en0 route-to lo0 inet proto tcp from any to any port != 10080 keep state
```

pf相关资料如下：

- https://www.unix.com/man-page/freebsd/5/pf.conf/
- https://www.openbsd.org/faq/pf/

## pf转发流量的处理
macOS使用的bsd pf(package filter)可以将流量转发到某个端口，但是该端口接收到的数据与iptable转发的不一致，
为iptable开发的ss-redir就不能使用了，幸运的是已经有人开发好了从pf转发数据到socket代理的转接程序：

比如，python-proxy: https://github.com/qwj/python-proxy

python-proxy支持将pf流量导向任意的socket的代理，这样任何实现了socket代理的协议都可以被用于透明代理，通用性更好，我们的macOS透明代理就使用了这个方案。

我还发现rio开发了一个shadowsocks的分支版本，用go语言实现了pf转发数据的处理：

https://github.com/riobard/go-shadowsocks2/blob/master/tcp_darwin.go

这个方案的好处是性能可能比python好，问题是将pf转发逻辑与shadowsocks绑定在一起不够通用，如果找不到比python-proxy性能更好的方案，我考虑参照rio的实现，做一个go语言版本的pf转发处理程序。

## tun/tap方案
可以将pf转发到tun（虚拟网卡）上，再通过tun2socks重定向到socks代理。

tun技术看上去很高级，可以像管道一样实现网络包的修饰处理（比如一个tun实现混淆协议，一个tun实现vpn协议）。

有时间可以研究下怎么替代pproxy。

## 目前状态
- 自动安装docker脚本
   - (done）linux（ubuntu）
- (done)shadowsocks客户端构建 (build_shadowsocks.sh)
- (done)ss-local运行逻辑 (startup_shadowsocks.sh)
- 系统iptable修改逻辑
    - (done) macOS
- 通过代理转发dns请求
- 中国和外国ip走不同的路由
- 中国域名和国外域名使用不同的dns服务器解析
- 负载均衡
- (done)实现查找到服务器真实ip的功能(./get_all_ip_address.sh)

## 参考资料
- NAT(network address translation)
  - wikipedia: https://en.wikipedia.org/wiki/Network_address_translation?wprov=sfla1
  - RFC: https://tools.ietf.org/html/rfc2663
- Networking features in Docker Desktop for Mac: https://docs.docker.com/docker-for-mac/networking/

## 参考项目
- https://github.com/icymind/VRouter
- https://github.com/yinghuocho/gotun2socks
- https://github.com/songgao/water
