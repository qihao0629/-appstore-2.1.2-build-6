//
//  Ty_UserDetail_evaluationCell.h
//  腾云家务
//
//  Created by 齐 浩 on 13-10-9.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomStar.h"
@interface Ty_UserDetail_evaluationCell : UITableViewCell
@property(nonatomic,strong)UILabel* typeLabel;
@property(nonatomic,strong)UIImageView* headImage;
@property(nonatomic,strong)UIView* backView;
@property(nonatomic,strong)UILabel* pingjiaLabel;
@property(nonatomic,strong)CustomStar* customstar;
@property(nonatomic,strong)UILabel* zhiliangLabel;
@property(nonatomic,strong)UILabel* taiduLabel;
@property(nonatomic,strong)UILabel* suduLabel;

-(float)setHight;
@end
