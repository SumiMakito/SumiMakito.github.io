title: Openshift下使用NPM时出现EACCESS错误的解决办法
date: 2015-11-05 23:44:37
tags:
---
<p>Npm是Node.js的包管理器，有时安装一些新模块都需要依靠npm install这个命令，但在Openshift这种限制多多的环境下，直接使用npm install这种命令安装模块可能会遇到各种错误，常见的就是本文所说的EACCESS错误。</p>

<p>这种错误通常是由权限不足导致的，在Openshift这种环境下也不难见到这种问题，因为npm在安装新模块时需要一个临时目录，而普通用户对环境变量中的临时目录是无权写入的，因此修改一下环境变量，把它指向我们有权限读写的文件夹就可以解决这个问题。</p>

<p>使用SSH Shell连接到你的服务器后使用以下命令(这里以安装express为例)</p>

<pre>cd app-root/repo/  
mkdir tmp  
export OPENSHIFT_TMP_DIR="`pwd`/tmp/"  
npm install express
</pre>
