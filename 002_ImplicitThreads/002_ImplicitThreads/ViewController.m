//
//  ViewController.m
//  002_ImplicitThreads
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

- (void) blockingCall {
    [NSThread sleepForTimeInterval:10];
}

- (IBAction)implicitThread :(id)sender {
    //[self blockingCall];
    [self performSelectorInBackground:@selector(blockingCall) withObject:self];
}

@end
