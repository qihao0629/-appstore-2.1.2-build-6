//
//  SemgentButton.h
//  腾云家务
//
//  Created by 齐 浩 on 14-2-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SemgentButtonDelegate <NSObject>
@required

-(void)SemGentButtonAction:(id)sender;

@end

@interface Ty_UserView_Order_SemgentButton : UIView
@property(nonatomic,strong)UIButton *firstButton;
@property(nonatomic,strong)UIButton *secondButton;
@property(nonatomic,strong)UIButton *thridButton;
@property(nonatomic,strong)id<SemgentButtonDelegate>delegate;
@end

