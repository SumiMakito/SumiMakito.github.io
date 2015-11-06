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

<!-- more -->

### 注意

本教程并不是为初学者准备的，因为其需要的步骤较多且较复杂，需要读者有使用Git及GitHub的经验，并了解PHP及Bash。

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

> 若 <code>NPM</code> 出现无法连接的问题，可以尝试[更换淘宝开源NPM镜像服务器](http://npm.taobao.org/)

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

确定生成后，Token将显示在页面上，此时需要将其复制并保存好，并避免泄露。遗忘Token后不能找回，只能重新生成。

![生成Token](http://internal-static.keep.moe/hexo-and-travis-ci/05.03.png)

最后，我们还需要[生成随机字符串](https://www.random.org/strings/?num=10&len=20&digits=on&upperalpha=on&loweralpha=on&unique=on&format=html&rnd=new)，并在其中选择一行随机字符串，为下文备用。

### 0x06 配置Travis CI

首先在Travis CI中找到已经启用自动构建的仓库，并在右侧找到设置按钮。

![设置按钮](http://internal-static.keep.moe/hexo-and-travis-ci/06.00.png)

有两处需要设置，首先需要启用 <code>Build only if .travis.yml is present</code> 选项，以避免 <code>master</code> 分支被构建和陷入构建循环的问题。

另外，在下方的环境变量设置处，我们需要设置两组变量，并注意保持 <code>Display value in build log</code> 禁用，以免构建日志泄露Token等信息。

```
#需要设置的两组变量
GitHubKEY = 上文生成的GitHub Personal Access Token
NOTIFY_TOKEN = 上文生成的随机字符串
```

![设置页面](http://internal-static.keep.moe/hexo-and-travis-ci/06.01.png)

在每次Push后，Travis CI将检查分支下的 <code>.travis.yml</code> 文件，并以此作为配置进行构建。

下面是我所使用的 <code>.travis.yml</code> :

```yml
language: node_js
node_js:
  - "0.12"
install:
  - npm install hexo-cli -g
  - npm install hexo --save
  - npm install
script:
  - chmod +x ./build.sh
  - ./build.sh > /dev/null
branches:
  only:
    - raw
```

有关于Travis CI配置的详细解释可以查阅[官方文档](http://docs.travis-ci.com/)

在这里，配置文件限制了自动构建工作只会在 <code>raw</code> 分支下进行。

可能你已经发现配置中的 <code>build.sh</code> 了，我们接下来就介绍一下这个文件。

```bash
hexo generate #生成静态整站
cd ./public #生成的静态页面会存储在public目录下
git init
git config --global push.default matching
git config --global user.email "username@example.com" #填入GitHub的邮箱地址
git config --global user.name "username" #填入GitHub的用户名
git add --all .
git commit -m "Travis CI Auto Builder" #自动构建后的内容将全部以此信息提交
git push --quiet --force https://${GitHubKEY}@github.com/你的GitHub用户名/你的代码仓库名.git master  #自动构建后的内容将全部以此信息提交
curl --connect-timeout 20 --max-time 30 -s http://远端服务器URL/webhook.php?_=${NOTIFY_TOKEN} #服务器Webhook 将在下文介绍
```

### 0x07 远端服务器的配置

到这里，大部分的工作都完成了，我们只需要配置远端服务器就可以了。

由于我们
