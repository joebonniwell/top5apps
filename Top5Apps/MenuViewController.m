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
    
    [self setTableView:[[[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f) style:UITableViewStyleGrouped] autorelease]];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    [[self tableView] setScrollEnabled:NO];
    [[self view] addSubview:[self tableView]];
    
    // Featured Top 5 List
    /*
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
    */
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

#pragma mark - UITableView Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        return 70.0f;
    return 50.0f;
}

- (void)tableView:(UITableView*)argTableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [argTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        [[self navigationDelegate] showTop5DetailViewController];
    }
    else 
    {
        switch (indexPath.row) 
        {
            case 0:
                // Navigate to the user's top 5
                [[self navigationDelegate] showUsersTop5ViewController];
                break;
            case 1:
                // Navigate to all people
                [[self navigationDelegate] showTop5ListViewController];
                break;
            case 2:
                // Navigate to all apps vc
                [[self navigationDelegate] showAppListViewController];
                break;
            case 3: // Navigate to account view controller
                [[self navigationDelegate] showAccountViewController];
                break;
            default:
                break;
        }
    }
}

#pragma mark - UITableView DataSource Methods

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Featured Top 5";
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 1;
    return 4;
}

- (UITableViewCell*)tableView:(UITableView*)argTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FeaturedProfileTableViewCellIdentifier = @"FeaturedProfileTableViewCellIdentifier";
    static NSString *MenuItemTableViewCellIdentifier = @"MenuItemTableViewCellIdentifier";
    
    UITableViewCell *cell;
    if (indexPath.section == 0)
        cell = [argTableView dequeueReusableCellWithIdentifier:FeaturedProfileTableViewCellIdentifier];
    else
        cell = [argTableView dequeueReusableCellWithIdentifier:MenuItemTableViewCellIdentifier];
    
    if (!cell)
    {
        if (indexPath.section == 0)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FeaturedProfileTableViewCellIdentifier] autorelease];
                        
            // User Avatar
            UIImageView *userAvatarImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 5.0f, 60.0f, 60.0f)] autorelease];
            [userAvatarImageView setBackgroundColor:[UIColor grayColor]];
            [[userAvatarImageView layer] setCornerRadius:8.0f];
            [userAvatarImageView setClipsToBounds:YES];
            [[cell contentView] addSubview:userAvatarImageView];
            
            // User Name Label
            UILabel *userNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(70.0f, 5.0f, 200.0f, 30.0f)] autorelease];
            [userNameLabel setText:@"Featured User's Top 5"];
            [[cell contentView] addSubview:userNameLabel];
            
            
            // Last Updated Label
            
            
            // Following Label
            
            
            // Followers Label
            
        }
        else 
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MenuItemTableViewCellIdentifier] autorelease];
        }
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    if (indexPath.section == 0)
    {
        
    }
    else 
    {
        switch (indexPath.row) 
        {
            case 0:
                [[cell textLabel] setText:@"My Top 5"];
                break;
            case 1:
                [[cell textLabel] setText:@"Browse Top 5s"];
                break;
            case 2:
                [[cell textLabel] setText:@"Browse Apps"];
                break;
            case 3:
                [[cell textLabel] setText:@"My Account"];
                break;
            default:
                break;
        }
    }
    
    return cell;
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

@synthesize tableView;

@synthesize meButton;
@synthesize friendsButton;
@synthesize everyoneButton;
@synthesize appsButton;

@synthesize navigationDelegate;
@end
