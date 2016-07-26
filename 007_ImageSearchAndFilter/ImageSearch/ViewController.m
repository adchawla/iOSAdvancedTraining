//
//  ViewController.m
//  ImageSearch
//
//  Created by amit gulati on 04/09/15.
//  Copyright (c) 2015 amit gulati. All rights reserved.
//

#import "ViewController.h"
#import "FlickrItem.h"
#import "ImageDetailViewController.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    fetcher = [[FlickrFetcher alloc] init];
    _items = [[NSMutableArray alloc] init];
    self.imagesCollectionView.dataSource = self;
    
    // create a concurrent operation queue
    concurrentQ = [[NSOperationQueue alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _items.count;
}


-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIImageView* imageView = (UIImageView*)[cell viewWithTag:101];
    imageView.image = nil;
    
    FlickrItem* item = [_items objectAtIndex:indexPath.row];
    
    NSURL* url = [NSURL URLWithString:item.thumbnailURL];
    __block NSData* data;
    
    NSBlockOperation* op = [NSBlockOperation blockOperationWithBlock:^{
        data = [NSData dataWithContentsOfURL:url];
    }];
    
    [op setCompletionBlock: ^{
        NSBlockOperation * op1 = [NSBlockOperation blockOperationWithBlock:^{
            UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
            UIImageView* imgView = (UIImageView*)[cell viewWithTag:101];
            imgView.image = [UIImage imageWithData:data];
        }];
        
        [[NSOperationQueue mainQueue] addOperation:op1];
    }];
    
    [concurrentQ addOperation:op];
    
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSArray* indexPaths = [self.imagesCollectionView indexPathsForSelectedItems];
    NSIndexPath* indexPath = indexPaths[0];
    
    FlickrItem* item = _items[indexPath.row];
    
    ImageDetailViewController* idvc = (ImageDetailViewController*) segue.destinationViewController;
    idvc.imageURL = item.largeURL;
}


- (IBAction)search:(id)sender {
    [self.searchTextField resignFirstResponder];
    NSLog(@"Begin");
    NSString* text = self.searchTextField.text;
    NSString* link = [fetcher getFlickrURL:text];
    
    NSBlockOperation* op = [NSBlockOperation blockOperationWithBlock:^{
        NSString* data = [fetcher getFlickrDataFromURL:link];
        _items = [fetcher parseFlickrItems:data];
    }];
    
    [op setCompletionBlock: ^{
        NSBlockOperation * op1 = [NSBlockOperation blockOperationWithBlock:^{
            [self.imagesCollectionView reloadData];
            NSLog(@"Done");
        }];
        
        [[NSOperationQueue mainQueue] addOperation:op1];
    }];
    
    [concurrentQ addOperation:op];

}
@end
