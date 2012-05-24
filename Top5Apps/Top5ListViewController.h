//
//  Top5ListViewController.h
//  Top5Apps
//
//  Created by Joe Bonniwell on 4/21/12.
//  Copyright (c) 2012 goVertex LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Top5NavigationDelegate.h"

@interface Top5ListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) id<Top5NavigationDelegate> navigationDelegate;

@end
