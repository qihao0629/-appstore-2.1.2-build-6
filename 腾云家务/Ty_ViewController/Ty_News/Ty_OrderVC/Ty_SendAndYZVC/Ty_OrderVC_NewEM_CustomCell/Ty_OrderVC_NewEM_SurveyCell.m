//
//  Ty_OrderVC_NewEM_SurveyCell.m
//  腾云家务
//
//  Created by lgs on 14-7-15.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_NewEM_SurveyCell.h"

@implementation Ty_OrderVC_NewEM_SurveyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lableName = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 300, 12)];
        _lableName.textAlignment = UITextAlignmentLeft;
        _lableName.backgroundColor = [UIColor clearColor];
        _lableName.font = FONT12_BOLDSYSTEM;
        _lableName.numberOfLines = 0;
        _lableName.lineBreakMode = NSLineBreakByCharWrapping;
        _lableName.textColor = [UIColor colorWithRed:244.0/255.0 green:29.0/255.0 blue:31.0/255.0 alpha:1.0];
        
        [self.contentView addSubview:_lableName];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
