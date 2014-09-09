//
//  RefreshView.m
//  腾云家务
//
//  Created by 齐 浩 on 13-10-14.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "RefreshView.h"

@implementation RefreshView

@synthesize _netMind;
@synthesize _messageLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.tag = 555;
        
        _netMind = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _netMind.center = CGPointMake(self.bounds.size.width / 2 - 70, self.bounds.size.height / 2-5);
        //  _netMind.backgroundColor = [UIColor grayColor];
        //  _netMind.color = [UIColor grayColor];
        [self addSubview:_netMind];
        
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width / 2 - 40, self.bounds.size.height / 2 - 15, 100, 20)];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.textColor = [UIColor grayColor];
        _messageLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:_messageLabel];
    }
    return self;
}


- (void)statAnimation
{
    if (!_netMind.isAnimating)
    {
        [_netMind startAnimating];
    }
}

- (void)stopAnimation
{
    if (_netMind.isAnimating)
    {
        [_netMind stopAnimating];
    }
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
