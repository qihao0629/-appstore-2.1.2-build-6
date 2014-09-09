//
//  Ty_OrderVC_EmployeeCell.m
//  腾云家务
//
//  Created by lgs on 14-7-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_EmployeeCell.h"

@implementation Ty_OrderVC_EmployeeCell
@synthesize portraitPhotoImageView;
@synthesize workerNameLabel;
@synthesize phoneNumberLabel;
@synthesize phoneButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setFrame:CGRectMake(0, 0, MainFrame.size.width - 20, 61)];
        
        portraitPhotoImageView = [[UIImageView alloc]init];
        
        [portraitPhotoImageView setFrame:CGRectMake(10,10, 46, 46)];
        portraitPhotoImageView.layer.cornerRadius = 5.0;
        [portraitPhotoImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:portraitPhotoImageView];
        
        workerNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 13, 190, 15)];
        [self.workerNameLabel setBackgroundColor:[UIColor clearColor]];
        [self.workerNameLabel setFont:FONT13_BOLDSYSTEM];
        [self.workerNameLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.workerNameLabel setTextColor:[UIColor grayColor]];
        [self.workerNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:workerNameLabel];
        
        phoneNumberLabel = [[UILabel alloc]init];
        [phoneNumberLabel setFrame:CGRectMake(65,36, 200, 25)];
        [phoneNumberLabel setBackgroundColor:[UIColor clearColor]];
        [phoneNumberLabel setHighlightedTextColor:[UIColor whiteColor]];
        [phoneNumberLabel setTextColor:[UIColor grayColor]];
        [phoneNumberLabel setFont:FONT13_BOLDSYSTEM];
        [phoneNumberLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self addSubview:phoneNumberLabel];

        phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [phoneButton setFrame:CGRectMake(252, 20, 48, 20)];
        [phoneButton setImage:[UIImage imageNamed:@"redPhoneIcon"] forState:UIControlStateNormal];
        
        [self addSubview:phoneButton];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
