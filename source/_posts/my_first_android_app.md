title: "My first android app - StopWatch"
date: 2015-09-14 14:17:17
updated: 2015-09-14 14:17:17
tags: Android Development, ece454
categories: 
---

## **Description:**

This mini lab is designed to get familiar with the programming language - Java - for android studio. This mini lab also get you chance to explorer the idea of `Runnerable`, `Multli-threads application`,`Handler`, as well as `OnClickListener`

### **key components:** 

When a new Handler Object is instantaited, a stand alone thread and a conressponding message queue is created. Handler object now can push/send either `Message Object` or `Runnable Object` into the message queue. Each Handler has its own seperate message queue, however, the Main UI thread is able to access and dequeue message/runnable from those queue from Handler. There are following two ways to send message/runnable to the queue: `Post` and `sendMessage()`.


## **TODO**

~~pause then resume result in negative values ~~  
~~handle zero appending for digits in millisecond ~~  
~~stop pause from starting the count ~~


## **Related Methods**
I will briefly introduce the following methods below.

### **Runnerable:**

Runnerable is the most common API that can be used to implemented multi-threading development.


### **Handler:**

Handler - communicate from other threads with main UI-thread.

Handler push either message or runnerable to the queue by following two methods:
 
1. Post()  
`post(Runable)`,   
`postAtTime(Runnable,long)`,  
`postDelayed(Runnable, long)`  - handle runnable after specfic time.

For the method `Post()` in handler, it passes a Runnable object to the message queue. Within the Runnable object, **override** the `run()` method. Usually, operations done on UI thread goes into the `run()` method.

2. sendMessage()  

SendMessage() is the other approach to communicate with the main UI thread. Since I am mainly using post() to send runnable to the message queue, therefore will not go into detail in this post.


### **OnclickListener**

Setup the buttons: 

Define button/message object to connect elements in UI layout.
        
        startBtn = (Button)findViewById(R.id.ui_startBtn);

Set up Button detection when Buttons click
        
        startBtn.setOnClickListener(ClickDetect);

Once button clicked, it goes to the function below. 


	private OnClickListener ClickDetect = new OnClickListener(){
        @Override
        public void onClick(View v)
        {
            // check which button is pushed
            if(v.getId() == startBtn.getId())
            {
                startTime = System.currentTimeMillis();
                handler.removeCallbacks(updateTimer);
                handler.postDelayed(updateTimer, 1);
                // reset all the record
                count = 0;
                pausedStart = 0;
                pausedEnd = 0;
                // make button invisible after click
                startBtn.setVisibility(View.INVISIBLE);
            }

Attach the code for the this stopwatch applications. Hope you enjoy your first android app as well!

<img src="http://7xihzu.com1.z0.glb.clouddn.com/myBlog.firstAndroidApp1.png" alt="stopWatch UI" style="width:600px;"/>

<img src="http://7xihzu.com1.z0.glb.clouddn.com/myBlog.firstAndroidApp2.png" alt="running app" style="width:600px"/>
 
### ** Codes **

[Click here for Code!](https://github.com/ruanxuyi/ece454minilab2)
	
 
 
### **Reference: **
[Android--多线程之Handler](http://www.cnblogs.com/plokmju/p/android_handler.html)  
[Android Button OnClickListener 使用方法(一)](http://guess740111.blogspot.com/2013/10/android-button-onclicklistener.html)  
[Java中Runnable和Thread的区别](http://developer.51cto.com/art/201203/321042.htm)  
[Android--多线程之Handler](http://www.cnblogs.com/plokmju/p/android_Handler.html)  
[Android學習筆記 - 計時器(Timer)](http://cooking-java.blogspot.com/2010/04/android-timer.html)  
[Android 定时器 Handler与sleep(long)方法](http://gengbiao.me/android/android_定时器/)

