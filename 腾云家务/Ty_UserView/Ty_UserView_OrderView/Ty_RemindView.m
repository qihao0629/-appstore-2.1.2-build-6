//
//  Ty_RemindView.m
//  腾云家务
//
//  Created by lgs on 14-8-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_RemindView.h"

@implementation Ty_RemindView
@synthesize remindImageView;
@synthesize remindLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadCustom];
    }
    return self;
}

-(void)loadCustom
{
    remindImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 0, 220, 20)];
    [remindImageView setBackgroundColor:[UIColor grayColor]];
    
    remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, remindImageView.frame.size.width, 14)];
    remindLabel.textColor = [UIColor whiteColor];
    [remindLabel setFont:FONT14_BOLDSYSTEM];
    remindLabel.textAlignment = NSTextAlignmentCenter;
    [remindLabel setBackgroundColor:[UIColor clearColor]];
    
    [remindImageView addSubview:remindLabel];
    [self addSubview:remindImageView];
}

-(void)showInView:(UIView *)_view andTime:(float)_time
{
    [_view addSubview:self];
    
    [_view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:_time];
}
-(void)removeFromSuperview
{
    [self removeFromSuperview];
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
