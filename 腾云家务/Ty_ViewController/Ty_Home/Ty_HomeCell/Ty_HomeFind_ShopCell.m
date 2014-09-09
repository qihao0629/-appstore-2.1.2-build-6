//
//  Ty_HomeFind_ShopCell.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HomeFind_ShopCell.h"

@implementation Ty_HomeFind_ShopCell
@synthesize headImage,shopNameLabel,typeLabel,customStar,serviceNumLabel,distanceLabel,areaLabel;
@synthesize priceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, 320, 80)];
        [self setBackgroundColor:view_BackGroudColor];
        headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 70, 70)];
        headImage.layer.masksToBounds = YES;
        headImage.layer.borderColor=[Color_200 CGColor];
        headImage.layer.borderWidth=1.0;
        [headImage setImage:JWImageName(@"Contact_image")];
        
        shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 5, 210, 15)];
        [shopNameLabel setBackgroundColor:[UIColor clearColor]];
        [shopNameLabel setFont:FONT15_BOLDSYSTEM];
        [shopNameLabel setHighlightedTextColor:[UIColor whiteColor]];
        [shopNameLabel setText:@"测试"];
        
        typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(shopNameLabel.frame.origin.x+shopNameLabel.frame.size.width+5, 7, self.frame.size.width-shopNameLabel.frame.origin.x+shopNameLabel.frame.size.width+5, 15)];
        [typeLabel setBackgroundColor:[UIColor clearColor]];
        [typeLabel setFont:FONT12_SYSTEM];
        [typeLabel setTextAlignment:NSTextAlignmentCenter];
        [typeLabel setTextColor:[UIColor whiteColor]];
        [typeLabel setBackgroundColor:[UIColor colorWithPatternImage:JWImageName(@"greenBackGround")]];
        typeLabel.layer.cornerRadius=3;
        [typeLabel setText:@"测试"];
        
        
        customStar = [[CustomStar alloc]initWithFrame:CGRectMake(90, 33, 73, 13) Number:5];
        [customStar setUserInteractionEnabled:NO];
        [customStar setCustomStarNumber:0];
        
        
        areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 60, 120, 11)];
        [areaLabel setBackgroundColor:[UIColor clearColor]];
        [areaLabel setFont:FONT11_SYSTEM];
        [areaLabel setHighlightedTextColor:[UIColor whiteColor]];
        [areaLabel setTextColor:text_grayColor];
        [areaLabel setText:@"测试"];
        
        distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 60, 90, 12)];
        [distanceLabel setBackgroundColor:[UIColor clearColor]];
        [distanceLabel setFont:FONT12_SYSTEM];
        [distanceLabel setHighlightedTextColor:[UIColor whiteColor]];
        [distanceLabel setTextColor:text_grayColor];
        [distanceLabel setText:@"测试"];
        [distanceLabel setTextAlignment:NSTextAlignmentRight];
        
        serviceNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 60, 120,12 )];
//        serviceNumLabel=[[UILabel alloc]initWithFrame:CGRectMake(210, 40, 90,12 )];
        [serviceNumLabel setBackgroundColor:[UIColor clearColor]];
        [serviceNumLabel setFont:FONT12_SYSTEM];
        [serviceNumLabel setHighlightedTextColor:[UIColor whiteColor]];
        [serviceNumLabel setTextColor:text_grayColor];
        [serviceNumLabel setText:@"测试"];
        [serviceNumLabel setTextAlignment:NSTextAlignmentLeft];
        
        priceLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(170, 30, 130, 15)];
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        [priceLabel setHighlightedTextColor:[UIColor whiteColor]];
        [priceLabel setTextAlignment:NSTextAlignmentRight];
        [priceLabel setVerticalAlignment:UIControlContentVerticalAlignmentBottom];
        
        
        
        [self.contentView addSubview:self.headImage];
        [self.contentView addSubview:self.shopNameLabel];
        [self.contentView addSubview:self.typeLabel];
        [self.contentView addSubview:self.customStar];
//        [self.contentView addSubview:self.areaLabel];
        [self.contentView addSubview:self.distanceLabel];
        [self.contentView addSubview:serviceNumLabel];
        [self.contentView addSubview:priceLabel];
    }
    return self;
}
-(void)setLoadView
{
    CGSize NameSize = [self.shopNameLabel.text sizeWithFont:FONT15_BOLDSYSTEM constrainedToSize:CGSizeMake(320, self.shopNameLabel.frame.size.height) lineBreakMode:NSLineBreakByCharWrapping];
    [self.shopNameLabel setFrame:CGRectMake(self.shopNameLabel.frame.origin.x,self.shopNameLabel.frame.origin.y,NameSize.width,NameSize.height)];

    CGSize typeSize = [self.typeLabel.text sizeWithFont:FONT13_SYSTEM constrainedToSize:CGSizeMake(320, self.typeLabel.frame.size.height) lineBreakMode:NSLineBreakByCharWrapping];
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
