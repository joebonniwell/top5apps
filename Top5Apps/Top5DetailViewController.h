//
//  Top5DetailViewController.h
//  Top5Apps
//
//  Created by goVertex on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Top5DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic) BOOL usersTop5;
@property (strong, nonatomic) NSArray *top5Apps;

@end
