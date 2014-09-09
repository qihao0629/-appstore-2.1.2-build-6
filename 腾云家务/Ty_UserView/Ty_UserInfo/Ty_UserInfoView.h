//
//  Ty_UserInfoView.h
//  腾云家务
//
//  Created by 齐 浩 on 14-2-26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomStar.h"
#import "CustomLabel.h"
#import "Ty_UserInfoButton.h"
@interface Ty_UserInfoView : UIView
@property(nonatomic,strong)UIImageView* HeadImage;
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UILabel* typeLabel;
@property(nonatomic,strong)CustomStar* customStar;
@property(nonatomic,strong)UILabel* ageLabel;
@property(nonatomic,strong)UILabel* censusLabel;
@property(nonatomic,strong)UILabel* sumNumberLabel;
@property(nonatomic,strong)UILabel* IdCardLabel;
@property(nonatomic,strong)CustomLabel* priceLabel;
@property(nonatomic,strong)UILabel* workTypeLabel;
@property(nonatomic,strong)Ty_UserInfoButton* telButton;
-(void)setLoadView;
@end
