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
#import "AppSearchViewController.h"
#import "AppDetailViewController.h"
#import "Top5ListViewController.h"
#import "AppListViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, Top5NavigationDelegate>
{
    @private
    AccountViewController *accountViewController_gv;
    MenuViewController *menuViewController_gv;
    Top5DetailViewController *top5DetailViewController_gv;
    AppSearchViewController *appSearchViewController_gv;
    AppDetailViewController *appDetailViewController_gv;
    Top5ListViewController *top5ListViewController_gv;
    AppListViewController *appListViewController_gv;
}


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic, readonly) AccountViewController *accountViewController;
@property (strong, nonatomic, readonly) MenuViewController *menuViewController;
@property (strong, nonatomic, readonly) Top5DetailViewController *top5DetailViewController;
@property (strong, nonatomic, readonly) AppSearchViewController *appSearchViewController;
@property (strong, nonatomic, readonly) AppDetailViewController *appDetailViewController;
@property (strong, nonatomic, readonly) Top5ListViewController *top5ListViewController;
@property (strong, nonatomic, readonly) AppListViewController *appListViewController;
@end
