//
//  SemgentButton.m
//  腾云家务
//
//  Created by 齐 浩 on 14-2-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_UserView_Order_SemgentButton.h"

@implementation Ty_UserView_Order_SemgentButton
@synthesize firstButton,secondButton,thridButton;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [firstButton setFrame:CGRectMake(0, 0, frame.size.width/3, frame.size.height)];
        [firstButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [firstButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [firstButton setBackgroundImage:JWImageName(@"button_select") forState:UIControlStateNormal];
        [firstButton.titleLabel setFont:FONT14_BOLDSYSTEM];
        [firstButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [firstButton setTag:1];

        secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [secondButton setFrame:CGRectMake(frame.size.width/3, 0, frame.size.width/3, frame.size.height)];
        [secondButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [secondButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [secondButton setBackgroundImage:JWImageName(@"button_unselect") forState:UIControlStateNormal];
        [secondButton.titleLabel setFont:FONT14_BOLDSYSTEM];
        [secondButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [secondButton setTag:2];
        
        thridButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [thridButton setFrame:CGRectMake(frame.size.width/3*2, 0, frame.size.width/3, frame.size.height)];
        [thridButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [thridButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [thridButton setBackgroundImage:JWImageName(@"button_unselect") forState:UIControlStateNormal];
        [thridButton.titleLabel setFont:FONT14_BOLDSYSTEM];
        [thridButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [thridButton setTag:3];
        
        [self addSubview:firstButton];
        [self addSubview:secondButton];
        [self addSubview:thridButton];
    }
    return self;
}
-(void)buttonAction:(id)sender
{
    [self loadButtonImage];
    [sender setBackgroundImage:JWImageName(@"button_select") forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if (delegate) {
        [delegate SemGentButtonAction:sender];
    }
}
-(void)loadButtonImage
{
    [firstButton setBackgroundImage:JWImageName(@"button_unselect") forState:UIControlStateNormal];
    [firstButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [secondButton setBackgroundImage:JWImageName(@"button_unselect") forState:UIControlStateNormal];
    [secondButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [thridButton setBackgroundImage:JWImageName(@"button_unselect") forState:UIControlStateNormal];
    [thridButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
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
