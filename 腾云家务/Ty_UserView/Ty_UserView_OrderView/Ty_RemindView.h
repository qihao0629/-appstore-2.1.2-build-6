//
//  Ty_RemindView.h
//  腾云家务
//
//  Created by lgs on 14-8-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ty_RemindView : UIView
{
    
}
@property(nonatomic,strong) UILabel * remindLabel;
@property(nonatomic,strong) UIImageView * remindImageView;

-(void)showInView:(UIView *)_view andTime:(float)_time;
@end
