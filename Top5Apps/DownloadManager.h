//
//  DownloadManager.h
//  Top5Apps
//
//  Created by Joe Bonniwell on 5/24/12.
//  Copyright (c) 2012 goVertex LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadManager : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

- (void)downloadImageAtURLString:(NSString*)argImageURLString;
- (void)downloadSearchResultsForTerm:(NSString*)argSearchTerm;
@end
