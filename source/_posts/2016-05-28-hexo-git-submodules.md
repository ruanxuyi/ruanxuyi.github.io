title: "hexo git submodules"
date: 2016-05-28 13:00:05
tags:
- tag1
- teg2
categories:
- cat1
- cat2
---


## Description: 
网络上的很多用github来备份hexo源文件的教程感觉受益匪浅。基本原理就是新建一个仓库专门来备份hexo的源文件。可是大部分的教程都没有对于theme(别忘了他也是一个仓库)这个细节做特别的处理。这篇文章可以帮你解决或学到: 
1. 用git submodule 同时备份hexo源文件+theme的源文件
2. 当theme被修改后, hexo也能备份theme修改后的备份。


## 准备

1. 备份_config.xml/images 等文件。
2. 感谢xxx, 首先需要在github上fork你想要的theme. 

首先是主题下载的误区。很多主题里面为了简化安装步骤，直接让我们`git pull` 对应的主题仓库。这样虽然简化了步骤，但是如果我们希望对主题做改动后 就没有权限 push 回原来的仓库。因此正确的安装主题的方式是: 
1. fork 你需要的主题的仓库

fork很简单，只要登陆后在屏幕右上角点击 `fork` 按钮即可。fork完成后，自己的github里就会出现对应的主题文件夹。

![](fork.png)
 
2. git submodule (从你自己的github上)

首先，进入你的hexo文件夹

	cd hexo/theme
	
然后执行 `git clone` 命令行

	git clone git@github.com:替换你的github-user-name/hexo-theme-next.git
	mv 
	
执行完上面命令后，

你会问那我还希望跟原来的theme的update同步，别着急，我会在下面继续说TODO.


1. fork 
首先


## References: 

[利用git submodule来处理hexo的theme](http://jr0cket.co.uk/hexo/using-git-submodules-for-custom-hexo-theme.html)