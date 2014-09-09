//
//  CustomStar.h
//  腾云家务
//
//  Created by 齐 浩 on 13-9-25.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomStarDelegate <NSObject>
@optional
-(void)CustomStarDelegateAction:(int)_selectNumber and:(id)_sender;

@end

@interface CustomStar : UIView

@property(nonatomic,assign)int number;
@property(nonatomic,strong)id<CustomStarDelegate>delegate;
-(void)ClickButton:(UIButton* )sender;
-(id)initWithFrame:(CGRect)frame Number:(int)_number;
-(void)setCustomStarNumber:(float)_number;
-(void)setEvaluateStarNumber:(int)_number;
@end


