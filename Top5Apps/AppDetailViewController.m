//
//  AppDetailViewController.m
//  Top5Apps
//
//  Created by Joe Bonniwell on 4/20/12.
//  Copyright (c) 2012 goVertex LLC. All rights reserved.
//

#import "AppDetailViewController.h"

@interface AppDetailViewController ()

@end

@implementation AppDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationItem] setTitle:@"App Detail"];
    
	// Do any additional setup after loading the view.
    
    // App Icon Image View
    
    // App Name Label
    
    // App Maker Label
    
    // Star rating Image View
    
    // Ratings Label
    
    // View on AppStore Button
    
    // Add to My Top 5 Button
    
    // Share with Friend Button
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f) style:UITableViewStyleGrouped];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    [[self view] addSubview:tableView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDelegate Methods

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) 
    {
        case 0:
            return 2;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        default:
            break;
    } 
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableViewCellIdentifier = @"TableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier] autorelease];
    }
    
    return cell;
}

@synthesize navigationDelegate;
@end
