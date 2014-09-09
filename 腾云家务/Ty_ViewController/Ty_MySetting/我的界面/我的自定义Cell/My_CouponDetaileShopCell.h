//
//  My_CouponDetaileShopCell.h
//  腾云家务
//
//  Created by 艾飞 on 14/6/20.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomStar.h"

@interface My_CouponDetaileShopCell : UITableViewCell

@property(nonatomic,strong)UIImageView* headImage;
@property(nonatomic,strong)UILabel* shopNameLabel;
@property(nonatomic,strong)UILabel* typeLabel;
@property(nonatomic,strong)CustomStar* customStar;
@property(nonatomic,strong)UILabel* areaLabel;

-(void)setLoadView;

@end
