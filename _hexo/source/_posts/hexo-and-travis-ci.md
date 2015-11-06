title: 配合Travis CI，将Hexo博客自动部署到你的服务器上。
date: 2015-11-06 17:30:39
tags:
---

> 这篇教程将指导你如何将写好的文章通过Git提交至GitHub仓库，并使用Travis CI自动构建、部署到你的服务器上。

今年夏天的时候，为了多练习Python，于是用就它写了一个简单的静态博客生成器，有模板有标签，不过与现有的静态博客相比还是相形见绌。即不易管理，也总出现BUG。

博客是需要静下心来写的，程序总需要维护实在不是长计，于是，昨天我便把博客换成了Hexo。<del>终于可以安静的写博客了。</del>

Hexo是一个基于Node.js的博客框架，从模板、主题再到插件应有尽有，写好文章后可以得到一个静态整站，对于像个人博客这种更新需求不大的网站是再适合不过了。

网上给出的教程多是将博客托管于GitHub Pages上，然而GitHub Pages在国内部分地区以及部分运营商的网络下的表现有时并不完美，经常出现载入缓慢，CSS及JS无法载入的问题，因此也有部分人选择将博客放在自己的服务器上。

但是在个人服务器上搭建博客又要考虑一个非常重要的问题——备份数据。GitHub提供的版本控制功能非常强大，但是个人服务器上大都没有使用版本控制系统，需要自行备份。

为什么不把GitHub的强大版本控制功能与个人服务器的访问速度结合在一起呢？

### 0x00 新的开始

新建一个代码仓库，我们暂且取名为 <code>HexoBlog</code> 好了。
为了使仓库更简洁，我们可以在<code>master</code>分支的基础上新建一个分支，暂且取名为 <code>raw</code> 分支。

### 0x01 Clone到本地

```
git clone -b raw <仓库克隆URL> #只Clone出新建的raw分支 保留master分支用于部署
```

### 0x02 安装Node.js

Node.js的版本仍在不断更新中，请至[项目下载页](https://nodejs.org/en/download/)寻找合适系统架构的安装包。

安装包自带包管理器NPM。

![Node.js与NPM的版本](http://internal-static.keep.moe/hexo-and-travis-ci/02.00.png)

安装后可以在Terminal中查询Node.js与NPM的版本。

### 0x03 安装Hexo

```
cd ./HexoBlog #进入刚Clone的仓库目录
npm install hexo-cli -g
hexo init
npm install
```

接下来我们可以看到仓库中的文件结构

![文件结构](http://internal-static.keep.moe/hexo-and-travis-ci/03.00.png)

### 0x04 使用Travis CI

首先我们先打开[Travis CI](https://travis-ci.org/)，可以在右上角找到使用GitHub登陆的按钮。

![Travis CI首页](http://internal-static.keep.moe/hexo-and-travis-ci/04.00.png)

授权完成后，你可以在左上角找到My Repositories一旁的加号“+”，点击它，它就会列出你所有的仓库，你只需要找到刚才的 <code>HexoBlog</code> 并把它左侧的开关打开就可以了。

![添加仓库](http://internal-static.keep.moe/hexo-and-travis-ci/04.01.png)

![选择仓库](http://internal-static.keep.moe/hexo-and-travis-ci/04.02.png)

### 0x05 生成GitHub Personal Access Token

登录GitHub，在右上角头像处进入设置。

![进入设置](http://internal-static.keep.moe/hexo-and-travis-ci/05.00.png)

在左侧找到 <code>Personal access tokens</code>，并点击右上角的 <code>Generate new token</code>。

![Personal access tokens](http://internal-static.keep.moe/hexo-and-travis-ci/05.01.png)

需要为新的Token输入一个名字，这里我们就填入 <code>Travis CI</code> 好了。

![Generate new token](http://internal-static.keep.moe/hexo-and-travis-ci/05.02.png)
