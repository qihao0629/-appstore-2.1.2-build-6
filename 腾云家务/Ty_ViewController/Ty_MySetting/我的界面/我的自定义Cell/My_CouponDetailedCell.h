//
//  My_CouponDetailedCell.h
//  腾云家务
//
//  Created by 艾飞 on 14/6/19.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface My_CouponDetailedCell : UITableViewCell
@property(nonatomic,strong)UILabel * labelCouponNo;//序列号
@property(nonatomic,strong)UILabel * labelCouponNoText;//序列号text
@property(nonatomic,strong)UILabel * labelUcEndTime;//有效期
@property(nonatomic,strong)UILabel * labelSuitWork;//有效工种
@property(nonatomic,strong)UILabel * labelSuitWorkText;//有效工种text
@property(nonatomic,strong)UILabel * labelTitle;//标题
@property(nonatomic,strong)UILabel * labelMoey;//价值

@property(nonatomic,strong)UILabel * labelShop;//适用店铺文字
@property(nonatomic,strong)UILabel * labelShopTitle;//查看全部


-(void)My_CouponDetailaCellLabelHiddenNO;
-(void)My_CouponDetailaCellLabelHiddenYes;



@end

