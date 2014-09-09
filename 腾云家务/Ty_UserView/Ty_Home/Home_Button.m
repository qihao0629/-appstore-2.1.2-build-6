//
//  HomeButton.m
//  腾云家务
//
//  Created by 齐 浩 on 13-9-23.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "Home_Button.h"
#import <QuartzCore/QuartzCore.h>

#define BianColor [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1]
#define BackGroudColor [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]

@implementation Home_Button
@synthesize workTypeImage;
@synthesize workTypeLabel;
@synthesize ShopLabel;
@synthesize PartTimeLabel;
@synthesize prayImage;
@synthesize guid;
@synthesize change;
@synthesize jiantouImage;
@synthesize countString;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.guid = @"";
        self.countString = @"";
        change = NO;
        [self setExclusiveTouch:YES];
        [self setBackgroundColor:BackGroudColor];
        self.workTypeImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, 11, 47, 47)];
        jiantouImage = [[UIImageView alloc]initWithFrame:CGRectMake(29, frame.size.height-7, 12, 7)];
        jiantouImage.hidden=YES;
        [jiantouImage setImage:JWImageName(@"home_workTypeJiantou")];
        self.workTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.workTypeImage.frame.origin.x+self.workTypeImage.frame.size.width+6, 11, 90, 15)];
        [self.workTypeLabel setFont:FONT15_BOLDSYSTEM];
        [self.workTypeLabel setBackgroundColor:[UIColor clearColor]];
        self.workTypeLabel.highlightedTextColor=[UIColor whiteColor];
        self.ShopLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(self.workTypeImage.frame.origin.x+self.workTypeImage.frame.size.width+6, 32, 90, 11)];
        [self.ShopLabel setFont:FONT11_SYSTEM];
        
        self.PartTimeLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(self.workTypeImage.frame.origin.x+self.workTypeImage.frame.size.width+6, 50, 90, 11)];
        [self.PartTimeLabel setFont:FONT11_SYSTEM];
        
        [self addSubview:workTypeImage];
        [self addSubview:workTypeLabel];
        [self addSubview:ShopLabel];
        [self addSubview:PartTimeLabel];
        [self addSubview:jiantouImage];
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
