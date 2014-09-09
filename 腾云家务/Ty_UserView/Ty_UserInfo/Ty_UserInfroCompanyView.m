//
//  Ty_UserInfroCompanyView.m
//  腾云家务
//
//  Created by 齐 浩 on 14-2-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_UserInfroCompanyView.h"

@implementation Ty_UserInfroCompanyView
@synthesize HeadImage,nameLabel,customStar,introductionString,intermediaryBusinessTime,xiangxiButton;
@synthesize addressButton,telButton;
@synthesize typeLabel,introductionLabel;
@synthesize fuwuquyuLabel,fuzerenLabel,kaishiyeTimeLabel;
@synthesize _addBool;
@synthesize sumNumberLabel;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _bool=YES;
        if (!_addBool) {
            HeadImage = [[UIImageView alloc]initWithFrame:CGRectMake(3, 18, 57, 57)];
            //        self.HeadImage.layer.cornerRadius = 5;
            HeadImage.layer.masksToBounds = YES;
            HeadImage.layer.borderColor=[Color_200 CGColor];
            HeadImage.layer.borderWidth=1.0;
            [HeadImage setImage:JWImageName(@"Contact_image")];
            
            nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(72, 15, 200, 15)];
            [nameLabel setBackgroundColor:[UIColor clearColor]];
            [nameLabel setFont:FONT15_BOLDSYSTEM];
            [nameLabel setText:@"XXXXXXXXXXX"];
            
            self.typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+5, 15, self.frame.size.width-nameLabel.frame.origin.x+nameLabel.frame.size.width+5, 15)];
            [self.typeLabel setBackgroundColor:[UIColor clearColor]];
            [self.typeLabel setFont:FONT12_SYSTEM];
            //        [self.typeLabel setHighlightedTextColor:[UIColor whiteColor]];
            [self.typeLabel setTextColor:[UIColor whiteColor]];
            [self.typeLabel setText:@"商户"];
            [self.typeLabel setBackgroundColor:[UIColor colorWithPatternImage:JWImageName(@"greenBackGround")]];
            self.typeLabel.layer.cornerRadius=3;
            [self.typeLabel setTextAlignment:UITextAlignmentCenter];
            [self.typeLabel setText:@""];
            
            customStar = [[CustomStar alloc]initWithFrame:CGRectMake(73, 35, 65, 12) Number:5];
            customStar.userInteractionEnabled=NO;
//            [customStar setCustomStarNumber:4.5];
            
            sumNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 35, 150, 13)];
            [sumNumberLabel setBackgroundColor:[UIColor clearColor]];
            [sumNumberLabel setTextColor:[UIColor grayColor]];
            [sumNumberLabel setFont:FONT13_SYSTEM];
            [sumNumberLabel setText:@""];
            
            intermediaryBusinessTime = [[UILabel alloc]initWithFrame:CGRectMake(72, 48, 200, 15)];
            [intermediaryBusinessTime setBackgroundColor:[UIColor clearColor]];
            [intermediaryBusinessTime setTextColor:[UIColor grayColor]];
            [intermediaryBusinessTime setFont:FONT13_BOLDSYSTEM];
            [intermediaryBusinessTime setText:@"营业时间"];
            
            introductionLabel = [[UILabel alloc]initWithFrame:CGRectMake(72, 65, 56, 15)];
            [introductionLabel setBackgroundColor:[UIColor clearColor]];
            [introductionLabel setTextColor:[UIColor grayColor]];
            [introductionLabel setFont:FONT13_BOLDSYSTEM];
            [introductionLabel setText:@"商户介绍:"];
            
            introductionString = [[UILabel alloc]initWithFrame:CGRectMake(72, 65, 225, 15)];
            [introductionString setBackgroundColor:[UIColor clearColor]];
            [introductionString setTextColor:[UIColor grayColor]];
            introductionString.numberOfLines=1;
            introductionString.lineBreakMode =NSLineBreakByWordWrapping ;
            [introductionString setFont:FONT13_BOLDSYSTEM];
            [introductionString setText:@"XXXXXXXXXXXXXXXXXX"];
            
            xiangxiButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [xiangxiButton setFrame:CGRectMake(250, 60, 50, 25)];
            [xiangxiButton setTitle:@"<更多>" forState:UIControlStateNormal];
            [xiangxiButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [xiangxiButton.titleLabel setFont:FONT14_BOLDSYSTEM];
            [xiangxiButton addTarget:self action:@selector(xiangxi) forControlEvents:UIControlEventTouchUpInside];
            
            kaishiyeTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(72, introductionString.frame.origin.y, 200, 15)];
            [kaishiyeTimeLabel setBackgroundColor:[UIColor clearColor]];
            [kaishiyeTimeLabel setTextColor:[UIColor grayColor]];
            [kaishiyeTimeLabel setFont:FONT13_BOLDSYSTEM];
            [kaishiyeTimeLabel setText:@"XXXXXXXXXXXXXXXXXX"];
            kaishiyeTimeLabel.hidden=YES;
            
            fuzerenLabel = [[UILabel alloc]initWithFrame:CGRectMake(72, introductionString.frame.origin.y, 200, 15)];
            [fuzerenLabel setBackgroundColor:[UIColor clearColor]];
            [fuzerenLabel setTextColor:[UIColor grayColor]];
            [fuzerenLabel setFont:FONT13_BOLDSYSTEM];
            [fuzerenLabel setText:@"XXXXXXXXXXXXXXXXXX"];
            fuzerenLabel.hidden=YES;
            
            fuwuquyuLabel = [[UILabel alloc]initWithFrame:CGRectMake(72, introductionString.frame.origin.y, 200, 15)];
            [fuwuquyuLabel setBackgroundColor:[UIColor clearColor]];
            [fuwuquyuLabel setTextColor:[UIColor grayColor]];
            [fuwuquyuLabel setFont:FONT13_BOLDSYSTEM];
            [fuwuquyuLabel setText:@"XXXXXXXXXXXXXXXXXX"];
            fuwuquyuLabel.hidden=YES;
            fuwuquyuLabel.numberOfLines=0;
            fuwuquyuLabel.lineBreakMode =NSLineBreakByWordWrapping ;
            
            addressButton = [Ty_UserInfoButton BtnWithType:UIButtonTypeCustom];
            [addressButton setFrame:CGRectMake(0, introductionString.frame.origin.y+25, 300, 40)];
            [addressButton setTitle:@"XXXXXXXXXXX" forState:UIControlStateNormal];
            [addressButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [addressButton.titleLabel setFont:FONT14_BOLDSYSTEM];
//            addressButton.layer.masksToBounds=YES;
//            addressButton.layer.borderColor=[Color_210 CGColor];
//            addressButton.layer.borderWidth=0.5f;
            [addressButton setImage:JWImageName(@"home_map") forState:UIControlStateNormal];
            [addressButton setBackgroundImage:JWImageName(@"i_setupcellbg") forState:UIControlStateNormal];
//            [addressButton setBackgroundColor:[UIColor whiteColor]];
            [addressButton.accessoryTypeImage setImage:JWImageName(@"home_accessoryType")];
            
            telButton = [Ty_UserInfoButton BtnWithType:UIButtonTypeCustom];
            [telButton setFrame:CGRectMake(0, addressButton.frame.origin.y+50, 300, 40)];
            [telButton setTitle:@"021-50311527" forState:UIControlStateNormal];
            [telButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [telButton.titleLabel setFont:FONT14_BOLDSYSTEM];
//            telButton.layer.masksToBounds=YES;
//            telButton.layer.borderColor=[Color_210 CGColor];
//            telButton.layer.borderWidth=0.5f;
            [telButton setImage:JWImageName(@"home_phone") forState:UIControlStateNormal];
            [telButton setBackgroundImage:JWImageName(@"i_setupcellbg") forState:UIControlStateNormal];
//            [telButton setBackgroundColor:[UIColor whiteColor]];
            [telButton.accessoryTypeImage setImage:JWImageName(@"home_accessoryType")];
            
            
            [self addSubview:HeadImage];
            [self addSubview:nameLabel];
            [self addSubview:typeLabel];
            [self addSubview:customStar];
            [self addSubview:sumNumberLabel];
//            [self addSubview:introductionLabel];
            [self addSubview:introductionString];
            [self addSubview:kaishiyeTimeLabel];
            [self addSubview:fuzerenLabel];
            [self addSubview:fuwuquyuLabel];
            [self addSubview:intermediaryBusinessTime];
            [self addSubview:xiangxiButton];
            
            [self addSubview:addressButton];
            [self addSubview:telButton];
            _addBool=YES;
        }
    }
    return self;
}
-(void)setLoadView
{
    CGSize NameSize = [self.nameLabel.text sizeWithFont:FONT15_BOLDSYSTEM
                                      constrainedToSize:CGSizeMake(320, self.nameLabel.frame.size.height)
                                          lineBreakMode:NSLineBreakByCharWrapping];
    [self.nameLabel setFrame:CGRectMake(self.nameLabel.frame.origin.x,self.nameLabel.frame.origin.y,NameSize.width,NameSize.height)];
    CGSize typeSize = [self.typeLabel.text sizeWithFont:FONT13_SYSTEM
                                          constrainedToSize:CGSizeMake(320, self.typeLabel.frame.size.height)
                                              lineBreakMode:NSLineBreakByCharWrapping];
    
    [self.typeLabel setFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+5, self.typeLabel.frame.origin.y, typeSize.width, self.typeLabel.frame.size.height)];
}
-(Ty_UserInfroCompanyView*)setDetailView
{
    if (_bool) {
        CGSize NameSize = [introductionString.text sizeWithFont:FONT13_BOLDSYSTEM
                                              constrainedToSize:CGSizeMake(introductionString.frame.size.width, self.introductionString.frame.size.height*100)
                                                  lineBreakMode:NSLineBreakByCharWrapping];
        CGSize fuwuquyuSize = [fuwuquyuLabel.text sizeWithFont:FONT13_BOLDSYSTEM
                                             constrainedToSize:CGSizeMake(fuwuquyuLabel.frame.size.width, self.fuwuquyuLabel.frame.size.height*3)
                                                 lineBreakMode:NSLineBreakByCharWrapping];

        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:5];
        
        [UIView beginAnimations:nil context:nil];
        [self.introductionString setFrame:CGRectMake(self.introductionString.frame.origin.x,self.introductionString.frame.origin.y,NameSize.width,NameSize.height)];
        introductionString.numberOfLines = 0;
        
        [xiangxiButton setTitle:@"<收起>" forState:UIControlStateNormal];
        [kaishiyeTimeLabel setFrame:CGRectMake(72, introductionString.frame.origin.y+5+introductionString.frame.size.height, 200, 15)];
        [fuzerenLabel setFrame:CGRectMake(72, kaishiyeTimeLabel.frame.origin.y+20, 200, 15)];
        [fuwuquyuLabel setFrame:CGRectMake(72, fuzerenLabel.frame.origin.y+20, fuwuquyuSize.width, fuwuquyuSize.height)];
        [addressButton setFrame:CGRectMake(0, fuwuquyuLabel.frame.origin.y+10+fuwuquyuLabel.frame.size.height, 300, 40)];
        [telButton setFrame:CGRectMake(0, addressButton.frame.origin.y+50, 300, 40)];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, telButton.frame.origin.y+telButton.frame.size.height+10)];
        
        kaishiyeTimeLabel.hidden = NO;
        fuzerenLabel.hidden = NO;
        fuwuquyuLabel.hidden = NO;

        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, telButton.frame.origin.y+telButton.frame.size.height+10)];
        [UIView commitAnimations];
        _bool=NO;
    }else{
        introductionString.numberOfLines = 1;
        [introductionString setFrame:CGRectMake(72, 65, 225, 15)];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        
        [xiangxiButton setTitle:@"<更多>" forState:UIControlStateNormal];
        
        [kaishiyeTimeLabel setFrame:CGRectMake(72, introductionString.frame.origin.y, 200, 15)];
        kaishiyeTimeLabel.hidden = YES;
        
        [fuzerenLabel setFrame:CGRectMake(72, introductionString.frame.origin.y, 200, 15)];
        fuzerenLabel.hidden = YES;
        
        [fuwuquyuLabel setFrame:CGRectMake(72, introductionString.frame.origin.y, 200, 15)];
        fuwuquyuLabel.hidden = YES;
        
        [addressButton setFrame:CGRectMake(0, introductionString.frame.origin.y+25, 300, 40)];
        [telButton setFrame:CGRectMake(0, addressButton.frame.origin.y+50, 300, 40)];
        
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, telButton.frame.origin.y+telButton.frame.size.height+10)];
        [UIView commitAnimations];
       
        _bool=YES;
    }
    return self;
}

-(void)xiangxi
{
    if (delegate) {
        [delegate Ty_UserInfroCompanyView:[self setDetailView]];
    }
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
