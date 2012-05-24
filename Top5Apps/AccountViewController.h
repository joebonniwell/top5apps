//
//  AccountViewController.h
//  Top5Apps
//
//  Created by goVertex on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "Top5NavigationDelegate.h"

@interface AccountViewController : UIViewController <PF_FBRequestDelegate>

@property (nonatomic, assign) id<Top5NavigationDelegate> navigationDelegate;

@end
