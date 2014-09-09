//
//  Ty_UserInfoView.m
//  腾云家务
//
//  Created by 齐 浩 on 14-2-26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_UserInfoView.h"

@implementation Ty_UserInfoView
@synthesize HeadImage,nameLabel,customStar,ageLabel,censusLabel,IdCardLabel,priceLabel,workTypeLabel;
@synthesize telButton;
@synthesize typeLabel;
@synthesize sumNumberLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        HeadImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 14, 62, 62)];
        //        self.HeadImage.layer.cornerRadius = 5;
        HeadImage.layer.masksToBounds = YES;
        HeadImage.layer.borderColor=[Color_200 CGColor];
        HeadImage.layer.borderWidth=1.0;
        [HeadImage setImage:JWImageName(@"Contact_image")];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(74, 15, 60, 15)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setFont:FONT15_BOLDSYSTEM];
        [nameLabel setText:@"李阿姨"];
        
        self.typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+5, 15, self.frame.size.width-nameLabel.frame.origin.x+nameLabel.frame.size.width+5, 15)];
        [self.typeLabel setBackgroundColor:[UIColor clearColor]];
        [self.typeLabel setFont:FONT12_SYSTEM];
        //        [self.typeLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.typeLabel setTextColor:[UIColor whiteColor]];
        [self.typeLabel setText:@""];
        [self.typeLabel setBackgroundColor:[UIColor colorWithPatternImage:JWImageName(@"greenBackGround")]];
        [self.typeLabel setText:@""];
        self.typeLabel.layer.cornerRadius=3;
        [self.typeLabel setTextAlignment:UITextAlignmentCenter];
        
        customStar = [[CustomStar alloc]initWithFrame:CGRectMake(74, 45, 65, 12) Number:5];
        customStar.userInteractionEnabled=NO;
//        [customStar setCustomStarNumber:4.5];
        
        sumNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 45, 150, 13)];
        [sumNumberLabel setBackgroundColor:[UIColor clearColor]];
        [sumNumberLabel setTextColor:[UIColor grayColor]];
        [sumNumberLabel setFont:FONT13_SYSTEM];
        [sumNumberLabel setText:@""];
        
        ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(74, 48, 50, 15)];
        [ageLabel setBackgroundColor:[UIColor clearColor]];
        [ageLabel setTextColor:[UIColor grayColor]];
        [ageLabel setFont:FONT13_BOLDSYSTEM];
        [ageLabel setText:@"45岁"];
        
        
        censusLabel = [[UILabel alloc]initWithFrame:CGRectMake(114, 48, 100, 15)];
        [censusLabel setBackgroundColor:[UIColor clearColor]];
        [censusLabel setTextColor:[UIColor grayColor]];
        [censusLabel setFont:FONT13_BOLDSYSTEM];
        [censusLabel setText:@"安徽 芜湖"];
        
        UIImageView* idImage = [[UIImageView alloc]initWithFrame:CGRectMake(74, 68, 20, 15)];
        [idImage setImage:JWImageName(@"home_renzheng")];
        
        IdCardLabel=[[UILabel alloc]initWithFrame:CGRectMake(97, 68, 200, 15)];
        [IdCardLabel setBackgroundColor:[UIColor clearColor]];
        [IdCardLabel setTextColor:[UIColor grayColor]];
        [IdCardLabel setFont:FONT13_BOLDSYSTEM];
        [IdCardLabel setText:@"身份证:23490234213xxxxxxxx232"];
        
        priceLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(140, 30, 160, 20)];
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        [priceLabel setTextColor:[UIColor redColor]];
        [priceLabel setFont:FONT15_BOLDSYSTEM];
        [priceLabel initWithStratString:@"30" startColor:Color_orange startFont:FONT20_BOLDSYSTEM centerString:@"元" centerColor:Color_orange centerFont:FONT20_BOLDSYSTEM endString:@"/小时" endColor:Color_orange endFont:FONT13_SYSTEM];
        [priceLabel setVerticalAlignment:UIControlContentVerticalAlignmentBottom];
        [priceLabel setTextAlignment:NSTextAlignmentRight];
//        [priceLabel setText:@"30元/小时"];
        
        workTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(220, 53, 90, 15)];
        [workTypeLabel setBackgroundColor:[UIColor clearColor]];
        [workTypeLabel setTextColor:[UIColor grayColor]];
        [workTypeLabel setFont:FONT11_SYSTEM];
        [workTypeLabel setText:@"（日常保洁）"];
        
        
        
        telButton = [Ty_UserInfoButton BtnWithType:UIButtonTypeCustom];
        [telButton setFrame:CGRectMake(0, 90, 300, 40)];
        [telButton setTitle:@"021-50311527" forState:UIControlStateNormal];
        [telButton setImage:JWImageName(@"home_phone") forState:UIControlStateNormal];
        [telButton setBackgroundColor:[UIColor whiteColor]];
        [telButton setBackgroundImage:JWImageName(@"i_setupcellbg") forState:UIControlStateNormal];
//        telButton.layer.masksToBounds=YES;
//        telButton.layer.borderColor=[Color_210 CGColor];
//        telButton.layer.borderWidth=0.5f;
        [telButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [telButton.titleLabel setFont:FONT14_BOLDSYSTEM];
        [telButton.accessoryTypeImage setImage:JWImageName(@"home_accessoryType")];
        
        [self addSubview:HeadImage];
        [self addSubview:nameLabel];
        [self addSubview:customStar];
        [self addSubview:idImage];
        [self addSubview:sumNumberLabel];
//        [self addSubview:ageLabel];
//        [self addSubview:censusLabel];
        [self addSubview:IdCardLabel];
//        [self addSubview:priceLabel];
//        [self addSubview:workTypeLabel];
        [self addSubview:typeLabel];
        [self addSubview:telButton];
    }
    return self;
}
-(void)setLoadView
{
    CGSize NameSize = [self.nameLabel.text sizeWithFont:FONT15_BOLDSYSTEM constrainedToSize:CGSizeMake(320, self.nameLabel.frame.size.height) lineBreakMode:NSLineBreakByCharWrapping];
    [self.nameLabel setFrame:CGRectMake(self.nameLabel.frame.origin.x,self.nameLabel.frame.origin.y,NameSize.width,NameSize.height)];
    CGSize typeSize = [self.typeLabel.text sizeWithFont:FONT13_SYSTEM constrainedToSize:CGSizeMake(320, self.typeLabel.frame.size.height) lineBreakMode:NSLineBreakByCharWrapping];
    [self.typeLabel setFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+5, self.typeLabel.frame.origin.y, typeSize.width, self.typeLabel.frame.size.height)];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
