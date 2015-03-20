# Hexo

#### `hexo d -g` hexo执行generate(将所有的md文件转化成html，然后保存在.deploy文件夹下),然后执行`d - deploy`指令，此时将所有转化好的html文件(位于.deploy文件夹下)，全部push到github仓库里。


## 评论栏 (set up comment block)
### - under your theme folder
### - Comment section
### - register disqus account
#### `disqus_shortname:  xruan`
#### - active link: 
https://disqus.com/websites/?utm_source=hexojs&utm_medium=Disqus-Footer


## 404 Page
创建404.html，位于root/source文件夹下。copy以下代码，调用腾讯404寻找走失儿童。
404 代码位于: 
http://www.qq.com/404/

## 生成自动update博客scirpt

## 使用多说评论(Update with DUOSHUO comment module):
link: http://dev.duoshuo.com/threads/541d3b2b40b5abcd2e4df0e9


## 遇到错误：(ERRORs)
1. `highlight = hexo-config("highlight.enable")`  
Solution: Run `npm install hexo-renderer-stylus --save`

2. when try to deploy website after install on loaca machine:   
`% hexo deploy: ERROR Deployer not found: github`  
Solution: `npm install hexo-deployer-git --save` and   
In version 3, your should use `git` instead of `github`.

