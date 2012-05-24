//
//  Top5DetailTableViewCell.m
//  Top5Apps
//
//  Created by Joe Bonniwell on 4/7/12.
//  Copyright (c) 2012 goVertex LLC. All rights reserved.
//

#import "Top5DetailTableViewCell.h"

@implementation Top5DetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        // Top 5 Place Label
        [self setPlaceLabel:[[[UILabel alloc] initWithFrame:CGRectMake(10.0f, 3.0f, 20.0f, 50.0f)] autorelease]];
        [[self placeLabel] setBackgroundColor:[UIColor whiteColor]];
        [[self placeLabel] setTextColor:[UIColor darkGrayColor]];
        [[self contentView] addSubview:[self placeLabel]];
        
        // Icon ImageView
        [self setAppIconImageView:[[[UIImageView alloc] initWithFrame:CGRectMake(40.0f, 3.0f, 50.0f, 50.0f)] autorelease]];
        [[self appIconImageView] setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.1f]];
        [[[self appIconImageView] layer] setCornerRadius:9.0f];
        [[self appIconImageView] setClipsToBounds:YES];
        [[self appIconImageView] setContentMode:UIViewContentModeScaleAspectFill];
        [[self contentView] addSubview:[self appIconImageView]];
        
        // App Name Label
        [self setAppNameLabel:[[[UILabel alloc] initWithFrame:CGRectMake(98.0f, 5.0f, 170.0f, 30.0f)] autorelease]];
        [[self appNameLabel] setFont:[UIFont boldSystemFontOfSize:20.0f]];
        [[self appNameLabel] setTextColor:[UIColor darkGrayColor]];
        //[[self appNameLabel] setBackgroundColor:[UIColor clearColor]];
        [[self contentView] addSubview:[self appNameLabel]];
        
        // View Label
        [self setViewLabel:[[[UILabel alloc] initWithFrame:CGRectMake(258.0f, 21.0f, 30.0f, 12.0f)] autorelease]];
        [[self viewLabel] setText:@"View"];
        [[self viewLabel] setFont:[UIFont systemFontOfSize:12.0f]];
        [[self viewLabel] setTextColor:[UIColor lightGrayColor]];
        [self addSubview:[self viewLabel]];
         
        // Last Updated Label
        [self setLastUpdatedLabel:[[[UILabel alloc] initWithFrame:CGRectMake(98.0f, 31.0f, 170.0f, 20.0f)] autorelease]];
        [[self lastUpdatedLabel] setFont:[UIFont systemFontOfSize:12.0f]];
        [[self lastUpdatedLabel] setTextColor:[UIColor grayColor]];
        [[self contentView] addSubview:[self lastUpdatedLabel]];
        
        // Disclosure Icon
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        // For a user's top 5 cell... this should be something with a label of "change"
        // For somebody else's top 5 cell, this could be a disclosure indicator...
        
    }
    return self;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing)
        [[self viewLabel] setHidden:YES];
    else
        [[self viewLabel] setHidden:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNumberOfTop5Lists:(NSInteger)argTop5ListsCount
{
    if (argTop5ListsCount == 1)
        [[self lastUpdatedLabel] setText:[NSString stringWithFormat:@"Found in %d top 5", argTop5ListsCount]];
    else
        [[self lastUpdatedLabel] setText:[NSString stringWithFormat:@"Found in %d top 5's", argTop5ListsCount]];
}

- (void)configureForApp
{
    // Hide big label
    // Show everything else including disclosure indicator...
}

- (void)configureForNoApp
{
    // Hide all labels except a big one saying no app selected... also get rid of disclosure indicator
}

#pragma mark - Property Synthesis

@synthesize placeLabel;
@synthesize appIconImageView;
@synthesize appNameLabel;
@synthesize appMakerLabel;
@synthesize lastUpdatedLabel;
@synthesize viewLabel;

@end
