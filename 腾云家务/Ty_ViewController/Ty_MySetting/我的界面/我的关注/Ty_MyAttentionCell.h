//
//  Ty_MyAttentionCell.h
//  腾云家务
//
//  Created by liu on 14-7-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Ty_Model_ServiceObject.h"

@interface Ty_MyAttentionCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headerImageView;

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *serviceTypeLabel;

@property (nonatomic,strong) UILabel *workDetailLabel;


- (void)setContent:(Ty_Model_ServiceObject *)serviceObject;

@end
