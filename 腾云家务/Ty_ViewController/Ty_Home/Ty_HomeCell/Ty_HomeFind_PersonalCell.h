//
//  Ty_HomeFind_PersonalCell.h
//  腾云家务
//
//  Created by 齐 浩 on 14-6-11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomStar.h"
#import "CustomLabel.h"
@interface Ty_HomeFind_PersonalCell : UITableViewCell
@property(nonatomic,strong)UIImageView* headImage;
@property(nonatomic,strong)UILabel* personalNameLabel;
@property(nonatomic,strong)UILabel* typeLabel;
@property(nonatomic,strong)CustomStar* customStar;
@property(nonatomic,strong)UILabel* serviceNumLabel;
@property(nonatomic,strong)CustomLabel* customLable;
@property(nonatomic,strong)CustomLabel* priceLabel;
-(void)setLoadView;
@end
