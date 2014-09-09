//
//  Ty_UserInfoButton.m
//  腾云家务
//
//  Created by 齐 浩 on 14-2-26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_UserInfoButton.h"

@implementation Ty_UserInfoButton
@synthesize accessoryTypeImage;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        accessoryTypeImage = [[UIImageView alloc]initWithImage:JWImageName(@"home_accessoryType") highlightedImage:JWImageName(@"")];
       
        [self addSubview:accessoryTypeImage];
    }
    return self;
}
+ (Ty_UserInfoButton*)BtnWithType:(UIButtonType)buttonType
{
    Ty_UserInfoButton *btn = [Ty_UserInfoButton buttonWithType:buttonType];
	btn.backgroundColor=[UIColor whiteColor];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn.titleLabel setFont:FONT15_BOLDSYSTEM];
//    btn.layer.borderColor=[CellBackColor CGColor];
//    btn.layer.borderWidth = 1.5;
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    return btn;
}
- (CGRect)backgroundRectForBounds:(CGRect)bounds
{
    [accessoryTypeImage setFrame:CGRectMake(bounds.size.width-18, bounds.origin.y+(bounds.size.height-15)/2, 8, 15)];
	return bounds;
}

- (CGRect)contentRectForBounds:(CGRect)bounds
{
	return bounds;
}

-(CGRect)imageRectForContentRect:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x+6, bounds.origin.y+(bounds.size.height-18)/2, 16, 18);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.origin.x+35, contentRect.origin.y, contentRect.size.width-60, contentRect.size.height);
}
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//	return CGRectMake(contentRect.origin.x, contentRect.origin.y + contentRect.size.height/5*3, contentRect.size.width, contentRect.size.height/5*2);
//}
//
//- (CGRect)imageRectForContentRect:(CGRect)bounds
//{
//    return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height/5*3);
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
