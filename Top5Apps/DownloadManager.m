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

@property (nonatomic, retain) NSMutableArray *pendingImageDownloads;

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

- (id)init
{
    if ((self = [super init]))
    {
        [self setPendingImageDownloads:[NSMutableArray array]];
    }
    return self;
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
    if ([[self pendingImageDownloads] containsObject:argImageURLString] == NO)
    {
        [[self pendingImageDownloads] addObject:argImageURLString];
        [self startPendingDownloads];
    }
}

- (void)downloadSearchResultsForTerm:(NSString*)argSearchTerm
{    
    // for each current connection...
        // is the connection a search connection?
            // Cancel it
    
    NSString *escapedSearchTerm = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)argSearchTerm, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    NSString *countryCode = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    
    NSString *searchURLString = [NSString stringWithFormat:@"http://itunes.apple.com/search?entity=software&country=%@term=%@", countryCode, escapedSearchTerm];
    NSURL *searchURL = [NSURL URLWithString:searchURLString];
    NSURLRequest *searchURLRequest = [NSURLRequest requestWithURL:searchURL];
    NSURLConnection *searchURLConnection = [NSURLConnection connectionWithRequest:searchURLRequest delegate:self];
    NSMutableDictionary *connectionOptions = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                              [NSMutableData data], T5ConnectionData,
                                              searchURLString, T5ConnectionURLString,
                                              [NSNumber numberWithInt:T5DownloadTypeSearchDownload], T5ConnectionType,
                                              nil];
    CFDictionaryAddValue([self currentConnections], searchURLConnection, connectionOptions);
}

- (void)startPendingDownloads
{
    if (CFDictionaryGetCount([self currentConnections]) < 4)
    {
        while (CFDictionaryGetCount([self currentConnections]) < 4 && [[self pendingImageDownloads] count] > 0)
        {
            // Start an image download form pendingImageDownloads
            NSString *imageURLString = [[self pendingImageDownloads] objectAtIndex:0];
            NSURL *imageURL = [NSURL URLWithString:imageURLString];
            NSURLRequest *imageURLRequest = [NSURLRequest requestWithURL:imageURL];
            NSURLConnection *imageURLConnection = [NSURLConnection connectionWithRequest:imageURLRequest delegate:self];
            NSMutableDictionary *connectionOptions = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                          [NSMutableData data], T5ConnectionData,
                                                          imageURLString, T5ConnectionURLString,
                                                          [NSNumber numberWithInt:T5DownloadTypeImageDownload], T5ConnectionType,
                                                          nil];
            CFDictionaryAddValue([self currentConnections], imageURLConnection, connectionOptions);
                
            [[self pendingImageDownloads] removeObjectAtIndex:0];
        }
    }
}

#pragma mark - NSURLConnection Methods

- (void)connection:(NSURLConnection*)argConnection didFailWithError:(NSError*)argError
{
    NSMutableDictionary *connectionOptions = CFDictionaryGetValue([self currentConnections], argConnection);
    NSString *connectionURL = [connectionOptions objectForKey:T5ConnectionURLString];
    NSLog(@"Connection to: %@ failed with error: %@", connectionURL, [argError userInfo]);
    CFDictionaryRemoveValue([self currentConnections], argConnection);
    
    // Send notification if it was a search and failed...
}

- (void)connection:(NSURLConnection*)argConnection didReceiveResponse:(NSURLResponse*)argResponse
{
    NSMutableDictionary *connectionOptions = CFDictionaryGetValue([self currentConnections], argConnection);
    [connectionOptions setObject:[NSMutableData data] forKey:T5ConnectionData];
}

- (void)connection:(NSURLConnection*)argConnection didReceiveData:(NSData*)argData
{
    NSMutableDictionary *connectionOptions = CFDictionaryGetValue([self currentConnections], argConnection);
    NSMutableData *connectionData = [connectionOptions objectForKey:connectionData];
    [connectionData appendData:argData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)argConnection
{
    NSMutableDictionary *connectionOptions = CFDictionaryGetValue([self currentConnections], argConnection);
    T5DownloadType connectionType = [[connectionOptions objectForKey:T5ConnectionType] intValue];
    NSMutableData *connectionData = [connectionOptions objectForKey:T5ConnectionData];
    
    if (connectionType == T5DownloadTypeImageDownload)
    {
        // Save image to file
        // Post notification
    }
    else if (connectionType == T5DownloadTypeSearchDownload)
    {
        NSError *error = nil;
        NSDictionary *searchResults = [NSJSONSerialization JSONObjectWithData:connectionData options:0 error:&error];
        
        if (!searchResults)
            NSLog(@"Error parsing JSON: %@", [error userInfo]);
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:<#(NSString *)#> object:<#(id)#>
        // Post Notification with results
    }
}

#pragma mark - Current Connections

- (CFMutableDictionaryRef)currentConnections
{
    if (currentConnections_gv)
        return currentConnections_gv;
    currentConnections_gv = CFDictionaryCreateMutable(kCFAllocatorDefault, 16, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    return currentConnections_gv;
}

#pragma mark - Property Synthesis

@synthesize pendingImageDownloads;

@end
