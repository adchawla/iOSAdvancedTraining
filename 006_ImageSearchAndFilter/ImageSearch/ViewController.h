//
//  ViewController.h
//  ImageSearch
//
//  Created by amit gulati on 04/09/15.
//  Copyright (c) 2015 amit gulati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrItem.h"
#import "FlickrFetcher.h"
#import "MaximumTasks.h"


@interface ViewController : UIViewController <UICollectionViewDataSource> {
    FlickrFetcher* fetcher;
    MaximumTasks* maxTasks;
}
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;
@property (strong, nonatomic) NSMutableArray* items;

- (IBAction)search:(id)sender;


@end

