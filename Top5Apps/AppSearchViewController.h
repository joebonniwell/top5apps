//
//  AppSearchViewController.h
//  Top5Apps
//
//  Created by Joe Bonniwell on 4/2/12.
//  Copyright (c) 2012 goVertex LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Top5NavigationDelegate.h"

@interface AppSearchViewController : UIViewController <UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, assign) id<Top5NavigationDelegate> navigationDelegate;
@property (nonatomic, retain) UISearchDisplayController *searchDisplayController;
@property (nonatomic, retain) UISearchBar *searchBar;

@property (nonatomic, retain) NSArray *appResults;

@property (nonatomic, retain) NSURLConnection *searchConnection;
@property (nonatomic, retain) NSMutableData *searchData;

@end
