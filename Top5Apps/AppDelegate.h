//
//  AppDelegate.h
//  Top5Apps
//
//  Created by goVertex on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "Top5NavigationDelegate.h"

#import "AccountViewController.h"
#import "MenuViewController.h"
#import "Top5DetailViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, Top5NavigationDelegate>
{
    @private
    AccountViewController *accountViewController_gv;
    MenuViewController *menuViewController_gv;
    Top5DetailViewController *top5DetailViewController_gv;
}


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic, readonly) AccountViewController *accountViewController;
@property (strong, nonatomic, readonly) MenuViewController *menuViewController;
@property (strong, nonatomic, readonly) Top5DetailViewController *top5DetailViewController;

@end
