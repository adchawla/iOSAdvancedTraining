//
//  ViewController.m
//  RunLoopThreads
//
//  Created by Amandeep Chawla on 25/07/16.
//  Copyright © 2016 Amandeep Chawla. All rights reserved.
//

#import "ViewController.h"
#import "TimerThread.h"

@interface ViewController () {
    TimerThread * timerThread;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    timerThread = [[TimerThread alloc] init];
    [timerThread start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
