//
//  AppListViewController.h
//  Top5Apps
//
//  Created by Joe Bonniwell on 4/20/12.
//  Copyright (c) 2012 goVertex LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppListTableViewCell.h"
#import "Top5NavigationDelegate.h"

@interface AppListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) id<Top5NavigationDelegate> navigationDelegate;

@end
