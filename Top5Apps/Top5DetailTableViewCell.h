//
//  Top5DetailTableViewCell.h
//  Top5Apps
//
//  Created by Joe Bonniwell on 4/7/12.
//  Copyright (c) 2012 goVertex LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface Top5DetailTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *placeLabel;
@property (nonatomic, retain) UIImageView *appIconImageView;
@property (nonatomic, retain) UILabel *appNameLabel;
@property (nonatomic, retain) UILabel *appMakerLabel;
@property (nonatomic, retain) UILabel *lastUpdatedLabel;
@property (nonatomic, retain) UILabel *viewLabel;

- (void)setNumberOfTop5Lists:(NSInteger)argTop5ListsCount;

@end
