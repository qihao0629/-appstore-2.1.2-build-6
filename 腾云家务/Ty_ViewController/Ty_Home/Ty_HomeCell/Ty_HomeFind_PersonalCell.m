//
//  Ty_HomeFind_PersonalCell.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HomeFind_PersonalCell.h"

@implementation Ty_HomeFind_PersonalCell
@synthesize headImage,personalNameLabel,typeLabel,customStar;
@synthesize serviceNumLabel,customLable;
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
        
        personalNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 5, 210, 15)];
        [personalNameLabel setBackgroundColor:[UIColor clearColor]];
        [personalNameLabel setFont:FONT15_BOLDSYSTEM];
        [personalNameLabel setHighlightedTextColor:[UIColor whiteColor]];
        [personalNameLabel setText:@"测试"];
        
        typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(personalNameLabel.frame.origin.x+personalNameLabel.frame.size.width+5, 7, self.frame.size.width-personalNameLabel.frame.origin.x+personalNameLabel.frame.size.width+5, 15)];
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
        
        serviceNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 60, 120, 11)];
        [serviceNumLabel setBackgroundColor:[UIColor clearColor]];
        [serviceNumLabel setFont:FONT11_SYSTEM];
        [serviceNumLabel setHighlightedTextColor:[UIColor whiteColor]];
        [serviceNumLabel setTextColor:text_grayColor];
        [serviceNumLabel setText:@"测试"];
        
        
        customLable = [[CustomLabel alloc]initWithFrame:CGRectMake(170, 30, 130,15 )];
        [customLable setTextAlignment:NSTextAlignmentRight];
        [customLable setVerticalAlignment:UIControlContentVerticalAlignmentBottom];
        [customLable initWithStratString:@"" startColor:text_RedColor startFont:FONT10_BOLDSYSTEM centerString:nil centerColor:nil centerFont:nil endString:nil endColor:nil endFont:nil];
        
        
        
        [self.contentView addSubview:headImage];
        [self.contentView addSubview:personalNameLabel];
        [self.contentView addSubview:typeLabel];
        [self.contentView addSubview:customStar];
        [self.contentView addSubview:customLable];
        [self.contentView addSubview:serviceNumLabel];

    }
    return self;
}
-(void)setLoadView
{
    CGSize NameSize = [self.personalNameLabel.text sizeWithFont:FONT15_BOLDSYSTEM constrainedToSize:CGSizeMake(320, self.personalNameLabel.frame.size.height) lineBreakMode:NSLineBreakByCharWrapping];
    [self.personalNameLabel setFrame:CGRectMake(self.personalNameLabel.frame.origin.x,self.personalNameLabel.frame.origin.y,NameSize.width,NameSize.height)];

    CGSize typeSize = [self.typeLabel.text sizeWithFont:FONT13_SYSTEM constrainedToSize:CGSizeMake(320, self.typeLabel.frame.size.height) lineBreakMode:NSLineBreakByCharWrapping];
    [self.typeLabel setFrame:CGRectMake(personalNameLabel.frame.origin.x+personalNameLabel.frame.size.width+10, self.typeLabel.frame.origin.y, typeSize.width, self.typeLabel.frame.size.height)];
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
