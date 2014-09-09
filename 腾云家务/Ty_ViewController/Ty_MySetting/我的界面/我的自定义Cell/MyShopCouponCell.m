//
//  MyShopCouponCell.m
//  腾云家务
//
//  Created by AF on 14-8-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "MyShopCouponCell.h"

@implementation MyShopCouponCell
@synthesize labelConditions,labelMoney,labelMoneyText,labelNumber,labelUser,labelWork,labelWorkText;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.layer.borderWidth = 0.3;
        self.layer.borderColor = [[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0f]CGColor];
        
        labelNumber = [[UILabel alloc]initWithFrame:CGRectMake(10 , 10, 150, 20)];
        labelNumber.textAlignment = NSTextAlignmentLeft;
        labelNumber.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:labelNumber];
        
        
        labelWork = [[UILabel alloc]initWithFrame:CGRectMake(10 , 40, 60, 20)];
        labelWork.textAlignment = NSTextAlignmentLeft;
        labelWork.font = [UIFont systemFontOfSize:13.0f];
        labelWork.text = @"适用工种: ";
        labelWork.backgroundColor = [UIColor clearColor];

        [self.contentView addSubview:labelWork];
        
        
        labelWorkText = [[UILabel alloc]initWithFrame:CGRectMake(70 , 40, 230, 20)];
        labelWorkText.textAlignment = NSTextAlignmentLeft;
        labelMoneyText.backgroundColor = [UIColor clearColor];
        labelWorkText.font = [UIFont systemFontOfSize:13.0f];
        labelWorkText.numberOfLines = 0 ;
        [self.contentView addSubview:labelWorkText];
        
        labelConditions = [[UILabel alloc]initWithFrame:CGRectMake(10 , 50 + labelWorkText.frame.size.height , 200, 20)];
        labelConditions.backgroundColor = [UIColor clearColor];

        labelConditions.textAlignment = NSTextAlignmentLeft;
        labelConditions.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:labelConditions];
        
        labelUser = [[UILabel alloc]initWithFrame:CGRectMake(10 , 80 + labelWorkText.frame.size.height, 250, 20)];
        labelUser.textAlignment = NSTextAlignmentLeft;
        labelUser.backgroundColor = [UIColor clearColor];

        labelUser.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:labelUser];
    
        
        labelMoney = [[UILabel alloc]initWithFrame:CGRectMake(210 , 10, 40, 20)];
        labelMoney.textAlignment = NSTextAlignmentLeft;
        labelMoney.backgroundColor = [UIColor clearColor];
        labelMoney.font = [UIFont boldSystemFontOfSize:18.0f];
        labelMoney.textColor = ColorRedText;
        labelMoney.text = @"价值";
        [self.contentView addSubview:labelMoney];
        
        
        labelMoneyText = [[UILabel alloc]initWithFrame:CGRectMake(250 , 10, 40, 20)];
        labelMoneyText.backgroundColor = [UIColor clearColor];
        labelMoneyText.textAlignment = NSTextAlignmentLeft;
        labelMoneyText.font = [UIFont boldSystemFontOfSize:18.0f];
        labelMoneyText.textColor = ColorRedText;
//        labelMoneyText.text = @"30元";
        [self.contentView addSubview:labelMoneyText];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
