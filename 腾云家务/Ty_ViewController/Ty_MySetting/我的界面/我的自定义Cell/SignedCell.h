//
//  SignedCell.h
//  腾云家务
//
//  Created by 艾飞 on 13-12-19.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//
////签约服务员管理 Cell
#import <UIKit/UIKit.h>

@interface SignedCell : UITableViewCell

@property(nonatomic,strong)UIImageView * imageHead;
@property(nonatomic,strong)UILabel * labelName;
@property(nonatomic,strong)UILabel * labelPhone;
@property(nonatomic,strong)UILabel * labelWork;
@property(nonatomic,strong)UIButton * butPhone;

@end
