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

- (IBAction)stopThread:(id)sender {
    [timerThread stopThread];
}

- (void) downloadImage {
    NSString * str = @"https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/1000px-Apple_logo_black.svg.png";
    NSURL * url = [NSURL URLWithString:str];
    NSData * data = [NSData dataWithContentsOfURL:url];
    UIImage * image = [UIImage imageWithData:data];
    if ( image != nil) {
        NSLog(@"Image Downloaded");
    }
}

- (IBAction)executeTask:(id)sender {
    [self performSelector:@selector(downloadImage) onThread:timerThread withObject:nil waitUntilDone:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
