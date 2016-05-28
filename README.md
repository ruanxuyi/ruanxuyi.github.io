# Hexo

#### `hexo d -g` hexo执行generate(将所有的md文件转化成html，然后保存在.deploy文件夹下),然后执行`d - deploy`指令，此时将所有转化好的html文件(位于.deploy文件夹下)，全部push到github仓库里。


## 评论栏 (set up comment block)
### - under your theme folder
### - Comment section
### - register disqus account
#### `disqus_shortname:  xruan`
#### - active link: 
https://disqus.com/websites/?utm_source=hexojs&utm_medium=Disqus-Footer


## Hexo添加文章时自动打开编辑器

[引用: Hexo添加文章时自动打开编辑器](http://notes.wanghao.work/2015-06-29-Hexo添加文章时自动打开编辑器.html)

使用方法: 
    
    hexo new "post-name" 

默认的markdown 编辑器(macdown) 自动打开`post-name.md`文件. 免去了寻找md文件的时间。
原理：当检测到 `hexo new` 关键字，创建新的child process用指定编辑器打开新建文件(path). 



## 404 Page
创建404.html，位于root/source文件夹下。copy以下代码，调用腾讯404寻找走失儿童。
404 代码位于: 
http://www.qq.com/404/

## 生成自动update博客scirpt

## 使用多说评论(Update with DUOSHUO comment module):
link: http://dev.duoshuo.com/threads/541d3b2b40b5abcd2e4df0e9

将通用代码粘贴到`hexo\themes\modernist\layout\_partial\comment.ejs`里面，如下：

```
<% if (config.disqus_shortname && page.comments){ %>
<section id="comment">
  #你的通用代码
<% } %>
```

## 添加文章阅读量统计

[添加文章阅读量统计1](https://notes.wanghao.work/2015-10-21-为NexT主题添加文章阅读量统计功能.html#配置LeanCloud)

[添加文章阅读量统计2](http://www.jeyzhang.com/hexo-next-add-post-views.html)

## hexo 添加搜索功能

[swiftype搜索功能](http://www.jianshu.com/p/2010ad07d960)

## 搭建HEXO+安装主题+第三方评论+网站统计+搜索引擎+小插件+配置结构分析

[朱琛小屋](http://prozhuchen.github.io/page/2/)

## 遇到错误：(ERRORs)
1. `highlight = hexo-config("highlight.enable")`  
Solution: Run `npm install hexo-renderer-stylus --save`

2. when try to deploy website after install on loaca machine:   
`% hexo deploy: ERROR Deployer not found: github`  
Solution: `npm install hexo-deployer-git --save` and   
In version 3, your should use `git` instead of `github`.

## 更改footer信息
位于 `hexo\themes\modernist\layout\_partial\footer.ejs`

## 添加google analytics

google_analytics:
```
  enable: true 
  id: UA-61663668-1 ## e.g. UA-46321946-2 your google analytics ID.
  site: www.xuyiruan.com ## e.g. wuchong.me your google analytics site or set the value as auto.
```


## Preview Drafts

[See details here:](https://hexo.io/zh-cn/docs/drafts.html)

### Creating

    hexo new draft <title>

Files will be saved in `source/_drafts` folder.

### Previewing

 Run hexo server with `-d` or `--drafts` flag.

    hexo server --drafts
### Publishing

Once your draft is done, you can publish it with `hexo publish` command.

    hexo publish [layout] <filename>

Files will be moved to `source/_posts` folder and applied with the `layout` you specified in the command.


