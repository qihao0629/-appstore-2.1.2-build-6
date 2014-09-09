//
//  Ty_UserDetail_userCell.h
//  腾云家务
//
//  Created by 齐 浩 on 14-3-4.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomStar.h"
@interface Ty_UserDetail_userCell : UITableViewCell

@property(nonatomic,strong)UIImageView* headImage;
@property(nonatomic,strong)UIImageView* renzhengImage;
@property(nonatomic,strong)CustomStar* customStar;
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UILabel* priceLabel;
@property(nonatomic,strong)UIButton* yuyueButton;

@end
