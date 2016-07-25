
#import <Foundation/Foundation.h>

@interface FlickrFetcher : NSObject
-(NSString*) getFlickrURL:(NSString *)searchTerm;
-(NSMutableArray*) parseFlickrItems:(NSString*) str;
-(NSString*) getFlickrDataFromURL:(NSString*) link;
@end
