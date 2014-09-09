//
//  Ty_UPPaySuccessView.m
//  腾云家务
//
//  Created by liu on 14-7-1.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_UPPaySuccessView.h"

@implementation Ty_UPPaySuccessView

@synthesize reqDetailBtn = _reqDetailBtn;

@synthesize messageLabel = _messageLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView *successImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 50, 110, 110)];
        successImageView.image = [UIImage imageNamed:@"UPPay_Success_Image"];
        [self addSubview:successImageView];
        
        UILabel *successLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 200, 220, 20)];
        successLabel.backgroundColor = [UIColor clearColor];
        successLabel.text = @"支付成功！";
        successLabel.textAlignment = NSTextAlignmentCenter;
        successLabel.font = [UIFont systemFontOfSize:14];
      //  [self addSubview:successLabel];
        
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 200, 220, 20)];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.text = @"";
        _messageLabel.textColor = [UIColor colorWithRed:255.0/255 green:142.0/255 blue:86.0/255 alpha:1.0];
        _messageLabel.font = [UIFont boldSystemFontOfSize:18];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_messageLabel];
        
        _reqDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reqDetailBtn.frame = CGRectMake(50, 250, 220, 40);
        [_reqDetailBtn setTitle:@"查看订单详情" forState:UIControlStateNormal] ;
        [_reqDetailBtn setBackgroundImage:JWImageName(@"login") forState:UIControlStateNormal];
        [_reqDetailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _reqDetailBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        [self addSubview:_reqDetailBtn];
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
