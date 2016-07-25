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
    
    // get access to the global dispatch queue
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:url];

        // get access to the main dispatch queue
        dispatch_queue_t mainDispatchQueue = dispatch_get_main_queue();
        dispatch_async(mainDispatchQueue, ^{
            UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
            UIImageView* imgView = (UIImageView*)[cell viewWithTag:101];
            imgView.image = [UIImage imageWithData:data];
        });
    });
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
    // get access to the global dispatch queue
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        NSString* data = [fetcher getFlickrDataFromURL:link];
        _items = [fetcher parseFlickrItems:data];
        
        // get access to the main dispatch queue
        dispatch_queue_t mainDispatchQueue = dispatch_get_main_queue();
        dispatch_async(mainDispatchQueue, ^{
            [self.imagesCollectionView reloadData];
        });
    });
    NSLog(@"Done");

}
@end
