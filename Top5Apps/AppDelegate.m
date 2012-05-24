//
//  AppDelegate.m
//  Top5Apps
//
//  Created by goVertex on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

+ (void)initialize
{
    NSString *preferenceListPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Settings.bundle/Root.plist"];
    
    NSDictionary *settingsDictionary = [NSDictionary dictionaryWithContentsOfFile:preferenceListPath];
    
    NSMutableArray *settingsArray = [settingsDictionary objectForKey:@"PreferenceSpecifiers"];
    NSMutableDictionary *defaultSettingsDictionary = [NSMutableDictionary dictionary];
    
    for (NSDictionary *settingDict in settingsArray)
    {
        NSString *settingKey = [settingDict objectForKey:@"Key"];
        if (settingKey)
        {
            id settingDefaultValue = [settingDict objectForKey:@"DefaultValue"];
            [defaultSettingsDictionary setObject:settingDefaultValue forKey:settingKey];
        }
    }
    
    // State Defaults
    [defaultSettingsDictionary setObject:[NSNumber numberWithBool:YES] forKey:@"FirstRunEver"];
    [defaultSettingsDictionary setObject:[NSNumber numberWithInteger:0] forKey:@"LastView"];
    
    // Version tracking...
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultSettingsDictionary];
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor blackColor];
    
    [Parse setApplicationId:@"Uw8iVpXh4YnwzrBpx819VU7Ir0HSH4wDzZ0ub2L2" clientKey:@"5WVy7oPBaotvAmx5DEGsA1TS6LOHblC0gtGOUf7r"];
    [PFFacebookUtils initializeWithApplicationId:@"260849984008044"];
    
    // Override point for customization after application launch.
    
    [self setNavigationController:[[[UINavigationController alloc] initWithRootViewController:[self menuViewController]] autorelease]];
    [[self window] setRootViewController:[self navigationController]];
    [self.window makeKeyAndVisible];
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"FirstRunEver"] boolValue])
    {
        // Display the account screen with welcome banner
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"FirstRunEver"];
        
        // Modally display the account page overtop of the menu...
        //[[self menuViewController] presentViewController:[self accountViewController] animated:NO completion:nil];
        [[self menuViewController] presentModalViewController:[self accountViewController] animated:NO];
        
        NSLog(@"First run");
    }
    else
    {
        // Display the last view controller...
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url 
{
    return [PFFacebookUtils handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation 
{
    return [PFFacebookUtils handleOpenURL:url]; 
}

#pragma mark - Top5Navigation Methods

- (void)showMenuViewController
{
    if ([[[self navigationController] viewControllers] containsObject:[self menuViewController]])
    {
        [[self navigationController] popToViewController:[self menuViewController] animated:YES];
        return;
    }
    [[self navigationController] pushViewController:[self menuViewController] animated:YES];
}

- (void)showUsersTop5ViewController
{
    [[self top5DetailViewController] setUsersTop5:YES];
    
    if ([PFUser currentUser])
    {
        if ([[PFUser currentUser] objectForKey:@"app1"])
        {
            [[[PFUser currentUser] objectForKey:@"app1"] fetchIfNeeded];
            [[self top5DetailViewController] setApp1:[[PFUser currentUser] objectForKey:@"app1"]];
        }
        
        if ([[PFUser currentUser] objectForKey:@"app2"])
        {
            [[[PFUser currentUser] objectForKey:@"app2"] fetchIfNeeded];
            [[self top5DetailViewController] setApp2:[[PFUser currentUser] objectForKey:@"app2"]];
        }
        if ([[PFUser currentUser] objectForKey:@"app3"])
        {
            [[[PFUser currentUser] objectForKey:@"app3"] fetchIfNeeded];
            [[self top5DetailViewController] setApp3:[[PFUser currentUser] objectForKey:@"app3"]];
        }
        
        if ([[PFUser currentUser] objectForKey:@"app4"])
        {
            [[[PFUser currentUser] objectForKey:@"app4"] fetchIfNeeded];
            [[self top5DetailViewController] setApp4:[[PFUser currentUser] objectForKey:@"app4"]];
        }
        
        if ([[PFUser currentUser] objectForKey:@"app5"])
        {
            [[[PFUser currentUser] objectForKey:@"app5"] fetchIfNeeded];
            [[self top5DetailViewController] setApp5:[[PFUser currentUser] objectForKey:@"app5"]];
        }
    }
    
    [[self navigationController] pushViewController:[self top5DetailViewController] animated:YES];
}

- (void)showUsersTop5ViewControllerWithChosenApp:(PFObject*)app
{
    switch ([[self top5DetailViewController] appSlotBeingEdited]) 
    {
        case 1:
            [[self top5DetailViewController] setApp1:app];
            [[PFUser currentUser] setObject:app forKey:@"app1"];
            break;
        case 2:
            [[self top5DetailViewController] setApp2:app];
            [[PFUser currentUser] setObject:app forKey:@"app2"];
            break;
        case 3:
            [[self top5DetailViewController] setApp3:app];
            [[PFUser currentUser] setObject:app forKey:@"app3"];
            break;
        case 4:
            [[self top5DetailViewController] setApp4:app];
            [[PFUser currentUser] setObject:app forKey:@"app4"];
            break;
        case 5:
            [[self top5DetailViewController] setApp5:app];
            [[PFUser currentUser] setObject:app forKey:@"app5"];
            break;
        default:
            break;
    }
    [[[self top5DetailViewController] tableView] reloadData];
    [[PFUser currentUser] save];
    [[self navigationController] popToViewController:[self top5DetailViewController] animated:YES];
}

- (void)showAppSearchViewControllerToSelectApp:(NSInteger)argAppToSelect
{
    [[self appSearchViewController] setAppKey:[NSString stringWithFormat:@"app%d", argAppToSelect]];
    
    [[self navigationController] pushViewController:[self appSearchViewController] animated:YES];
}

- (void)dismissAccountViewController
{
    [[self menuViewController] dismissModalViewControllerAnimated:YES];
}

- (void)showAppDetailViewController
{
    [[self navigationController] pushViewController:[self appDetailViewController] animated:YES];
}

- (void)showTop5ListViewController
{
    [[self navigationController] pushViewController:[self top5ListViewController] animated:YES];
}

- (void)showAccountViewController
{
    [[self navigationController] pushViewController:[self accountViewController] animated:YES];
}

- (void)showTop5DetailViewController
{
    [[self top5DetailViewController] setUsersTop5:NO];
    [[self top5DetailViewController] setApp1:nil];
    [[self top5DetailViewController] setApp2:nil];
    [[self top5DetailViewController] setApp3:nil];
    [[self top5DetailViewController] setApp4:nil];
    [[self top5DetailViewController] setApp5:nil];
    [[[self top5DetailViewController] tableView] reloadData];
    [[self navigationController] pushViewController:[self top5DetailViewController] animated:YES];
}

- (void)showAppListViewController
{
    [[self navigationController] pushViewController:[self appListViewController] animated:YES];
}

#pragma mark - AccountViewController

- (AccountViewController*)accountViewController
{
    if (accountViewController_gv)
        return accountViewController_gv;
    accountViewController_gv = [[AccountViewController alloc] init];
    [accountViewController_gv setNavigationDelegate:self];
    return accountViewController_gv;
}

#pragma mark - MenuViewController

- (MenuViewController*)menuViewController
{
    if (menuViewController_gv)
        return menuViewController_gv;
    menuViewController_gv = [[MenuViewController alloc] init];
    [menuViewController_gv setNavigationDelegate:self];
    return menuViewController_gv;
}

#pragma mark - Top5DetailViewController

- (Top5DetailViewController*)top5DetailViewController
{
    if (top5DetailViewController_gv)
        return top5DetailViewController_gv;
    top5DetailViewController_gv = [[Top5DetailViewController alloc] init];
    [top5DetailViewController_gv setNavigationDelegate:self];
    return top5DetailViewController_gv;
}

#pragma mark - AppSearchViewController

- (AppSearchViewController*)appSearchViewController
{
    if (appSearchViewController_gv)
        return appSearchViewController_gv;
    appSearchViewController_gv = [[AppSearchViewController alloc] init];
    [appSearchViewController_gv setNavigationDelegate:self];
    return appSearchViewController_gv;
}

#pragma mark - AppDetailViewController

- (AppDetailViewController*)appDetailViewController
{
    if (appDetailViewController_gv)
        return appDetailViewController_gv;
    appDetailViewController_gv = [[AppDetailViewController alloc] init];
    [appDetailViewController_gv setNavigationDelegate:self];
    return appDetailViewController_gv;
}

#pragma mark - Top5ListViewController

- (Top5ListViewController*)top5ListViewController
{
    if (top5ListViewController_gv)
        return top5ListViewController_gv;
    top5ListViewController_gv = [[Top5ListViewController alloc] init];
    [top5ListViewController_gv setNavigationDelegate:self];
    return top5ListViewController_gv;
}

#pragma mark - Top5ListViewController

- (AppListViewController*)appListViewController
{
    if (appListViewController_gv)
        return appListViewController_gv;
    appListViewController_gv = [[AppListViewController alloc] init];
    [appListViewController_gv setNavigationDelegate:self];
    return appListViewController_gv;
}

#pragma mark - Property Synthesis

@synthesize navigationController;
@end
