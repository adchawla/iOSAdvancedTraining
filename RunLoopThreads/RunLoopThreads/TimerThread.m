//
//  TimerThread.m
//  RunLoopThreads
//
//  Created by Amandeep Chawla on 25/07/16.
//  Copyright © 2016 Amandeep Chawla. All rights reserved.
//

#import "TimerThread.h"

@implementation TimerThread {
    NSTimer * timer;
}

- (void) timerFunc {
    NSLog(@"Timer Func");
}

-(void) stopThreadImpl {
    // stop the run loop
    CFRunLoopStop(CFRunLoopGetCurrent());
}

-(void) stopThread {
    [self performSelector:@selector(stopThreadImpl) onThread:self withObject:nil waitUntilDone:NO];
}

- (void) main {
    @autoreleasepool {
        //set up the timer run loop
        // get access to the run loop object of this thread
        NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
            
        // attach a timer to this run loop
        timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerFunc) userInfo:nil repeats:YES];
        
        [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
        
        NSPort * port = [[NSMachPort alloc] init];
        [runLoop addPort: port forMode:NSDefaultRunLoopMode];
        
        // start the run loop
        CFRunLoopRun();
        
        NSLog(@"Coming out of run loop");
    }
}
@end
