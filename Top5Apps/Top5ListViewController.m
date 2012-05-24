//
//  Top5ListViewController.m
//  Top5Apps
//
//  Created by Joe Bonniwell on 4/21/12.
//  Copyright (c) 2012 goVertex LLC. All rights reserved.
//

#import "Top5ListViewController.h"

@interface Top5ListViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *usersArray;

@end

@implementation Top5ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[self navigationItem] setTitle:@"Top 5 Lists"];
    
    [self setTableView:[[[UITableView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, 366.0f) style:UITableViewStyleGrouped] autorelease]];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    [[self view] addSubview:[self tableView]];
    
    // Add filter bar
    
    //UIToolbar *filterBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    ///[filterBar setTintColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.5f alpha:1.0f]];
    //;
    
    UISegmentedControl *filterControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Item1", @"Item2", @"Item3", nil]];
    [filterControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [filterControl setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 36.0f)];
    [filterControl setTintColor:[UIColor blueColor]];
    [[self view] addSubview:filterControl];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated
{
    PFQuery *appUsersQuery = [PFQuery queryForUser];
    
    [appUsersQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             NSLog(@"Found %d Users", [objects count]);
             [self setUsersArray:objects];
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

#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self usersArray] count];
}

- (UITableViewCell*)tableView:(UITableView*)argTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableViewCellIdentifier = @"TableViewCellIdentifier";
    
    UITableViewCell *cell = [argTableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier] autorelease];
    }

    PFUser *user = [[self usersArray] objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[user username]];
    
    return cell;
}


@synthesize tableView;
@synthesize navigationDelegate;
@synthesize usersArray;

@end
