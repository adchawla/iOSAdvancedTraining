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
    NSString * str = @"https://www.google.co.in/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwi84J2fhY7OAhXQFsAKHWT0DAEQjRwIBw&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3AApple_logo_black.svg&psig=AFQjCNFd0q8COSvsTpooc26MlhJnLRNP9w&ust=1469516377002987";
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
