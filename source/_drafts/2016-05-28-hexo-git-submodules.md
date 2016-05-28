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


## "正确"的下载你的主题

1. 备份_config.xml/images 等文件。
2. fork
3. git clone
4. set upstream
- keep updates with the orginal theme developers
- also able to make your own updates on the theme at the same time.
5. setup submodule 

```
	$ git submodule add git@github.com:ruanxuyi/hexo-theme-next.git themes/next    
	$ Adding existing repo at 'themes/next' to the index
```


2. 感谢xxx, 首先需要在github上fork你想要的theme. 

首先是主题下载的误区。很多主题里面为了简化安装步骤，直接让我们`git pull` 对应的主题仓库。这样虽然简化了步骤，但是如果我们希望对主题做改动后 就没有权限 push 回原来的仓库。因此正确的安装主题的方式是: 
1. fork 你需要的主题的仓库

fork很简单，只要登陆后在屏幕右上角点击 `fork` 按钮即可。fork完成后，自己的github里就会出现对应的主题文件夹。

![](fork.png)
 
2. git clone (从你自己的github上)

首先，进入你的hexo文件夹

	cd hexo/theme
	
然后执行 `git clone` 命令行

	git clone git@github.com:替换你的github-user-name/hexo-theme-next.git
	mv 
	
Problem: 
```
xruan@Xuyis-MacBook-Air:ruanxuyi.github.io/themes ‹source›$ git submodule init
fatal: no submodule mapping found in .gitmodules for path 'ruanxuyi.github.io'
```
Solution: 

```
No submodule mapping found in .gitmodules for path 'OtherLibrary/MKStore' when

$ git submodule update --init
I didn't know why the error occur. After spending a minute and found the answer in stackoverflow.

$ git rm --cached OtherLibrary/MKStore
and then update the submodule again. It's working fine.


```
	
```
xruan@Xuyis-MacBook-Air:themes/next ‹master*›$ git remote -v
origin	git@github.com:ruanxuyi/hexo-theme-next.git (fetch)
origin	git@github.com:ruanxuyi/hexo-theme-next.git (push)
xruan@Xuyis-MacBook-Air:themes/next ‹master*›$ git remote add upstream git@github.com:iissnan/hexo-theme-next.git
xruan@Xuyis-MacBook-Air:themes/next ‹master*›$ git remote -v
origin	git@github.com:ruanxuyi/hexo-theme-next.git (fetch)
origin	git@github.com:ruanxuyi/hexo-theme-next.git (push)
upstream	git@github.com:iissnan/hexo-theme-next.git (fetch)
upstream	git@github.com:iissnan/hexo-theme-next.git (push)
```

在这之后你就可以自由自由自在的修改你的主题, 并且能够操作任何的push, pull 操作啦～

########

xruan@Xuyis-MacBook-Air:~/myBlog ‹source›$ git remote add origin git@github.com:ruanxuyi/ruanxuyi.github.io.git
fatal: remote origin already exists.

solution


```
You can see what remote repositories you are configured to connect to via

git remote -v
That will return a list in this format:

origin  git@github.com:github/git-reference.git (fetch)
origin  git@github.com:github/git-reference.git (push)
That might help you figure out what the original 'origin' pointed to.

If you want to keep the remote connection that you see with the -v, but still want to follow the Rails tutorial without having to remember 'github' (or some other name) for your tutorial's repo, you can rename your other repository with the command:

git remote rename [current name] [new name]
as in:

git remote rename origin oldrepo


```

#######
执行完上面命令后，

你会问那我还希望跟原来的theme的update同步，别着急，我会在下面继续说TODO.


## 备份你hexo的源文件
有些教程直接建立一个新的仓库来储存源文件，不过我个人认为直接在hexo寄托的仓库上直接建立一个新的branch就避免了额外仓库的建立。

在已存在的`xxxx.github.io`仓库上建立新的branch如下。

```
$ cd myBlog
$ git init
$ git checkout -b source
$ git add .
$ git commit -m "initial backup"
$ git remote add origin git@github.com:user-name/user-name.github.io.git
$ git push origin source
```
上面的命令执行后，会在现有的xxxx.github.io repo 上开多了一个叫做source的分支. source分支专门用来备份hexo 的源文件。而master主分支依然用来支持hexo的静态网页内容。虽然同在一个仓库里，只要不执行合并(pull request)，source 和 master间互不影响。


## 在新的电脑上轻松的继续你的博客
好了，现在不可源文件备份在xxxx.github.io仓库的source分支内。而自定义的主题(theme)文件夹备份在另一个仓库。当我们重装系统／另外一台机器上继续写博客时，需要下面三部曲: 

### 配置环境，安装hexo

```
$ brew update //很重要
$ brew install node
$ npm install hexo-cli -g

```

注意不要再执行：
	
	hexo init myBlog


### 克隆hexo源文件

	git clone -b source git@github.com:change2hao:change2hao.github.io.git



### 克隆最新的主题文件

	git submodule add git@github.com:change2hao/hexo-theme-next.git themes/next
	
	
1. fork 
首先





## References（引用）: 

[引用: 利用git submodule来处理hexo的theme](http://jr0cket.co.uk/hexo/using-git-submodules-for-custom-hexo-theme.html)  
[fatal: remote origin already exists](http://stackoverflow.com/questions/10904339/github-fatal-remote-origin-already-exists)  
[引用: 关于博客同步的解决办法](http://devtian.me/2015/03/17/blog-sync-solution/)