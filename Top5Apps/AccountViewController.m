//
//  AccountViewController.m
//  Top5Apps
//
//  Created by goVertex on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AccountViewController.h"

@implementation AccountViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    [[self view] setBackgroundColor:[UIColor darkGrayColor]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Welcome Banner
    
    // Facebook Button
    UIButton *facebookButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [facebookButton setFrame:CGRectMake(10.0f, 60.0f, 300.0f, 60.0f)];
    [facebookButton setTitle:@"Facebook" forState:UIControlStateNormal];
    [facebookButton addTarget:self action:@selector(facebookButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:facebookButton];
    
    // Twitter Button...
    
    // Email Button...
    
    // Just Browse Button...
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

#pragma mark - Button Actions

- (void)facebookButtonTapped
{
    NSLog(@"Facebook button tapped");
        
    [PFFacebookUtils logInWithPermissions:nil block:^(PFUser *user, NSError *error) 
    {
        NSLog(@"Completed");
        if (!user) 
        {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
            
            // No account created... send alert view.... say that you are now using a browse only mode
        } 
        else if (user.isNew) 
        {
            NSLog(@"User signed up and logged in through Facebook!");
            [[self parentViewController] dismissViewControllerAnimated:YES completion:nil];
            // Dismiss the accountviewcontroller and go to the mytop5app, editing mode
        } 
        else 
        {
            NSLog(@"User logged in through Facebook!");
            
            
            if (![self parentViewController])
                NSLog(@"No parent view controller");
            // Go to main menu.....
            //[[self parentViewController] dismissViewControllerAnimated:YES completion:nil];
            [[self navigationDelegate] dismissAccountViewController];
            // dismiss self...
        }
    }];
    
    NSLog(@"Done");
}

#pragma mark - Property Synthesis

@synthesize navigationDelegate;

@end
