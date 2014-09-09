//
//  Ty_BaseLoadingView.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_BaseLoadingView.h"

@implementation Ty_BaseLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
static Ty_BaseLoadingView *loading;

+(id)loadingViewInit:(UIView*)view{
    
    loading = [[Ty_BaseLoadingView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
    loading.center = CGPointMake(162, 234);
    //    [[UIApplication sharedApplication].delegate.window addSubview:loading];
    [view addSubview:loading];
    NSArray * myImages = [NSArray arrayWithObjects:
                          [UIImage imageNamed:@"loadingimage1.png"],
                          [UIImage imageNamed:@"loadingimage2.png"],
                          [UIImage imageNamed:@"loadingimage3.png"],
                          [UIImage imageNamed:@"loadingimage4.png"],
                          [UIImage imageNamed:@"loadingimage5.png"],
                          [UIImage imageNamed:@"loadingimage6.png"],
                          [UIImage imageNamed:@"loadingimage7.png"]
                          ,nil];
    loading.animationImages = myImages;//将序列帧数组赋给UIImageView的animationImages属性
    loading.animationDuration = 1.5;//设置动画时间
    loading.animationRepeatCount = 0;//设置动画次数 0 表示无限
    [loading startAnimating];//开始播放动画
    
    return loading;
}


+(id)loadingViewRemove{
    
    [loading removeFromSuperview];
    return loading;
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
