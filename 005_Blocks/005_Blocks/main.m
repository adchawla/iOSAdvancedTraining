//
//  main.m
//  005_Blocks
//
//  Created by Amandeep Chawla on 25/07/16.
//  Copyright © 2016 Amandeep Chawla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    
    __block int var1 = 10;
    float var2 = 100.0;
    int (^myblock)(void);
    
    myblock = ^int {
        // not allowed as the variables passed are const by default
        // var2 = 50.0;
        var1 = 50;
        return var1 + var2;
    };
    
    int var3 = myblock();
    
    NSLog(@"var3 = %d", var3);
    NSLog(@"var1 = %d", var1);
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
