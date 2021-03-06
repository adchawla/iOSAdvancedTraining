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

-(void) changeLabel {
    [_label setText:@"Done"];
}

- (void) blockingCall {
    // to make sure the newly created thread has a auto release pool, otherwise
    // it may leak lot of memory.
    @autoreleasepool {
        [NSThread sleepForTimeInterval:10];
        [self performSelectorOnMainThread:@selector(changeLabel) withObject:self waitUntilDone:YES];
    }
}

- (IBAction)implicitThread :(id)sender {
    //[self blockingCall];
    [self performSelectorInBackground:@selector(blockingCall) withObject:self];
}

@end
