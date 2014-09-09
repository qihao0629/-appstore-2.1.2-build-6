//
//  My_CouponDetailedCell.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/19.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_CouponDetailedCell.h"

@implementation My_CouponDetailedCell
@synthesize labelCouponNo,labelSuitWork,labelUcEndTime;
@synthesize labelShop,labelShopTitle;
@synthesize labelMoey,labelTitle;
@synthesize labelCouponNoText;
@synthesize labelSuitWorkText;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.layer.borderWidth = 0.3;
        self.layer.borderColor = [[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0f]CGColor];
        
        labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10 , 5, 230 , 20)];
        labelTitle.backgroundColor = [UIColor clearColor];
//        labelTitle.textColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1.0f];
        labelTitle.font = [UIFont boldSystemFontOfSize:16.0f];
        [self.contentView addSubview:labelTitle];
        
        labelCouponNo = [[UILabel alloc]initWithFrame:CGRectMake(10 , 30, 50 , 20)];
        labelCouponNo.backgroundColor = [UIColor clearColor];
//        labelCouponNo.textColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1.0f];
        labelCouponNo.font = [UIFont systemFontOfSize:14.0f];
//        labelCouponNo.text = @"序列号:12344578";
        [self.contentView addSubview:labelCouponNo];
        
        labelCouponNoText = [[UILabel alloc]initWithFrame:CGRectMake(60 , 32, 200 , 20)];
        labelCouponNoText.backgroundColor = [UIColor clearColor];
        labelCouponNoText.font = [UIFont boldSystemFontOfSize:18.0f];
        [self.contentView addSubview:labelCouponNoText];
        
        
        labelUcEndTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, 230, 20)];
        labelUcEndTime.backgroundColor  = [UIColor clearColor];
//        labelUcEndTime.textColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1.0f];
//        labelUcEndTime.text = @"有效期:2014-6-2";
        labelUcEndTime.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:labelUcEndTime];
        
        labelSuitWork = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 200, 20)];
        labelSuitWork.backgroundColor = [UIColor clearColor];
//        labelSuitWork.textColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1.0f];
        labelSuitWork.font = [UIFont systemFontOfSize:14.0f];
//        labelSuitWork.text = @"适用工种:保洁/钟点工";
        [self.contentView addSubview:labelSuitWork];
        
        
        labelSuitWorkText = [[UILabel alloc]initWithFrame:CGRectMake(70 , 80, 240 , 20)];
        labelSuitWorkText.backgroundColor = [UIColor clearColor];
        labelSuitWorkText.font = [UIFont systemFontOfSize:14.0f];
        labelSuitWorkText.numberOfLines = 0;
        [self.contentView addSubview:labelSuitWorkText];
        
        labelMoey = [[UILabel alloc]initWithFrame:CGRectMake(200, 10, 100, 30)];
        labelMoey.backgroundColor = [UIColor clearColor];
        labelMoey.textAlignment = UITextAlignmentRight;
        labelMoey.textColor = ColorRedText;
        labelMoey.font = [UIFont boldSystemFontOfSize:20.0f];
        [self.contentView addSubview:labelMoey];
        
        
        labelShop = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
        labelShop.backgroundColor = [UIColor clearColor];
//        labelShop.textColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1.0f];
        labelShop.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:labelShop];
        
        labelShopTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 300, 20)];
        labelShopTitle.backgroundColor = [UIColor clearColor];
        labelShopTitle.textColor = ColorRedText;
        labelShopTitle.font = [UIFont  systemFontOfSize:14.0f];
        labelShopTitle.textAlignment = UITextAlignmentRight;
        labelShopTitle.text = @"查看全部";
        [self.contentView addSubview:labelShopTitle];
    }
    return self;
}

-(void)My_CouponDetailaCellLabelHiddenYes{

    labelCouponNo.hidden = YES;
    labelSuitWork.hidden = YES;
    labelUcEndTime.hidden = YES;
    labelShop.hidden = NO;
    labelShopTitle.hidden = NO;

}

-(void)My_CouponDetailaCellLabelHiddenNO{
    
    labelCouponNo.hidden = NO;
    labelSuitWork.hidden = NO;
    labelUcEndTime.hidden = NO;
    labelShop.hidden = YES;
    labelShopTitle.hidden = YES;

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
