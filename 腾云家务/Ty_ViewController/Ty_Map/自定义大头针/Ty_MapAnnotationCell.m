//
//  Ty_MapAnnotationCell.m
//  腾云家务
//
//  Created by AF on 14-7-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MapAnnotationCell.h"

@implementation Ty_MapAnnotationCell
@synthesize imagePhotoView,labContent,labTitle,butClickCell;
@synthesize customStar;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        
        imagePhotoView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        imagePhotoView.layer.borderWidth = 0.3;
        imagePhotoView.layer.borderColor = [[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0f]CGColor];
        [self addSubview:imagePhotoView];
        
        labTitle = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 150, 20)];
        labTitle.textAlignment = NSTextAlignmentLeft;
        [labTitle setFont:FONT15_BOLDSYSTEM];
        [labTitle setBackgroundColor:[UIColor clearColor]];
        [self addSubview:labTitle];
        
        labContent = [[CustomLabel alloc]initWithFrame:CGRectMake(70, 45, 170, 15)];
        [labContent setFont:FONT14_BOLDSYSTEM];
        [labContent setBackgroundColor:[UIColor clearColor]];
        [labContent setVerticalAlignment:UIControlContentVerticalAlignmentBottom];
        [labContent setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:labContent];
        
        
        customStar = [[CustomStar alloc]initWithFrame:CGRectMake(140, 45, 73, 13) Number:5];
        [customStar setUserInteractionEnabled:NO];
        [customStar setCustomStarNumber:0];
        [self addSubview:customStar];
        
        butClickCell = [UIButton buttonWithType:UIButtonTypeCustom];
        butClickCell.frame = self.frame;
        [self addSubview:butClickCell];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
