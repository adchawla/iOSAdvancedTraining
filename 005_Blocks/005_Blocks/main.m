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
    
    int var1 = 10;
    float var2 = 100.0;
    int (^myblock)(void);
    
    myblock = ^int {
        return var1 + var2;
    };
    
    int var3 = myblock();
    
    NSLog(@"var3 = %d", var3);
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
