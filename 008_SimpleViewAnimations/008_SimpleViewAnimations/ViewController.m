//
//  ViewController.m
//  008_SimpleViewAnimations
//
//  Created by Amandeep Chawla on 26/07/16.
//  Copyright © 2016 Amandeep Chawla. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myView.transform = CGAffineTransformMakeScale(0, 0);
    
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //    self.myView.transform = CGAffineTransformIdentity;
    //});
    
    // create animation block
//    [UIView beginAnimations:@"ANIM" context:NULL];
//    [UIView setAnimationDuration:4];
//    self.myView.transform = CGAffineTransformIdentity;
//    self.myView.backgroundColor = [UIColor redColor];
//    [UIView commitAnimations];
    
    
    [UIView animateWithDuration:3 animations:^{
        self.myView.transform = CGAffineTransformMakeRotation(3.14159/2);
        self.myView.backgroundColor = [UIColor greenColor];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
