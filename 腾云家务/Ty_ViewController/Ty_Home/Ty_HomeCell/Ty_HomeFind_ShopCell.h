//
//  Ty_HomeFind_ShopCell.h
//  腾云家务
//
//  Created by 齐 浩 on 14-6-11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"
#import "CustomStar.h"

@interface Ty_HomeFind_ShopCell : UITableViewCell

@property(nonatomic,strong)UIImageView* headImage;
@property(nonatomic,strong)UILabel* shopNameLabel;
@property(nonatomic,strong)UILabel* typeLabel;
@property(nonatomic,strong)CustomStar* customStar;
@property(nonatomic,strong)UILabel* distanceLabel;
@property(nonatomic,strong)UILabel* areaLabel;
@property(nonatomic,strong)UILabel* serviceNumLabel;
@property(nonatomic,strong)CustomLabel* priceLabel;

-(void)setLoadView;
@end
