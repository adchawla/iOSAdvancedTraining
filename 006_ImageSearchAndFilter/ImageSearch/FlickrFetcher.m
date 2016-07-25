
#import "FlickrFetcher.h"
#import "FlickrItem.h"

#define ENDPOINT @"https://api.flickr.com/services/rest/";
#define API_KEY @"f2e92bdade8c1afb7dc1005c2272d89d";
#define METHOD_GET_RECENT @"flickr.photos.getRecent";
#define METHOD_GET_SEARCH @"flickr.photos.search";
#define PARAM_EXTRAS @"extras";

#define EXTRA_SMALL_URL @"url_s";

#define XML_PHOTO @"photo";

@implementation FlickrFetcher

-(NSString*) getFlickrURL:(NSString *)searchTerm {
    NSString* url = @"https://api.flickr.com/services/rest/";
    NSString* link = [url stringByAppendingFormat:@"?method=%@&api_key=%@&extras=%@&format=%@&text=%@", @"flickr.photos.search", @"f2e92bdade8c1afb7dc1005c2272d89d", @"url_s,url_l", @"json", searchTerm ];
    NSLog(@"QUERY = %@", link );
    return link;
}

-(NSMutableArray*) parseFlickrItems:(NSString*) str {
    NSMutableArray* items = [[NSMutableArray alloc] init];
    NSString* str1 = [str substringFromIndex:14];
    NSString* correctedStr = [str1 substringToIndex:str1.length - 1];
    
    NSData* data = [correctedStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //parse the JSON Payload
    NSError* error = nil;
    NSDictionary* mainObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    if(error != nil) {
        NSLog(@"Failed parsing JSON");
        return items;
    }
    
    NSDictionary* photosObject = [mainObject objectForKey:@"photos"];
    NSArray* photoArray = [photosObject objectForKey:@"photo"];
    for(int i = 0; i < photoArray.count; ++i) {
        FlickrItem* item = [[FlickrItem alloc] init];
        NSDictionary* photoObject = [photoArray objectAtIndex:i];
        
        NSString* url_s = [photoObject objectForKey:@"url_s"];
        NSString* url_l = [photoObject objectForKey:@"url_l"];
        item.thumbnailURL = url_s;
        item.largeURL = url_l;
        [items addObject:item];
    }
    return items;
}

-(NSString*) getFlickrDataFromURL:(NSString*) link {
    
    //send the web request
    NSURL* url = [NSURL URLWithString:link];
    NSData* data = [NSData dataWithContentsOfURL:url];
    
    NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;

}

@end
