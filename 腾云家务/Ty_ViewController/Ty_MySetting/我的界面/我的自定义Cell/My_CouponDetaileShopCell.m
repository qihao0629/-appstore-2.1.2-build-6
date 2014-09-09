//
//  My_CouponDetaileShopCell.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/20.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_CouponDetaileShopCell.h"

@implementation My_CouponDetaileShopCell
@synthesize headImage,shopNameLabel,typeLabel,customStar,areaLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.layer.borderWidth = 0.3;
        self.layer.borderColor = [[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0f]CGColor];
        
//        [self setFrame:CGRectMake(0, 0, 320, 80)];
//        [self setBackgroundColor:view_BackGroudColor];
        headImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 70, 70)];
        headImage.layer.masksToBounds = YES;
        headImage.layer.borderColor=[Color_200 CGColor];
        headImage.layer.borderWidth=1.0;
        [headImage setImage:JWImageName(@"Contact_image")];
        
        [self.contentView addSubview:headImage];
        
        shopNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 5, 210, 15)];
        [shopNameLabel setBackgroundColor:[UIColor clearColor]];
        [shopNameLabel setFont:FONT15_BOLDSYSTEM];
        [shopNameLabel setHighlightedTextColor:[UIColor whiteColor]];
//        [shopNameLabel setText:@"测试"];
        
        [self.contentView addSubview:shopNameLabel];
        
        typeLabel=[[UILabel alloc]initWithFrame:CGRectMake(shopNameLabel.frame.origin.x+shopNameLabel.frame.size.width+5, 7, self.frame.size.width-shopNameLabel.frame.origin.x+shopNameLabel.frame.size.width+5, 15)];
        [typeLabel setBackgroundColor:[UIColor clearColor]];
        [typeLabel setFont:FONT12_SYSTEM];
        [typeLabel setTextAlignment:NSTextAlignmentCenter];
        [typeLabel setTextColor:[UIColor whiteColor]];
        [typeLabel setBackgroundColor:[UIColor colorWithPatternImage:JWImageName(@"greenBackGround")]];
        typeLabel.layer.cornerRadius=3;
//        [typeLabel setText:@"测试"];
        [self.contentView addSubview:typeLabel];
        
        customStar=[[CustomStar alloc]initWithFrame:CGRectMake(90, 33, 73, 13) Number:5];
        [customStar setUserInteractionEnabled:NO];
        [customStar setCustomStarNumber:0];
        [self.contentView addSubview:customStar];
        
        areaLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 60, 200, 11)];
        [areaLabel setBackgroundColor:[UIColor clearColor]];
        [areaLabel setFont:FONT11_SYSTEM];
        [areaLabel setHighlightedTextColor:[UIColor whiteColor]];
        [areaLabel setTextColor:text_grayColor];
//        [areaLabel setText:@"测试"];
        [self.contentView addSubview:areaLabel];
        
    }
    return self;
}


-(void)setLoadView
{
    CGSize NameSize = [self.shopNameLabel.text sizeWithFont:FONT15_BOLDSYSTEM constrainedToSize:CGSizeMake(320, self.shopNameLabel.frame.size.height) lineBreakMode:NSLineBreakByCharWrapping];
    [self.shopNameLabel setFrame:CGRectMake(self.shopNameLabel.frame.origin.x,self.shopNameLabel.frame.origin.y,NameSize.width,NameSize.height)];
    
    CGSize typeSize=[self.typeLabel.text sizeWithFont:FONT13_SYSTEM constrainedToSize:CGSizeMake(320, self.typeLabel.frame.size.height) lineBreakMode:NSLineBreakByCharWrapping];
    [self.typeLabel setFrame:CGRectMake(shopNameLabel.frame.origin.x+shopNameLabel.frame.size.width+5, self.typeLabel.frame.origin.y, typeSize.width, self.typeLabel.frame.size.height)];
    
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
