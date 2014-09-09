//
//  SignedCell.m
//  腾云家务
//
//  Created by 艾飞 on 13-12-19.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "SignedCell.h"

@implementation SignedCell
@synthesize imageHead,labelName,labelPhone,labelWork,butPhone;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    imageHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 50, 50)];
    [self.contentView addSubview:imageHead];
    imageHead.image = [UIImage imageNamed:@"Contact_image.png"];
    CALayer * layer=[imageHead layer];
    [layer setMasksToBounds:YES];
    [layer setBorderWidth:1];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.contentView addSubview:imageHead];
    
    labelName = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 250, 20)];
    labelName.text = @"名字";
    labelName.font = [UIFont boldSystemFontOfSize:15.0];
//    labelName.numberOfLines = 0;
    [self.contentView addSubview:labelName];
    
    labelPhone = [[UILabel alloc]initWithFrame:CGRectMake(70, 35, 250, 20)];
//    labelPhone.textColor = [UIColor colorWithRed:166.0/255.0 green:166.0/255.0 blue:166.0/255.0 alpha:1.0];
//    labelPhone.text = @"电话：1234567322";
    labelPhone.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:labelPhone];

    labelWork = [[UILabel alloc]initWithFrame:CGRectMake(70, 50, 230, 11)];
    labelWork.textColor = [UIColor colorWithRed:166.0/255.0 green:166.0/255.0 blue:166.0/255.0 alpha:1.0];
//    labelWork.text = @"保洁 家政 教育 教师";
    labelWork.font = [UIFont boldSystemFontOfSize:11.0];
    labelWork.hidden = YES;//废弃 暂停使用
    [self.contentView addSubview:labelWork];
    
    butPhone = [UIButton buttonWithType:UIButtonTypeCustom];
    butPhone.frame = CGRectMake(0, 0, 0, 0);
    
    [self.contentView addSubview:butPhone];
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
