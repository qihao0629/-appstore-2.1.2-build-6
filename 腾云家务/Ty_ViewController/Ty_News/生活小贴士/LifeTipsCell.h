//
//  LifeTipsCell.h
//  腾云家务
//
//  Created by liu on 14-8-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_Model_LifeTipsInfo.h"

@interface LifeTipsCell : UITableViewCell

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UIImageView *contentBgImageView;
@property (nonatomic,strong) UILabel *contentLabel;


- (void)setContent:(Ty_Model_LifeTipsInfo *)lifeTipsInfo;

@end
