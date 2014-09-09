//
//  Ty_SystemMessageCell.h
//  腾云家务
//
//  Created by liu on 14-7-12.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSTextView.h"
#import "RTLabel.h"

@class Ty_Model_SystemMsgInfo;

@interface Ty_SystemMessageCell : UITableViewCell
{
    CSTextView *_colorfulTextView;
}

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UIImageView *contentBgImageView;
@property (nonatomic,strong) UILabel *contentLabel;


- (void)setContent:(Ty_Model_SystemMsgInfo *)messageInfo;

@end
