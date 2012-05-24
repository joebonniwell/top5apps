//
//  AppListViewController.m
//  Top5Apps
//
//  Created by Joe Bonniwell on 4/20/12.
//  Copyright (c) 2012 goVertex LLC. All rights reserved.
//

#import "AppListViewController.h"

@interface AppListViewController ()

@property (nonatomic, retain) NSArray *apps;
@property (nonatomic, retain) UITableView *tableView;

@end

@implementation AppListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setTableView:[[[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f) style:UITableViewStyleGrouped] autorelease]];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    [[self view] addSubview:[self tableView]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated
{
    PFQuery *allAppsQuery = [PFQuery queryWithClassName:@"App"];
    
    [allAppsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
         if (!error)
         {
             [self setApps:objects];
             [[self tableView] reloadData];
         }
         else 
         {
             NSLog(@"Error: %@", [error userInfo]);
         }
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDelegate Methods


#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self apps] count];
}

- (UITableViewCell*)tableView:(UITableView*)argTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableViewCellIdentifier = @"TableViewCellIdentifier";
    
    AppListTableViewCell *cell = [argTableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    
    if (!cell)
    {
        cell = [[AppListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
    }
    
    PFObject *app = [[self apps] objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[app objectForKey:@"appName"]];
    
    return cell;
}

#pragma mark - Property Synthesis

@synthesize apps;
@synthesize tableView;
@synthesize navigationDelegate;
@end
