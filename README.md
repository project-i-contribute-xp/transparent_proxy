# 构建一个可以在主要的桌面平台（linux, windows, mac os)运行的透明代理服务
由于shadowsocksr的作者关闭了原始的仓库，在三个平台上找到都可以用的shadowsocksr客户端并不容易。

加上内核的限制，ss-redir并不支持mac os（windows情况不明），想要在除了linux的平台上搭建透明代理也有相当难度。

借助docker技术，我们可以统一三大平台的编译和运行环境，只需要做很少的平台相关实现（主要涉及iptable），就可以实现一个跨平台的透明代理。

不论是自用还是给其他朋友提供帮助，这样一个脚本集合都很有价值。

## 目前状态
- 自动安装docker脚本
   - (done）linux（ubuntu）
- (done)shadowsocks客户端构建 (build_shadowsocks.sh)
- (done)ss-local运行逻辑 (startup_shadowsocks.sh)
- ss-redir启动逻辑
- 系统iptable修改逻辑
- 通过代理转发dns请求
- 中国和外国ip走不同的路由
- 中国域名和国外域名使用不同的dns服务器解析
- 负载均衡
- 实现查找到服务器真实ip的功能

## mac上的路由表修改
目前版本的macOS使用了源自BSD的pf机制管理路由表，相关资料如下：

- https://www.unix.com/man-page/freebsd/5/pf.conf/
- https://www.openbsd.org/faq/pf/

## 参考资料
- NAT(network address translation)
  - wikipedia: https://en.wikipedia.org/wiki/Network_address_translation?wprov=sfla1
  - RFC: https://tools.ietf.org/html/rfc2663

## 参考项目
- https://github.com/icymind/VRouter

