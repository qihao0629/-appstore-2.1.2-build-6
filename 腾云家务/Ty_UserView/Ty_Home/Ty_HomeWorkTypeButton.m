//
//  HomeWorkTypeButton.m
//  腾云家务
//
//  Created by 齐 浩 on 14-1-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HomeWorkTypeButton.h"
#define BianColor [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]

@implementation Ty_HomeWorkTypeButton
@synthesize guid;
@synthesize kaifangYesOrNO;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.guid = @"";
        self.kaifangYesOrNO = @"0";
        [self setExclusiveTouch:YES];
        [self.titleLabel setFont:FONT13_BOLDSYSTEM];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor colorWithRed:106/255.0 green:106/255.0 blue:106/255.0 alpha:1]];
//        [self setBackgroundImage:JWImageName(@"HomeWorkTypeButtonImage") forState:UIControlStateNormal];
        
//        self.layer.masksToBounds = YES;
//        //给图层添加一个有色边框
//        self.layer.borderWidth = 0.0;
//        self.layer.borderColor = [BianColor CGColor];

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
