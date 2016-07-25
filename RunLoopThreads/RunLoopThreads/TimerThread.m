//
//  TimerThread.m
//  RunLoopThreads
//
//  Created by Amandeep Chawla on 25/07/16.
//  Copyright © 2016 Amandeep Chawla. All rights reserved.
//

#import "TimerThread.h"

@implementation TimerThread

- (void) timerFunc {
    NSLog(@"Timer Func");
}

- (void) main {
    @autoreleasepool {
        //set up the timer run loop
        // get access to the run loop object of this thread
        NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
            
        // attach a timer to this run loop
        NSTimer * timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerFunc) userInfo:nil repeats:YES];
                           
        [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
            
            // start the run loop
        [runLoop run];
    }
}
@end
