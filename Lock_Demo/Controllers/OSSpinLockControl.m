//
//  OSSpinLockControl.m
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/5.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import "OSSpinLockControl.h"
#import <libkern/OSAtomic.h>    //

@interface OSSpinLockControl()
{
    OSSpinLock spinLock;
}

@end

@implementation OSSpinLockControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        spinLock = OS_SPINLOCK_INIT;  // 初始化
    }
    return self;
}


/**
 首先要提的是OSSpinLock已经出现了BUG，导致并不能完全保证是线程安全的。
 
 新版 iOS 中，系统维护了 5 个不同的线程优先级/QoS: background，utility，default，user-initiated，user-interactive。高优先级线程始终会在低优先级线程前执行，一个线程不会受到比它更低优先级线程的干扰。这种线程调度算法会产生潜在的优先级反转问题，从而破坏了 spin lock。
 具体来说，如果一个低优先级的线程获得锁并访问共享资源，这时一个高优先级的线程也尝试获得这个锁，它会处于 spin lock 的忙等状态从而占用大量 CPU。此时低优先级线程无法与高优先级线程争夺 CPU 时间，从而导致任务迟迟完不成、无法释放 lock。这并不只是理论上的问题，libobjc 已经遇到了很多次这个问题了，于是苹果的工程师停用了 OSSpinLock。
 苹果工程师 Greg Parker 提到，对于这个问题，一种解决方案是用 truly unbounded backoff 算法，这能避免 livelock 问题，但如果系统负载高时，它仍有可能将高优先级的线程阻塞数十秒之久；另一种方案是使用 handoff lock 算法，这也是 libobjc 目前正在使用的。锁的持有者会把线程 ID 保存到锁内部，锁的等待者会临时贡献出它的优先级来避免优先级反转的问题。理论上这种模式会在比较复杂的多锁条件下产生问题，但实践上目前还一切都好。
 OSSpinLock 自旋锁，性能最高的锁。原理很简单，就是一直 do while 忙等。它的缺点是当等待时会消耗大量 CPU 资源，所以它不适用于较长时间的任务。对于内存缓存的存取来说，它非常合适。
 */
- (void)getImageName
{
    while (true) {
        NSString *imageName;
        // 加了这个 之后
        OSSpinLockLock(&spinLock);
        if (imageNameArray.count>0) {
            imageName = [imageNameArray firstObject];
            [imageNameArray removeObjectAtIndex:0];
        }else{
            now = CFAbsoluteTimeGetCurrent();
            printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String], now-then,imageNameArray.count);
            OSSpinLockUnlock(&spinLock);
            return;
        }
        
        // 这里也需要加 不然 线程会一直锁住 因为 一般remove 操作后 会锁住
        OSSpinLockUnlock(&spinLock);
    }
   
}

@end



































































































