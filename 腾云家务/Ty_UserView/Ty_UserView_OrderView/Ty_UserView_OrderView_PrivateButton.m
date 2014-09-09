//
//  Ty_UserView_OrderView_PrivateButton.m
//  腾云家务
//
//  Created by lgs on 14-6-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_UserView_OrderView_PrivateButton.h"

@implementation Ty_UserView_OrderView_PrivateButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.exclusiveTouch = YES;
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
