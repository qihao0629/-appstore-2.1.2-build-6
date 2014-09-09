//
//  MessageListCell.h
//  腾云家务
//
//  Created by liu on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ty_Model_MessageInfo;

@interface MessageListCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headerImageView;

@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UILabel *nameLabel;//contact姓名

@property (nonatomic,strong) UILabel *contentLabel;//详细内容

@property (nonatomic,strong) UIImageView *remindSignImageView; //未读标志提醒

@property (nonatomic,strong) UILabel *remindNumLabel;//未读信息个数


- (void)setCellContent:(Ty_Model_MessageInfo *)messageInfo cellRows:(NSInteger)row;

@end
