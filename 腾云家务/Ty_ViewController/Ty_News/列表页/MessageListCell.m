//
//  MessageListCell.m
//  腾云家务
//
//  Created by liu on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "MessageListCell.h"
#import "Ty_Model_MessageInfo.h"

@implementation MessageListCell

@synthesize headerImageView = _headerImageView;
@synthesize nameLabel = _nameLabel;
@synthesize contentLabel = _contentLabel;
@synthesize timeLabel = _timeLabel;
@synthesize remindNumLabel = _remindNumLabel;
@synthesize remindSignImageView = _remindSignImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 45, 45)];
        _headerImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_headerImageView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 8, 200, 20)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
        _nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_nameLabel];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 34, 225, 20)];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_contentLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(220, 15, 80, 20)];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_timeLabel];
        
        _remindSignImageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 0, 30, 30)];
      //  _remindSignImageView.image = [UIImage imageNamed:];
        [self.contentView addSubview:_remindSignImageView];
        
        _remindNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        _remindNumLabel.backgroundColor = [UIColor clearColor];
        _remindNumLabel.textColor = [UIColor whiteColor];
        _remindNumLabel.textAlignment = NSTextAlignmentCenter;
        _remindNumLabel.font = [UIFont systemFontOfSize:12];
        [_remindSignImageView addSubview:_remindNumLabel];
        
        
    }
    return self;
}

- (void)setCellContent:(Ty_Model_MessageInfo *)messageInfo cellRows:(NSInteger)row
{
    
    if(row < 3)
    {
       _nameLabel.text = messageInfo.messageContactRealName;
    }
    else
    {
        _nameLabel.text = messageInfo.messageContactRealName.length > 0 ? messageInfo.messageContactRealName : @"腾云用户";
        if (!ISNULLSTR(messageInfo.messageContactAnnear))
        {
            _nameLabel.text  = [_nameLabel.text stringByAppendingFormat:@"(%@)",messageInfo.messageContactAnnear];
        }
    }
    
    
    if (messageInfo.messageUnreadNum != 0)
    {
        _remindSignImageView.image = [UIImage imageNamed:@"Message_UnreadImage@2x"];
        _remindNumLabel.text = [NSString stringWithFormat:@"%d",messageInfo.messageUnreadNum];
       // NSLog(@"%d",messageInfo.messageUnreadNum);
    }
    else
    {
        _remindSignImageView.image = nil;
        _remindNumLabel.text = @"";
    }
    
    /**
     *  定义默认头像：分为中介与非中介；非中介分男女
     */
    UIImage *placehoderImage = nil;
    if ([MyLoginUserType isEqualToString:@"0"]) //若我是商户，则对方一定是个人
    {
        placehoderImage = messageInfo.messageContactSex == 0 ? [UIImage imageNamed:@"Message_Male"] : [UIImage imageNamed:@"Message_Female"];
    }
    else
    {
        placehoderImage = [UIImage imageNamed:@"Message_Service"];
    }
    
    if (row == 0)
    {
        _headerImageView.image = [UIImage imageNamed:@"Message_Q"];
        _contentLabel.text = messageInfo.messageType > 0 ?   @"[语音]" : messageInfo.messageContent;
    }
    else if (row == 1)
    {
        _headerImageView.image = [UIImage imageNamed:@"Message_System"];
        _contentLabel.text = messageInfo.messageContent;
    }
    /*
    else if (row == 2)
    {
        _headerImageView.image = [UIImage imageNamed:@"Message_Notification"];
        _contentLabel.text = messageInfo.messageContent;
    }
     */
    else if (row == 2) //生活小贴士测试
    {
        _headerImageView.image = [UIImage imageNamed:@"lifeTip"];
        _contentLabel.text = messageInfo.messageContent;
    }
     
    else
    {
        [_headerImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PhotoUrl,messageInfo.messageContactPhoto]] placeholderImage:placehoderImage];
        _contentLabel.text = messageInfo.messageType == -1 ?  messageInfo.messageContent : @"[语音]";
    }
    
    //时间处理
    if (messageInfo.messageTime.length > 0)
    {
        NSString *timeDay = [[messageInfo.messageTime componentsSeparatedByString:@" " ]objectAtIndex:0];
        NSString *timeToday = [self getCurrentTime];
        if ([timeDay isEqualToString:timeToday])// 今天的消息
        {
            _timeLabel.text = [[[messageInfo.messageTime componentsSeparatedByString:@" " ]objectAtIndex:1] substringToIndex:5];
        }
        else
        {
            _timeLabel.text = [timeDay substringFromIndex:5];
        }
    }
}


#pragma mark --- 辅助信息-获取时间
- (NSString *)getCurrentTime
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *current = [dateFormatter stringFromDate:currentDate];
    dateFormatter = nil;
    return current;
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
