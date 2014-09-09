//
//  Ty_OrderVC_NewEm_ServiceCell.m
//  腾云家务
//
//  Created by lgs on 14-7-15.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_NewEm_ServiceCell.h"

@implementation Ty_OrderVC_NewEm_ServiceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lableName = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 70, 15)];
        _lableName.textAlignment = NSTextAlignmentLeft;
        _lableName.backgroundColor = [UIColor clearColor];
        _lableName.font = [UIFont boldSystemFontOfSize:15.0f];
        
        [self.contentView addSubview:_lableName];
        
        _serviceName = [[UILabel alloc]initWithFrame:CGRectMake(90, 15, 200, 15)];
        _serviceName.textAlignment = NSTextAlignmentLeft;
        _serviceName.backgroundColor = [UIColor clearColor];
        _serviceName.font = FONT15_BOLDSYSTEM;
        _serviceName.textColor = [UIColor grayColor];

        [self.contentView addSubview:_serviceName];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
