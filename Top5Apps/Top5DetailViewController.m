//
//  Top5DetailViewController.m
//  Top5Apps
//
//  Created by goVertex on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Top5DetailViewController.h"

@implementation Top5DetailViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self view] setBackgroundColor:[UIColor darkGrayColor]];
    
    // TableView
    [self setTableView:[[[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f) style:UITableViewStylePlain] autorelease]];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    [[self tableView] setBackgroundColor:[UIColor darkGrayColor]];
    [[self tableView] setScrollEnabled:NO];
    [[self view] addSubview:[self tableView]];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableView Delegate Methods

- (void)tableView:(UITableView *)argTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [argTableView deselectRowAtIndexPath:indexPath animated:YES];
        
    [self setAppSlotBeingEdited:(indexPath.row + 1)];
        
    [[self navigationDelegate] showAppSearchViewController];
}

#pragma mark - UITableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)argTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableViewCellIdentifier = @"TableViewCellIdentifier";
    
    UITableViewCell *cell = [argTableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier] autorelease];
        [cell setBackgroundColor:[UIColor darkGrayColor]];
        [[cell textLabel] setTextColor:[UIColor whiteColor]];
    }
    
    NSLog(@"Cell for row: %d", indexPath.row);
    switch (indexPath.row) 
    {
        case 0:
        {
            if ([self app1])
                [[cell textLabel] setText:[[self app1] objectForKey:@"appName"]];
            else 
                [[cell textLabel] setText:@"#1 - No App Selected"];
            break;
        }
        case 1:
        {
            if ([self app2])
                [[cell textLabel] setText:[[self app2] objectForKey:@"appName"]];
            else 
                [[cell textLabel] setText:@"#2 - No App Selected"];
            break;
        }
        case 2:
        {
            if ([self app3])
                [[cell textLabel] setText:[[self app3] objectForKey:@"appName"]];
            else 
                [[cell textLabel] setText:@"#3 - No App Selected"];
            break;
        }
        case 3:
        {
            if ([self app4])
                [[cell textLabel] setText:[[self app4] objectForKey:@"appName"]];
            else 
                [[cell textLabel] setText:@"#4 - No App Selected"];
            break;
        }
        case 4:
        {
            if ([self app5])
                [[cell textLabel] setText:[[self app5] objectForKey:@"appName"]];
            else 
                [[cell textLabel] setText:@"#5 - No App Selected"];
            break;
        }
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Property Synthesis

@synthesize appSlotBeingEdited;

@synthesize navigationDelegate;
@synthesize tableView;

@synthesize usersTop5;

@synthesize app1;
@synthesize app2;
@synthesize app3;
@synthesize app4;
@synthesize app5;

@end
