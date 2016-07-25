//
//  MaximumTasks.h
//  ImageSearch
//
//  Created by Amandeep Chawla on 25/07/16.
//  Copyright © 2016 amit gulati. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Task)(void);

@interface MaximumTasks : NSObject {
    dispatch_queue_t serialQ;
    dispatch_queue_t concurrentQ;
    dispatch_semaphore_t semaphore;
    int maxTasks;
}

-(void) addTask:(Task) t;

@end
