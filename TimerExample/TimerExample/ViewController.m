//
//  ViewController.m
//  TimerExample
//
//  Created by Amandeep Chawla on 25/07/16.
//  Copyright © 2016 Amandeep Chawla. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) timerFunc:(id) userInfo {
    NSLog(@"Timer Timeout");
}

- (IBAction)timerStart:(id)sender {
    // creates a timer, and does not schedule it for execution
    NSTimer * timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerFunc:) userInfo:nil repeats:YES];
    
    // get access to the run loop of the main thread
    NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
}

@end
