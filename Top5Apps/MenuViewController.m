//
//  MenuViewController.m
//  Top5Apps
//
//  Created by goVertex on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

@implementation MenuViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
- (void)loadView
{
}
*/


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationItem] setTitle:NSLocalizedString(@"Top 5 Apps", @"Top 5 Apps")];
    
    [[self view] setBackgroundColor:[UIColor darkGrayColor]];
    
    // Featured Top 5 List
    
    // Me Button
    [self setMeButton:[UIButton buttonWithType:UIButtonTypeRoundedRect]];
    [[self meButton] setFrame:CGRectMake(10.0f, 100.0f, 140.0f, 140.0f)];
    [[self meButton] setTitle:NSLocalizedString(@"Me", @"Me") forState:UIControlStateNormal];
    [[self meButton] addTarget:self action:@selector(meButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:[self meButton]];
    
    // Friends Button
    [self setFriendsButton:[UIButton buttonWithType:UIButtonTypeRoundedRect]];
    [[self friendsButton] setFrame:CGRectMake(170.0f, 100.0f, 140.0f, 140.0f)];
    [[self friendsButton] setTitle:NSLocalizedString(@"Friends", @"Friends") forState:UIControlStateNormal];
    [[self friendsButton] addTarget:self action:@selector(friendsButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:[self friendsButton]];
    
    // Everyone Button
    [self setEveryoneButton:[UIButton buttonWithType:UIButtonTypeRoundedRect]];
    [[self everyoneButton] setFrame:CGRectMake(10.0f, 260.0f, 140.0f, 140.0f)];
    [[self everyoneButton] setTitle:NSLocalizedString(@"Everyone", @"Everyone") forState:UIControlStateNormal];
    [[self everyoneButton] addTarget:self action:@selector(everyoneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:[self everyoneButton]];
    
    // Apps Button
    [self setAppsButton:[UIButton buttonWithType:UIButtonTypeRoundedRect]];
    [[self appsButton] setFrame:CGRectMake(170.0f, 260.0, 140.0f, 140.0f)];
    [[self appsButton] setTitle:NSLocalizedString(@"Apps", @"Apps") forState:UIControlStateNormal];
    [[self appsButton] addTarget:self action:@selector(appsButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:[self appsButton]];
    
}

- (void)viewWillAppear:(BOOL)animated
{

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

#pragma mark - Button Tapped Methods

- (void)meButtonTapped
{
    NSLog(@"Me button tapped");
    
    if ([PFUser currentUser])
    {
        // navigate to the Top5DetailViewController with editable set to YES
        [[self navigationDelegate] showUsersTop5ViewController];
    }
    else
    {
        // navigate to the accounts view controller with an explanation label
        
    }
}

- (void)friendsButtonTapped
{
    NSLog(@"Friends button tapped");
    
    if ([PFUser currentUser])
    {
        // navigate to the Top5DetailViewController with editable set to YES
    }
    else
    {
        // navigate to the accounts view controller with an explanation label
    }
}

- (void)everyoneButtonTapped
{
    NSLog(@"Everyone button tapped");
    
    // Navigate to the Top5ListViewController with everyone dataset...
}

- (void)appsButtonTapped
{
    NSLog(@"Apps button tapped");
    
    // Navigate to the AppListViewController
}

#pragma mark - Property Synthesis

@synthesize meButton;
@synthesize friendsButton;
@synthesize everyoneButton;
@synthesize appsButton;

@synthesize navigationDelegate;
@end
