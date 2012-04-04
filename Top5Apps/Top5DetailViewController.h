//
//  Top5DetailViewController.h
//  Top5Apps
//
//  Created by goVertex on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Top5NavigationDelegate.h"

@interface Top5DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger appSlotBeingEdited;

@property (nonatomic, assign) id<Top5NavigationDelegate> navigationDelegate;

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic) BOOL usersTop5;

@property (nonatomic, retain) PFObject *app1;
@property (nonatomic, retain) PFObject *app2;
@property (nonatomic, retain) PFObject *app3;
@property (nonatomic, retain) PFObject *app4;
@property (nonatomic, retain) PFObject *app5;

@end
