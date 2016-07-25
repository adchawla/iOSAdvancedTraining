//
//  MaximumTasks.m
//  ImageSearch
//
//  Created by Amandeep Chawla on 25/07/16.
//  Copyright © 2016 amit gulati. All rights reserved.
//

#import "MaximumTasks.h"

@implementation MaximumTasks

-(id) init {
    self = [super init];
    if (self) {
        serialQ = dispatch_queue_create("com.amandeep.ImageSearch", NULL);
        concurrentQ = dispatch_queue_create("com.amandeep.ImageSearch.CONQ", DISPATCH_QUEUE_CONCURRENT);
        maxTasks = 5;
        semaphore = dispatch_semaphore_create(maxTasks);
    }
    return self;
}


-(void) addTask:(Task)task {
    dispatch_async(serialQ, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(concurrentQ, ^{
            // execute the task on the concurrent Q
            task();
            dispatch_semaphore_signal(semaphore);
        });
    });
}

@end
