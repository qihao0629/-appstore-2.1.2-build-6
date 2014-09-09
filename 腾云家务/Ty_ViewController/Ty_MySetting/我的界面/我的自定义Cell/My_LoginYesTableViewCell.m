//
//  My_LoginYesTableViewCell.m
//  腾云家务
//
//  Created by 艾飞 on 14-5-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_LoginYesTableViewCell.h"

@implementation My_LoginYesTableViewCell
@synthesize imageViewHead,lableViewDetail,lableViewLogin,lableViewText;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imageViewHead = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 65, 65)];
        [self.contentView addSubview:imageViewHead];
        
        lableViewText = [[UILabel alloc]initWithFrame:CGRectMake(90, 16, 200, 20)];
        lableViewText.backgroundColor = [UIColor clearColor];
        lableViewText.font = [UIFont boldSystemFontOfSize:15.0f];
        [self.contentView addSubview:lableViewText];
        
        lableViewDetail = [[UILabel alloc]initWithFrame:CGRectMake(90, 50, 200, 20)];
        lableViewDetail.backgroundColor = [UIColor clearColor];
        lableViewDetail.font = [UIFont boldSystemFontOfSize:15.0f];
        [self.contentView addSubview:lableViewDetail];
        
        lableViewLogin = [[UILabel alloc]initWithFrame:CGRectMake(90, 34, 180, 20)];
        if (IOS7) {
            lableViewLogin.frame = CGRectMake(90, 34, 200, 20);
        }
        lableViewLogin.backgroundColor = [UIColor clearColor];
        lableViewLogin.textAlignment = UITextAlignmentRight;
        lableViewLogin.font = [UIFont boldSystemFontOfSize:15.0f];
        [self.contentView addSubview:lableViewLogin];    }
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
