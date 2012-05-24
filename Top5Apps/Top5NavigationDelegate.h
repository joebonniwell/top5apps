//
//  Top5NavigationDelegate.h
//  Top5Apps
//
//  Created by goVertex on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@protocol Top5NavigationDelegate <NSObject>

//- (void)showAccountsViewController;
- (void)showMenuViewController;
//- (void)showAppListViewController;

- (void)showUsersTop5ViewController;
//- (void)showTop5ViewControllerWithList:(PFObject*)top5List;

- (void)showAppSearchViewControllerToSelectApp:(NSInteger)argAppToSelect;

- (void)showUsersTop5ViewControllerWithChosenApp:(PFObject*)app;

- (void)dismissAccountViewController;

- (void)showAppDetailViewController;

- (void)showTop5ListViewController;

- (void)showAccountViewController;

- (void)showTop5DetailViewController;

- (void)showAppListViewController;
@end
