title: "Project 1: Collaborative Online Judge System"
date: 2018-01-26 16:14:48
updated: 2018-01-26 16:14:48
tags: bittiger
---

## <center>Description</center>

What the heck is the event loop anyway (async)
https://www.youtube.com/watch?v=8aGhZQkoFbQ


## <center>Tech Stack</center>

### 傻傻分不清楚
- node.js = JS runtime, like JVM in java, run JS as backend code  
- angular.js = front-end framework  
- express.js = MVC web framework for node.js  

### node.js
- node.js is JavaScript runtime, similiar to JVM in java  
- node.js = run JS as backend code  
- node is **single** thread (with background workers)  
- event-driven  
- the **I/O APIs** in Node.js are **asynchronous****/non-blocking** by design, in order to accommodate the event loop. 
- `npm`: package ecosystem, is the largest ecosystem of open source libraries in the world  


### express.js
- one of the popular web framework for node.js  
- minimal and flexible Node.js web **application framework** for web and mobile applications  
- frameware provides **useful features** to modify send/receive requests  
- **Middleware functions:** functions that have access to the 1.request object (**req**), the 2.response object (**res**) and 3.**next middleware** function  
- The next **middleware function** is commonly denoted by a variable named next  

### angular.js
- front-end MVC framework  
- **Components** are the fundamental building blocks of Angular applications.  
- **Components** display data on the screen, listen for user input, and take action based on that input.  
- use `constructor()` to setup **Dependency Injection** and not much else.  
- `ngOnInit()` is better place to "start" - it's where/when components' bindings are resolved.  


component.ts deal with user interactions

service stores common utilities/functions, which appear multiple times in components.  

### TypeScript Language

- a **superset** of JavaScript  
- more functionality  
- catch error in complile time (yeah!)  
- access to great tool (intellgence in texteditor?)  
- browser don‘t understand typeScript, need to transpile TS into JS so browser can understand  

#### Types in TypeScript

```ts
let a: number;
let b: boolean;
let c: string;
let d: any;
let e: number[] = [1, 2, 3];
let f: any[] = [1, true, 'a', false];


```

#### Enum

instead of writinghttps://www.youtube.com/watch?v=oa9cnWTpqP8

```js
const ColorRed = 0;
const ColorGreen = 1;
const ColorBlue = 2;

```
we have: 

```js
enum Color { Red = 0, Green = 1, Blue = 2 };
let backgroudColor = Color.Blue;

```

#### Type assertion

without type assertion, `.` will not show methods on `string`  

```js
let message;
message = 'abc';
let endWithC = (<string>message).endWith('c');

```


`const PROBLEMS: Problem[] = []`  
- `PROBLEMS`: variable name  
- `: Problem[]`: define type in TypeScript    

https://www.typescriptlang.org/docs/handbook/basic-types.html


## Q&As

### node.js/angular.js/express.js

从Java的角度理解前端框架，nodejs，reactjs，angularjs，requirejs，seajs  
http://blog.csdn.net/uikoo9/article/details/45999745

### synchronous vs asynchronous 
- **synchronous**: executation of next instruction **need to wait** for completion of first one (**blocking**)   
- **asynchronous**: executation of next instrucction can be executed **in backgroud** without waiting for completion of previous one (**non-blocking**)  

### blocking vs nonblocking
- **blocking**: function that usually run slow, want to make it async so that not blocking next following tasks  
- **nonblocking**: function run slow make it non-blcking to make entire program run faster  


### linux vs unix

https://superuser.com/questions/816018/what-is-the-relationship-between-unix-linux-ubuntu-debian-and-android

UNIX and Linux are not related to DOS or Windows.

DOS was an outgrowth of the 8-bit CP/M operating system popular in the late 70's/early 80's.

Windows NT (of which XP, Vista, 7 and 8 are based on) was developed new by Microsoft starting in 1993 and borrows a lot of concepts and ideas from VAX VMS. Windows NT was developed to be a "real" modern, preemptive, multi-user, multi-tasking secure operating system.

Windows 3.1, 95, 98, and ME were pretty much Microsoft's idea/execution of multi-tasking (not multi-user, or secure) DOS.

Regarding UNIX, Linux, etc.:

UNIX is a kernel/API/operating system that has been around since the 70's.
A kernel provides a platform for programs to run, in the case of Unix, it allows multiple programs to run on a single computer and multiple users to access it. A kernel runs no programs on its own, these must be separately developed and provided.
An API is a standard way for programs to talk to the kernel. It's part of the kernel.
An operating system is a kernel plus common utility programs to manage and administrate the system. Common utility programs for UNIX include basic programs that manage services and logins (init), a shell that allows you enter commands (sh, bash), and basic file management commands such as cp, ls, mv, etc.
Linux is a UNIX-like kernel released under the GPL which at first worked on PC hardware, but now works on almost anything with a CPU (if you are allowed to run it).
GPL is a license that says anyone that modifies/enhances Linux, and publishes their modifications, is required to make those modifications available to the public and allow others to do the same.
Linux implements the UNIX API, so UNIX programs can run generally unmodified if they are recomplied (this is far easier than rewriting them from scratch) - since they use the UNIX API, they don't care if they are really talking to Linux or UNIX or something else, as long as the API does the same thing. 
Debian is a Linux distribution. It started in 1993 and is among the oldest distributions. Linux distributions generally provide:
a Linux kernel,
basic utility programs,
an installer so you can install Linux on your system,
a package manager (plus a format for packages - Debian uses .deb)
a repository of packages 

So you can install a distribution, get a basic Linux environment up and running, then call up packages from the distribution's repository, using the package manager, when you need software. It's different from Windows where traditionally software has been distributed on CDs and years go by between versions and updates. Software in repositories is typically updated frequently and the package manager handles downloading and applying any updates.
Debian is also strict about releasing only open source software, meaning things that require proprietary software to run, like modern video cards or Wi-Fi chipsets, won't work optimally (or at all) with Debian "out of the box."
Debian typically creates new versions slowly and is more interested in stability than new features. This makes Debian a favorite for servers where the hardware is relatively static and software stability is important. 

Ubuntu is a "fork" of Debian
Debian allows others to create distributions based on it, using its package management tools. Doing this is termed "forking."
In addition to the specific branding and look of Ubuntu, Ubuntu adds additional Ubuntu-specific repositories containing more and newer software. Ubuntu is more "bleeding-edge" than Debian - it was created to be more friendly and useful from a non-technical or non-UNIX-expert standpoint. It is all about new features and hardware working out of the box.
Most software that works on Debian will work on Ubuntu. The other way around can be a bit problematic since Debian's software is typically older. You might run into some base components that need updating to run Ubuntu stuff, but can't be updated because there's no newer version in the Debian repos. You can update these manually, but then that might require other components to be updated, etc.
Should note that Debian is a lot friendlier and aware of modern hardware these days than before.


### iTerm2 shortcuts

Tabs

Splict screens

https://cnbin.github.io/blog/2015/06/20/iterm2-kuai-jie-jian-da-quan/

## <center>Architecture</center>

## <center>Demo</center>




