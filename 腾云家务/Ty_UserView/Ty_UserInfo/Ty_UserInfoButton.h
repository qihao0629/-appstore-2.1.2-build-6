//
//  Ty_UserInfoButton.h
//  腾云家务
//
//  Created by 齐 浩 on 14-2-26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ty_UserInfoButton : UIButton
+ (Ty_UserInfoButton*)BtnWithType:(UIButtonType)buttonType;
@property(nonatomic,strong)UIImageView* accessoryTypeImage;
@end
