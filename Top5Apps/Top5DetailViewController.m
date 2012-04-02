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

#pragma mark - UITableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableViewCellIdentifier = @"TableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier] autorelease];
        [cell setBackgroundColor:[UIColor darkGrayColor]];
        [[cell textLabel] setTextColor:[UIColor whiteColor]];
    }
    
    [[cell textLabel] setText:[NSString stringWithFormat:@"#%d App", [indexPath row]]];
    
    return cell;
}

#pragma mark - Property Synthesis

@synthesize tableView;

@synthesize usersTop5;
@synthesize top5Apps;

@end
