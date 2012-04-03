//
//  AppSearchViewController.m
//  Top5Apps
//
//  Created by Joe Bonniwell on 4/2/12.
//  Copyright (c) 2012 goVertex LLC. All rights reserved.
//

#import "AppSearchViewController.h"

@interface AppSearchViewController ()

@end

@implementation AppSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self view] setBackgroundColor:[UIColor darkGrayColor]];
    [[self navigationItem] setTitle:NSLocalizedString(@"Search Apps", @"Search Apps")];
    
    // Create a search bar
    
    [self setSearchBar:[[[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)] autorelease]];
    [[self searchBar] setDelegate:self];
    [[self view] addSubview:[self searchBar]];
    
    [self setSearchDisplayController:[[[UISearchDisplayController alloc] initWithSearchBar:[self searchBar] contentsController:self] autorelease]];
    
    [[self searchDisplayController] setDelegate:self];
    [[self searchDisplayController] setSearchResultsDataSource:self];
    [[self searchDisplayController] setSearchResultsDelegate:self];
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

- (void)viewDidAppear:(BOOL)animated
{
    [[self searchBar] becomeFirstResponder];
}

#pragma mark - UITableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    // Get App Data from JSON...
    
    // Send a message to the navigation delegate that the user selected an app, include app information...
    
    // Nav delegate to pass the information back into the top5detailviewcontroller
}

#pragma mark - UITableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self appResults] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *appTableViewCellIdentifier = @"AppTableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:appTableViewCellIdentifier];
    if (!cell) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appTableViewCellIdentifier] autorelease];
    }
    
    // Configure the cell from the app data...
    [[cell textLabel] setText:[[[self appResults] objectAtIndex:indexPath.row] valueForKey:@"trackName"]];
    
    return cell;
}

#pragma mark - UISearchDisplayController Delegate Methods

#pragma mark - UISearchBar Delegate Methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self setAppResults:[NSArray array]];
    [[[self searchDisplayController] searchResultsTableView] reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)argSearchBar
{
    // Cancel any in progress searches...
    if ([self searchConnection])
    {
        [[self searchConnection] cancel];
        [self setSearchConnection:nil];
        [self setSearchData:nil];
    }
    
    NSLog(@"Commence searching appstore for %@", [argSearchBar text]);
    
    NSString *searchURLString = [NSString stringWithFormat:@"http://itunes.apple.com/search?entity=software&country=US&term=%@", [argSearchBar text]];
    NSURL *searchURL = [NSURL URLWithString:searchURLString];
    NSURLRequest *searchURLRequest = [NSURLRequest requestWithURL:searchURL];
    [self setSearchData:[NSMutableData data]];
    [self setSearchConnection:[NSURLConnection connectionWithRequest:searchURLRequest delegate:self]];
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self setSearchData:[NSMutableData data]];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [[self searchData] appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    NSDictionary *searchResults = [NSJSONSerialization JSONObjectWithData:[self searchData] options:0 error:&error];
    
    [self setSearchData:nil];
    [self setSearchConnection:nil];
    
    if (!searchResults)
    {
        NSLog(@"JSON Error: %@", [error localizedDescription]);
        return;
    }
        
    if ([[searchResults objectForKey:@"resultCount"] integerValue] > 0)
    {
        [self setAppResults:[searchResults objectForKey:@"results"]];
        [[[self searchDisplayController] searchResultsTableView] reloadData];
    }
    else 
    {
        [self setAppResults:[NSArray array]];
        [[[self searchDisplayController] searchResultsTableView] reloadData];
        // Set no search results notification...
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self setSearchData:nil];
    [self setSearchConnection:nil];
    
    NSLog(@"Search failed: %@", [error localizedDescription]);
}

#pragma mark - Property Synthesis

@synthesize navigationDelegate;
@synthesize searchDisplayController;
@synthesize searchBar;

@synthesize appResults;

@synthesize searchConnection;
@synthesize searchData;
@end
