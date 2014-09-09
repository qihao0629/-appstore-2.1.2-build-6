//
//  LifeTipsCell.m
//  腾云家务
//
//  Created by liu on 14-8-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "LifeTipsCell.h"

@implementation LifeTipsCell

@synthesize timeLabel = _timeLabel;
@synthesize headerImageView = _headerImageView;
@synthesize contentLabel = _contentLabel;
@synthesize contentBgImageView = _contentBgImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 5, 90, 20)];
        _timeLabel.backgroundColor = [UIColor colorWithRed:212.0/255 green:212.0/255 blue:212.0/255 alpha:1.0];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_timeLabel];
        
        _headerImageView = [[UIImageView alloc]init];
        [self addSubview:_headerImageView];
        
        _contentBgImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_contentBgImageView];
        _contentBgImageView.userInteractionEnabled = YES;
        [self addSubview:_contentBgImageView];
        
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.userInteractionEnabled = YES;
        _contentLabel.tag = 200;
        [_contentBgImageView addSubview:_contentLabel];
        
    }
    
    return self;
}

- (void)setContent:(Ty_Model_LifeTipsInfo *)lifeTipsInfo
{
    //  _colorfulTextView.originalString = [self anaosyStr:messageInfo.systemMsgContent];
    
    CGSize size = [lifeTipsInfo.lifeTipsContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.frame.size.width - 150, 5000) lineBreakMode:NSLineBreakByWordWrapping];
    
    _contentBgImageView.image = [ [UIImage imageNamed:@"Message_ReceiverTextNodeBkg_ios7"]  stretchableImageWithLeftCapWidth:40 topCapHeight:30];
    _contentBgImageView.frame = CGRectMake(60, 35, size.width + 50, size.height < 20 ? size.height + 30 : size.height + 20);
    
    [_headerImageView setFrame:CGRectMake(5, 35, 40, 40)];
    _headerImageView.image = [UIImage imageNamed:@"lifeTip"];
    
    _contentLabel.frame = CGRectMake(25, 5, self.frame.size.width - 150, _contentBgImageView.frame.size.height - 15);
    //  _colorfulTextView.frame = CGRectMake(0, 5, self.frame.size.width - 150, _contentLabel.frame.size.height - 15);
    
    //  _contentLabel.text = messageInfo.systemMsgContent;
    
    if (lifeTipsInfo.lifeTipsDate.length > 0)
    {
        _timeLabel.text = [lifeTipsInfo.lifeTipsDate substringWithRange:NSMakeRange(5, 11)];
    }
    
    
    if (size.height < 40)
    {
        
        self.frame = CGRectMake(0, 0, 320, size.height + 70);
    }
    else
    {
        self.frame = CGRectMake(0, 0, 320, size.height + 55);
    }
    
    _contentLabel.text = lifeTipsInfo.lifeTipsContent;
    
    
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
