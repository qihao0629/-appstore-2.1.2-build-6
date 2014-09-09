//
//  TYNavigationController.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYNavigationController.h"

@implementation TYNavigationController
@synthesize leftBarButton,rightBarButton;
@synthesize titleView,titleLabel,navigationBar,navigationBarHidden,topViewController;
//@synthesize viewControllers;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        self.userInteractionEnabled = YES;
        
        leftBarButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBarButton setFrame:CGRectMake(0, self.frame.size.height-44, 80, 44)];
        [leftBarButton.titleLabel setFont:FONT15_BOLDSYSTEM];
        [leftBarButton setExclusiveTouch:YES];

        
        rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBarButton setFrame:CGRectMake(self.frame.size.width-80, self.frame.size.height-44, 80, 44)];
        [rightBarButton.titleLabel setFont:FONT15_BOLDSYSTEM];
        [rightBarButton setExclusiveTouch:YES];
        
        titleView = [[UIView alloc]initWithFrame:CGRectMake(80, self.frame.size.height-44, self.frame.size.width-160, 44)];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, titleView.frame.size.width, titleView.frame.size.height)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setTextColor:[UIColor whiteColor]];
        titleLabel.adjustsFontSizeToFitWidth = YES;

        [titleLabel setFont:FONT20_BOLDSYSTEM];
        [titleView addSubview:titleLabel];
        
        [self addSubview:leftBarButton];
        [self addSubview:rightBarButton];
        [self addSubview:titleView];
    }
    return self;

}

-(void)setTitleView:(UIView *)_titleView{
    
    [titleView removeFromSuperview];
    UIView* view = _titleView;
    [view setFrame:CGRectMake((self.frame.size.width-_titleView.frame.size.width)/2, self.frame.size.height-44, _titleView.frame.size.width, 44)];
    [self addSubview:view];
}

-(NSArray* )viewControllers
{
    return [TYNAVIGATION viewControllerArray];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)isAnimation
{
    [TYNAVIGATION pushViewController:viewController withAnimation:isAnimation];
}
- (void)popViewControllerAnimated:(BOOL)isAnimation
{
    [TYNAVIGATION popViewControllerWithAnimation:isAnimation];
}
- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)isAnimation
{
    [TYNAVIGATION popToViewController:viewController animated:isAnimation];
}
- (void)popToRootViewControllerAnimated:(BOOL)isAnimation
{
    [TYNAVIGATION popToRootViewControllerAnimated:isAnimation];
}
- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{

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
