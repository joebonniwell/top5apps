//
//  DownloadManager.m
//  Top5Apps
//
//  Created by Joe Bonniwell on 5/24/12.
//  Copyright (c) 2012 goVertex LLC. All rights reserved.
//

#import "DownloadManager.h"

@interface DownloadManager ()
{
    CFMutableDictionaryRef currentConnections_gv;
}

- (CFMutableDictionaryRef)currentConnections;

@end

@implementation DownloadManager

// Singleton
+ (DownloadManager*)shared
{
    static dispatch_once_t pred;
    static DownloadManager *shared = nil;
    
    dispatch_once(&pred, ^{
                             shared = [[DownloadManager alloc] init];
                         });
    
    return shared;
}

- (void)dealloc
{
    if (currentConnections_gv)
        CFRelease(currentConnections_gv);
    
    [super dealloc];
}

#pragma mark - Download Start Methods

- (void)downloadImageAtURLString:(NSString*)argImageURLString
{
    // Double check that there is no existing connection
    
    // Add to pending queue
    
    // Start pending downloads in case we have room right now...
}

- (void)downloadSearchResultsForTerm:(NSString*)argSearchTerm
{
    
}

#pragma mark - NSURLConnection Methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    // Save image data to file... or parse JSON and notify of search results...
    
    // Post appropriate notification
}

#pragma mark - Current Connections

- (CFMutableDictionaryRef)currentConnections
{
    if (currentConnections_gv)
        return currentConnections_gv;
    currentConnections_gv = CFDictionaryCreateMutable(kCFAllocatorDefault, 16, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    return currentConnections_gv;
}

@end
