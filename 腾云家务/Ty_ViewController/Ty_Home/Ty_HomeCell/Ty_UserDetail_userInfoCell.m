//
//  Ty_UserDetail_userInfoCell.m
//  腾云家务
//
//  Created by 齐 浩 on 14-2-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_UserDetail_userInfoCell.h"

@implementation Ty_UserDetail_userInfoCell
@synthesize fifthLabel,fifthValue;
@synthesize secondLabel,secondValue;
@synthesize thridLabel,thridValue;
@synthesize fourthLabel,fourthValue;
@synthesize firstLabel,firstValue;
@synthesize sixthLabel,sixthValue;
@synthesize seventhLabel,seventhValue;

#define BianColor [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1]
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 30, 15)];
        [firstLabel setBackgroundColor:[UIColor clearColor]];
        [firstLabel setTextColor:[UIColor grayColor]];
        [firstLabel setFont:FONT12_SYSTEM];
        [firstLabel setText:@"性别:"];
        
        
        
        firstValue = [[UILabel alloc]initWithFrame:CGRectMake(45, firstLabel.frame.origin.y, 105, 15)];
        [firstValue setBackgroundColor:[UIColor clearColor]];
        [firstValue setTextColor:[UIColor grayColor]];
        [firstValue setFont:FONT12_SYSTEM];
        [firstValue setText:@"XXXXXX"];
        
        secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, firstLabel.frame.origin.y, 30, 15)];
        [secondLabel setBackgroundColor:[UIColor clearColor]];
        [secondLabel setTextColor:[UIColor grayColor]];
        [secondLabel setFont:FONT12_SYSTEM];
        [secondLabel setText:@"籍贯:"];
        
        secondValue = [[UILabel alloc]initWithFrame:CGRectMake(180, secondLabel.frame.origin.y, 120, 15)];
        secondValue.numberOfLines = 0;
        secondValue.lineBreakMode = NSLineBreakByCharWrapping;
        [secondValue setBackgroundColor:[UIColor clearColor]];
        [secondValue setTextColor:[UIColor grayColor]];
        [secondValue setFont:FONT12_SYSTEM];
        [secondValue setText:@"XXXXXXXXX"];
        
        thridLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, secondValue.frame.origin.y+secondValue.frame.size.height+5, 30, 15)];
        [thridLabel setBackgroundColor:[UIColor clearColor]];
        [thridLabel setTextColor:[UIColor grayColor]];
        [thridLabel setFont:FONT12_SYSTEM];
        [thridLabel setText:@"年龄:"];
        
        thridValue = [[UILabel alloc]initWithFrame:CGRectMake(45, thridLabel.frame.origin.y, 105, 15)];
        [thridValue setBackgroundColor:[UIColor clearColor]];
        [thridValue setTextColor:[UIColor grayColor]];
        [thridValue setFont:FONT12_SYSTEM];
        [thridValue setText:@"XXXXXXXXX"];
        
        fourthLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, thridLabel.frame.origin.y, 30, 15)];
        [fourthLabel setBackgroundColor:[UIColor clearColor]];
        [fourthLabel setTextColor:[UIColor grayColor]];
        [fourthLabel setFont:FONT12_SYSTEM];
        [fourthLabel setText:@"学历:"];
        
        fourthValue = [[UILabel alloc]initWithFrame:CGRectMake(180, fourthLabel.frame.origin.y, 120, 15)];
        [fourthValue setBackgroundColor:[UIColor clearColor]];
        [fourthValue setTextColor:[UIColor grayColor]];
        [fourthValue setFont:FONT12_SYSTEM];
        [fourthValue setText:@"XXXXXXXXX"];
        
        fifthLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, fourthValue.frame.origin.y+fourthValue.frame.size.height+5, 30, 15)];
        [fifthLabel setBackgroundColor:[UIColor clearColor]];
        [fifthLabel setTextColor:[UIColor grayColor]];
        [fifthLabel setFont:FONT12_SYSTEM];
        [fifthLabel setText:@"区域:"];
        
        fifthValue = [[UILabel alloc]initWithFrame:CGRectMake(45, fifthLabel.frame.origin.y, 255, 15)];
        [fifthValue setBackgroundColor:[UIColor clearColor]];
        [fifthValue setTextColor:[UIColor grayColor]];
        [fifthValue setFont:FONT12_SYSTEM];
        [fifthValue setText:@"XXXXXXXXXXXX"];
        
        sixthLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, fifthValue.frame.origin.y+fifthValue.frame.size.height+5, 30, 15)];
        [sixthLabel setBackgroundColor:[UIColor clearColor]];
        [sixthLabel setTextColor:[UIColor grayColor]];
        [sixthLabel setFont:FONT12_SYSTEM];
        [sixthLabel setText:@"介绍:"];
        
        sixthValue = [[UILabel alloc]initWithFrame:CGRectMake(45, sixthLabel.frame.origin.y, 255, 20)];
        [sixthValue setBackgroundColor:[UIColor clearColor]];
        [sixthValue setTextColor:[UIColor grayColor]];
        [sixthValue setFont:FONT12_SYSTEM];
        [sixthValue setText:@"XXXXXXXXXXXX"];
        sixthValue.numberOfLines = 0;
        sixthValue.lineBreakMode = NSLineBreakByCharWrapping;
        
        [self setFrame:CGRectMake(0, 0, 300, sixthValue.frame.origin.y+sixthValue.frame.size.height+15)];
//        [self.contentView setBackgroundColor:[UIColor whiteColor]];
//        
//        
//        UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.frame];
//        [self.contentView addSubview:imageView];
//        
//        UIGraphicsBeginImageContext(imageView.frame.size);
//        [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
//        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0);
//        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
//        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 210.0/255.0, 210.0/255.0, 210.0/255.0, 1.0);
//        CGContextBeginPath(UIGraphicsGetCurrentContext());
//        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0 , 30);
//        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 300, 30);
//        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0 , 60);
//        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 300, 60);
//        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0 , 90);
//        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 300, 90);
//        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0 , 120);
//        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 300, 120);
//        
//        CGContextStrokePath(UIGraphicsGetCurrentContext());
//        imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
        
        
        
        [self.contentView addSubview:firstLabel];
        [self.contentView addSubview:firstValue];
        [self.contentView addSubview:secondLabel];
        [self.contentView addSubview:secondValue];
        [self.contentView addSubview:thridLabel];
        [self.contentView addSubview:thridValue];
        [self.contentView addSubview:fourthLabel];
        [self.contentView addSubview:fourthValue];
        [self.contentView addSubview:fifthLabel];
        [self.contentView addSubview:fifthValue];
        [self.contentView addSubview:sixthLabel];
        [self.contentView addSubview:sixthValue];

        
        
//        self.layer.masksToBounds = YES;
//        //给图层添加一个有色边框
//        self.layer.borderWidth = 0.5;
//        self.layer.borderColor = [Color_210 CGColor];
    }
    return self;
}
-(void)setHeight
{
//    CGSize secondSize = [secondValue.text sizeWithFont:FONT14_BOLDSYSTEM constrainedToSize:CGSizeMake(secondValue.frame.size.width, secondValue.frame.size.height*3) lineBreakMode:NSLineBreakByCharWrapping];
    CGSize sixSize = [sixthValue.text sizeWithFont:FONT12_SYSTEM constrainedToSize:CGSizeMake(sixthValue.frame.size.width, sixthValue.frame.size.height*10) lineBreakMode:NSLineBreakByCharWrapping];
    
    if (sixSize.height>sixthValue.frame.size.height) {
        [sixthValue setFrame:CGRectMake(sixthValue.frame.origin.x, sixthValue.frame.origin.y, sixthValue.frame.size.width, sixSize.height)];
    }else{
        [sixthValue setFrame:CGRectMake(sixthValue.frame.origin.x, sixthValue.frame.origin.y, sixthValue.frame.size.width, sixthValue.frame.size.height)];
    }
    [self setFrame:CGRectMake(0, 0, 300, sixthValue.frame.origin.y+sixthValue.frame.size.height+15)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
