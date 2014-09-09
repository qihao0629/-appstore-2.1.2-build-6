//
//  Ty_UserDetail_evaluationCell.m
//  腾云家务
//
//  Created by 齐 浩 on 13-10-9.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "Ty_UserDetail_evaluationCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation Ty_UserDetail_evaluationCell
@synthesize typeLabel;
@synthesize headImage;
@synthesize backView;
@synthesize pingjiaLabel;
@synthesize customstar;
@synthesize zhiliangLabel;
@synthesize taiduLabel;
@synthesize suduLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, 300, 70)];
        typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [typeLabel setBackgroundColor:[UIColor clearColor]];
        [typeLabel setTextColor:text_grayColor];
        [typeLabel setFont:FONT15_SYSTEM];
        [typeLabel setText:@"历史评价"];
        
        headImage = [[UIImageView alloc]initWithFrame:CGRectMake(8, typeLabel.frame.origin.y+typeLabel.frame.size.height+10, 48, 48)];
        [headImage setImage:[UIImage imageNamed:@"Contact_image"]];
        headImage.layer.masksToBounds = YES;
        headImage.layer.borderColor = [Color_200 CGColor];
        headImage.layer.borderWidth = 1.0;

        backView = [[UIView alloc]initWithFrame:CGRectMake(66, headImage.frame.origin.y, 254, 13)];
        [backView setBackgroundColor:[UIColor clearColor]];
        
        customstar = [[CustomStar alloc]initWithFrame:CGRectMake(0, 0, 73, 13) Number:5];
        [customstar setCustomStarNumber:4.5];
        [customstar setUserInteractionEnabled:NO];
        
        zhiliangLabel = [[UILabel alloc]initWithFrame:CGRectMake(81, 0, 51, 13)];
        [zhiliangLabel setBackgroundColor:[UIColor clearColor]];
        [zhiliangLabel setHighlightedTextColor:[UIColor whiteColor]];
        [zhiliangLabel setFont:FONT11_SYSTEM];
        [zhiliangLabel setText:@"质量：4"];
        
        taiduLabel = [[UILabel alloc]initWithFrame:CGRectMake(132, 0, 51, 13)];
        [taiduLabel setBackgroundColor:[UIColor clearColor]];
        [taiduLabel setHighlightedTextColor:[UIColor whiteColor]];
        [taiduLabel setFont:FONT11_SYSTEM];
        [taiduLabel setText:@"态度：5"];
        
        suduLabel = [[UILabel alloc]initWithFrame:CGRectMake(183, 0, 51, 13)];
        [suduLabel setBackgroundColor:[UIColor clearColor]];
        [suduLabel setHighlightedTextColor:[UIColor clearColor]];
        [suduLabel setFont:FONT11_SYSTEM];
        [suduLabel setText:@"速度：4"];
        
        [backView addSubview:customstar];
        [backView addSubview:zhiliangLabel];
        [backView addSubview:taiduLabel];
        [backView addSubview:suduLabel];
        
        pingjiaLabel = [[UILabel alloc]initWithFrame:CGRectMake(66, backView.frame.origin.y+backView.frame.size.height+8, 230, self.frame.size.height-(backView.frame.origin.y+backView.frame.size.height+8))];
        [pingjiaLabel setBackgroundColor:[UIColor clearColor]];
        [pingjiaLabel setFont:FONT11_SYSTEM];
        [pingjiaLabel setHighlightedTextColor:[UIColor whiteColor]];
        [pingjiaLabel setText:@"服务特别到位，有特殊要求也能及时满足。"];
        pingjiaLabel.lineBreakMode = NSLineBreakByCharWrapping;
        pingjiaLabel.numberOfLines = 0;
        
        [self.contentView addSubview:typeLabel];
        [self.contentView addSubview:headImage];
        [self.contentView addSubview:backView];
        [self.contentView addSubview:pingjiaLabel];
        
        
    }
    return self;
}
-(float)setHight
{
    
    if (!typeLabel.hidden) {
        
        [self setFrame:CGRectMake(0, 0, 300, 90)];
        [typeLabel setFrame:CGRectMake(10, 5, 200, 15)];
    }
    
    [headImage setFrame:CGRectMake(8, typeLabel.frame.origin.y+typeLabel.frame.size.height+10, 48, 48)];
    [backView setFrame:CGRectMake(66, headImage.frame.origin.y, 254, 13)];
    
    [pingjiaLabel setFrame:CGRectMake(66, backView.frame.origin.y+backView.frame.size.height+8, 230, self.frame.size.height-(backView.frame.origin.y+backView.frame.size.height+8))];
    
    CGSize detailSize = [self.pingjiaLabel.text sizeWithFont:FONT11_SYSTEM constrainedToSize:CGSizeMake(self.pingjiaLabel.frame.size.width, self.pingjiaLabel.frame.size.height*3) lineBreakMode:NSLineBreakByCharWrapping];
    
    [self.pingjiaLabel setFrame:CGRectMake(pingjiaLabel.frame.origin.x, pingjiaLabel.frame.origin.y, detailSize.width, detailSize.height)];
    if (self.pingjiaLabel.frame.size.height>self.frame.size.height-(backView.frame.origin.y+backView.frame.size.height+8)) {
        [self setFrame:CGRectMake(0, 0, 300, backView.frame.origin.y+backView.frame.size.height+8+self.pingjiaLabel.frame.size.height)];
    }
    return self.frame.size.height;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
