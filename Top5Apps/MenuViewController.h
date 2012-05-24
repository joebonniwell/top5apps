//
//  MenuViewController.h
//  Top5Apps
//
//  Created by goVertex on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "Top5NavigationDelegate.h"

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;

@property (strong, nonatomic) UIButton *meButton;
@property (strong, nonatomic) UIButton *friendsButton;
@property (strong, nonatomic) UIButton *everyoneButton;
@property (strong, nonatomic) UIButton *appsButton;

@property (strong, nonatomic) id<Top5NavigationDelegate> navigationDelegate;
@end
