//
//  FlickrItem.h
//  ImageSearch
//
//  Created by Amit Gulati on 21/07/16.
//  Copyright © 2016 amit gulati. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrItem : NSObject
@property (strong, nonatomic) NSString* thumbnailURL;
@property (strong, nonatomic) NSString* largeURL;
@property (strong, nonatomic) NSString* title;
@end
