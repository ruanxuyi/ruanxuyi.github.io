# Google Phone Interview

这一次google phone interview 虽然伤痕累累，不够还是在做人和学习方面有很大的收获。这次电话面试一开始想的是要好好的准备，所以把时间定在了离春季还有2天前，这样可以给自己充分的时间准备。然而事实证明这一切的想法都是浮云哈哈，midterms 还有 projects due 已经占用了大部分的时间，最后的刷题复习都是在前一天的晚上的两个小时还有第二天一个早上里完成的。

3月16日中部时间12点(西部时间10时)，接到了Red``wood City 的来电，电话的另一边时一个美国小哥，自称是google analytic team 的一员，负责一些后台数据的收集。小哥一上来看到我简历上说我对networking有强烈的兴趣。就开始了电话面试。

## 第一问: TCP vs UDP
让我谈谈tcp跟udp的区别，然后哪些情况下用tcp会比用udp更好。

对于这个问题上，答曰tcp跟udp最大的区别在于:  
1. TCP比UDP 更reliable。  
2. TCP通过checksum, 还有3 way handshake 来确保包裹的准确传递。  
3. UDP 比 TCP 快些因为UDP不具备checksum或者3－way－handshake 来确保包裹的成功传递(所以才会显得比TCP快)。  
4. 虽然UDP 没有以上的保证，但是可以通过UDP 快速传递，最后再通过MD5 编码来验证收到的的文件的完整性。  
5. 所以呢: UDP 更适合用于一些对于少量丢包并不会影响整体的服务。（例如: 视频，游戏）  
6. 而TCP 传输方式更适合于用于对于丢包很敏感的一些服务。(例如)  


以下是别的童鞋总结的UDP和TCP的区别: 

小结TCP与UDP的区别：  
1.基于连接与无连接；  
**2.对系统资源的要求（TCP较多，UDP少)**  
3.UDP程序结构较简单；  
4.流模式与数据报模式 ；  
5.TCP保证数据正确性，UDP可能丢包，**TCP保证数据顺序，UDP不保证**。  

以上加粗的几点，有所忽略。  
1. tcp guarantee packets arrived in correct order, while udp packets arrived OUTOF order, need to rearrange based on timestamp  
2. tcp guarantee delivery while udp uses "best effort"  
3. TCP requires more system resource during the closing state (server continue listeing for two minutes before closing connection)  
4. UDP is mostly used in cases where the packet delay is **more serious** than packet loss  


