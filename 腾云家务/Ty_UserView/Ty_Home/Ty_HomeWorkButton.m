//
//  Ty_HomeWorkButton.m
//  腾云家务
//
//  Created by 齐 浩 on 14-7-1.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HomeWorkButton.h"

@implementation Ty_HomeWorkButton
@synthesize workGuid,workName;
@synthesize firstworkName,firstworkGuid;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        workName = @"";
        workGuid = @"";
        firstworkGuid = @"";
        firstworkName = @"";
        [self.titleLabel setFont:FONT13_BOLDSYSTEM];
        [self setTitleColor:text_grayColor forState:UIControlStateNormal];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self setBackgroundColor:view_BackGroudColor];
        
    }
    return self;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.origin.x, contentRect.origin.y+75, 80, 20);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.origin.x+8, contentRect.origin.y+8, 63, 63);
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
