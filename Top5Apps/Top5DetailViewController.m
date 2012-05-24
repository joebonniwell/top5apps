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
    [self setTableView:[[[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f) style:UITableViewStyleGrouped] autorelease]];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    //[[self tableView] setBackgroundColor:[UIColor whiteColor]];
    [[self tableView] setScrollEnabled:NO];
    [[self tableView] setRowHeight:56.0f];
    [[self tableView] setAllowsSelectionDuringEditing:NO];
    
    [[self view] addSubview:[self tableView]];
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self usersTop5])
    {
        [[self navigationItem] setTitle:NSLocalizedString(@"My Top 5", @"My Top 5")];
        [[self navigationItem] setBackBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease]];
        [[self navigationItem] setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonTapped:)] autorelease]];
        
    }
    else
    {
        [[self navigationItem] setTitle:NSLocalizedString(@"XXXXX's Top 5", @"XXXXX's Top 5")];
        [[self navigationItem] setBackBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Top 5" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease]];
        [[self navigationItem] setRightBarButtonItem:nil];
        [[self navigationItem] setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Follow" style:UIBarButtonItemStyleBordered target:self action:@selector(followButtonTapped:)] autorelease]];
    }
    [[self tableView] reloadData];
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

#pragma mark - Button Methods

- (void)editButtonTapped:(id)argSender
{
    [[self tableView] setEditing:YES animated:YES];
    [[self navigationItem] setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped:)] autorelease]];
}

- (void)doneButtonTapped:(id)argSender
{
    [[self tableView] setEditing:NO animated:YES];
    [[self navigationItem] setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonTapped:)] autorelease]];
}

#pragma mark - UITableView Delegate Methods

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"Remove", @"Remove");
}

- (void)tableView:(UITableView *)argTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) 
    {
        case 0:
            if (![self app1])
                [[self navigationDelegate] showAppSearchViewControllerToSelectApp:1];
            else
                [[self navigationDelegate] showAppDetailViewController];
            break;
        case 1:
            if (![self app2])
                [[self navigationDelegate] showAppSearchViewControllerToSelectApp:2];
            else
                [[self navigationDelegate] showAppDetailViewController];
                break;
        case 2:
            if (![self app3])
                [[self navigationDelegate] showAppSearchViewControllerToSelectApp:3];
            else
                [[self navigationDelegate] showAppDetailViewController];
                break;
        case 3:
            if (![self app4])
                [[self navigationDelegate] showAppSearchViewControllerToSelectApp:4];
            else
                [[self navigationDelegate] showAppDetailViewController];
                break;
        case 4:
            if (![self app5])
                [[self navigationDelegate] showAppSearchViewControllerToSelectApp:5];
            else
                [[self navigationDelegate] showAppDetailViewController];
            break;
        default:
            break;
    }
    
    [argTableView deselectRowAtIndexPath:indexPath animated:YES];
        
    //[self setAppSlotBeingEdited:(indexPath.row + 1)];
        
    //[[self navigationDelegate] showAppSearchViewController];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 86.0f)];
    
    // User Avatar Image View
    UIImageView *avatarImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(8.0f, 12.0f, 64.0f, 64.0f)] autorelease];
    [avatarImageView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.1f]];
    [[avatarImageView layer] setCornerRadius:10.0f];
    [avatarImageView setClipsToBounds:YES];
    [avatarImageView setContentMode:UIViewContentModeScaleAspectFill];
    [headerView addSubview:avatarImageView];
    
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *userProfileImagePath = [[searchPaths lastObject] stringByAppendingPathExtension:@"userImage.data"];
    
    UIImage *userProfileImage = [UIImage imageWithContentsOfFile:userProfileImagePath];
    [avatarImageView setImage:userProfileImage];
    
    // User name Label
    UILabel *userNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(82.0f, 8.0f, 230.0f, 30.0f)] autorelease];
    [userNameLabel setText:[NSString stringWithFormat:@"%@'s Top 5 Apps", [[PFUser currentUser] username]]];
    [headerView addSubview:userNameLabel];
    
    // Following Button
    UIButton *followingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [followingButton setFrame:CGRectMake(82.0f, 42.0f, 110.0f, 30.0f)];
    [followingButton setTitle:@"Following XX" forState:UIControlStateNormal];
    [headerView addSubview:followingButton];
    
    
    // Followers Button
    UIButton *followerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [followerButton setFrame:CGRectMake(200.0f, 42.0f, 110.0f, 30.0f)];
    [followerButton setTitle:@"XX Followers" forState:UIControlStateNormal];
    [headerView addSubview:followerButton];
    
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 86.0f;
}

#pragma mark - UITableView DataSource Methods

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    // How to do this...?
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Should also update this action in data in the cloud
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        switch (indexPath.row) 
        {
            case 0:
                [self setApp1:nil];
                break;
            case 1:
                [self setApp2:nil];
                break;
            case 2:
                [self setApp3:nil];
                break;
            case 3:
                [self setApp4:nil];
                break;
            case 4:
                [self setApp5:nil];
                break;
            default:
                break;
        }
        [[self tableView] reloadData];
    }
}

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
    static NSString *Top5AppTableViewCellIdentifier = @"Top5AppTableViewCellIdentifier";
    
    Top5DetailTableViewCell *cell = [argTableView dequeueReusableCellWithIdentifier:Top5AppTableViewCellIdentifier];
    
    if (!cell)
    {
        cell = [[[Top5DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Top5AppTableViewCellIdentifier] autorelease];
    }
    
    PFObject *app = nil;
    
    switch (indexPath.row) 
    {
        case 0:
            app = [[PFUser currentUser] objectForKey:@"app1"];
            break;
        case 1:
            app = [[PFUser currentUser] objectForKey:@"app2"];
            break;
        case 2:
            app = [[PFUser currentUser] objectForKey:@"app3"];
            break;
        case 3:
            app = [[PFUser currentUser] objectForKey:@"app4"];
            break;
        case 4:
            app = [[PFUser currentUser] objectForKey:@"app5"];
            break;
        default:
            break;
    }
    
    [[(Top5DetailTableViewCell*)cell placeLabel] setText:[NSString stringWithFormat:@"#%d", indexPath.row + 1]];
    
    if (app)
    {
        // App Name
        [[(Top5DetailTableViewCell*)cell appNameLabel] setText:[app objectForKey:@"appName"]];
        [[(Top5DetailTableViewCell*)cell appNameLabel] setHidden:NO];
        
        //[[cell appMakerLabel] setText:[app objectForKey:@"appMaker"]];
        
        // Top 5 Count
        [(Top5DetailTableViewCell*)cell setNumberOfTop5Lists:5];
        [[(Top5DetailTableViewCell*)cell lastUpdatedLabel] setHidden:NO];
        [(Top5DetailTableViewCell*)cell setShowsReorderControl:YES];
        
        [[cell textLabel] setHidden:YES];
    }
    else 
    {
        // Should have a mode for this...
        [[cell textLabel] setText:@"Empty"];
        
        // Hide
        //[[cell appNameLabel] setHidden:YES];
        //[[cell top5CountLabel] setHidden:YES];
        [cell setShowsReorderControl:NO];
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
