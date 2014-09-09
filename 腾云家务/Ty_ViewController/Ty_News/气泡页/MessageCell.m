//
//  MessageCell.m
//  Message
//
//  Created by liu on 14-5-29.
//  Copyright (c) 2014年 刘美超. All rights reserved.
//

#import "MessageCell.h"
#import "Ty_Model_MessageInfo.h"

@implementation MessageCell

@synthesize contentBgImageView = _contentBgImageView;
@synthesize contentLabel = _contentLabel;
@synthesize headerImageView = _headerImageView;
@synthesize timeLabel = _timeLabel;
@synthesize sendFailImgView = _sendFailImgView;
@synthesize playVoiceBtn = _playVoiceBtn;
@synthesize playVoiceImageView = _playVoiceImageView;
@synthesize delegate = _delegate;
@synthesize sendFailBtn = _sendFailBtn;
@synthesize activityIndicatorView = _activityIndicatorView;

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
        //        _contentImageView.image = [UIImage imageNamed:@"ReceiverTextNodeBkg"];
        [self.contentView addSubview:_contentBgImageView];
        _contentBgImageView.userInteractionEnabled = YES;
        [self addSubview:_contentBgImageView];
        
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _contentLabel.userInteractionEnabled = YES;
        [_contentBgImageView addSubview:_contentLabel];
        
    
        //与语音相关
        _playVoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       // _playVoiceBtn.frame = CGRectMake(10, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        [_contentBgImageView addSubview:_playVoiceBtn];
        _playVoiceBtn.hidden = YES;
        _playVoiceBtn.selected = NO;
        
        _playVoiceImageView = [[UIImageView alloc]init];
        _playVoiceImageView.userInteractionEnabled = NO;
        [_playVoiceBtn addSubview:_playVoiceImageView];
        
        
        _voiceTimeLabel = [[UILabel alloc]init];
        _voiceTimeLabel.backgroundColor = [UIColor clearColor];
        _voiceTimeLabel.textColor = [UIColor grayColor];
        _voiceTimeLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_voiceTimeLabel];
        
        
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(labelLongPressed:)];
        longPressGestureRecognizer.minimumPressDuration = 1;
        longPressGestureRecognizer.delegate = self;
        [_contentBgImageView addGestureRecognizer:longPressGestureRecognizer];
        longPressGestureRecognizer = nil;
        
        _sendFailImgView = [[UIImageView alloc]initWithFrame:CGRectMake(-5, -5, 25 , 25)];
       // [_contentBgImageView addSubview:_sendFailImgView];
        
        _sendFailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendFailBtn.frame = CGRectMake(-5, -5, 25, 25);
        [_sendFailBtn setBackgroundImage:[UIImage imageNamed:@"Message_Fail"] forState:UIControlStateNormal];
        [_contentBgImageView addSubview:_sendFailBtn];
        _sendFailBtn.hidden = YES;
        
        //发送信息时转得圈圈
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
   
        _voiceUnreadImageView = [[UIImageView alloc]init];
        _voiceUnreadImageView.image = [UIImage imageNamed:@"Message_UnreadImage"];
        [_contentBgImageView addSubview:_voiceUnreadImageView];
        _voiceUnreadImageView.hidden = YES;
        
       
        
    }
    return self;
}

- (void)setCellContent:(Ty_Model_MessageInfo *)messageInfo
{
    //contact
    
    CGSize size;
    size = messageInfo.messageType == -1 ? [messageInfo.messageContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.frame.size.width - 150, 500) lineBreakMode:NSLineBreakByCharWrapping] : CGSizeMake(20, 28);
    
   // size = [messageInfo.messageContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.frame.size.width - 150, 500) lineBreakMode:NSLineBreakByCharWrapping];
    
    
    
    
    /**
     *  重新设置气泡及头像的frame，按发送者区分。
     */
  //  NSLog(@"%@",MyLoginUserGuid);
    if ([messageInfo.messageSenderGuid isEqualToString:MyLoginUserGuid])//自己为发送者
    {
        /**
         *  定义默认头像：分为中介与非中介；非中介分男女
         */
        UIImage *placehoderImage = nil;
        if ([[MyLoginInformation objectForKey:@"userType"]integerValue] == 0)
        {
            placehoderImage = [UIImage imageNamed:@"Message_Service"];
        }
        else
        {
            placehoderImage = [MyLoginInformation objectForKey:@"userSex"] == 0 ? [UIImage imageNamed:@"Message_Male"] : [UIImage imageNamed:@"Message_Female"];
        }
        
        
        if (ISNULL([[NSUserDefaults standardUserDefaults]objectForKey:@"MyEmployeeHead"])) {
            
            [_headerImageView setImageWithURL:[NSURL URLWithString:[MyLoginInformation objectForKey:@"smallUserPhoto"]] placeholderImage:placehoderImage];
            
            
        }else{
            
            _headerImageView.image = [UIImage imageWithContentsOfFile:[[NSUserDefaults standardUserDefaults]objectForKey:@"MyEmployeeHead"]];
            
        }
        
        _contentBgImageView.image = [[UIImage imageNamed:@"Message_SenderTextNodeBkg_ios7"] stretchableImageWithLeftCapWidth:40 topCapHeight:30];
        [_headerImageView setFrame:CGRectMake(320 - 45, 35, 40, 40)];
        _contentBgImageView.frame = CGRectMake(320 - 60 - size.width - 50, 35, size.width + 50, size.height < 20 ? size.height + 30 : size.height + 20);
        
        _sendFailImgView.image = messageInfo.messageIsSendSuccess == 0 ? [UIImage imageNamed:@"Message_Fail"] : nil;
        _sendFailBtn.hidden = messageInfo.messageIsSendSuccess == 0 ? NO : YES;
        
        //[_headerImageView setImageWithURL:[NSURL URLWithString:[MyLoginInformation objectForKey:@"smallUserPhoto"]] placeholderImage:placehoderImage];
        
        _activityIndicatorView.center = CGPointMake(_contentBgImageView.frame.origin.x - 30, _contentBgImageView.frame.size.height / 2 + 30);
        
        _voiceUnreadImageView.hidden = YES;
        
       // _activityIndicatorView.hidden = YES;
        
        _isSelf = YES;
    }
    else
    {
        /**
         *  定义默认头像：分为中介与非中介；非中介分男女
         */
        UIImage *placehoderImage = nil;
        /**
         *  定义默认头像：分为中介与非中介；非中介分男女
         */
        if ([MyLoginUserType isEqualToString:@"0"]) //若我是商户，则对方一定是个人
        {
            placehoderImage = messageInfo.messageContactSex == 0 ? [UIImage imageNamed:@"Message_Male"] : [UIImage imageNamed:@"Message_Female"];
        }
        else
        {
            placehoderImage = [UIImage imageNamed:@"Message_Service"];
        }
        
        _contentBgImageView.image = [ [UIImage imageNamed:@"Message_ReceiverTextNodeBkg_ios7"]  stretchableImageWithLeftCapWidth:40 topCapHeight:30];
         [_headerImageView setFrame:CGRectMake(5, 35, 40, 40)];
        _contentBgImageView.frame = CGRectMake(60, 35, size.width + 50, size.height < 20 ? size.height + 30 : size.height + 20);
        _sendFailImgView.image = nil;
        _sendFailBtn.hidden = YES;
      //  _activityIndicatorView.hidden = YES;
        [_headerImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PhotoUrl,messageInfo.messageContactPhoto]] placeholderImage:placehoderImage];
        
        if (messageInfo.messageType != -1)
        {
            _voiceUnreadImageView.frame = CGRectMake(_contentBgImageView.frame.size.width, -5, 15, 15);
            _voiceUnreadImageView.hidden = messageInfo.messageIsVoiceRead == 0 ? NO : YES;
        }
        else
        {
            _voiceUnreadImageView.hidden = YES;
        }
        
        _isSelf = NO;
    }
    
    //如果是小Q，特殊处理头像
    if ([messageInfo.messageSenderGuid isEqualToString:Message_Q_Guid])
    {
        _headerImageView.image = [UIImage imageNamed:@"Message_Q"];
    }
    
    _contentLabel.frame = CGRectMake(25, 5, self.frame.size.width - 150, _contentBgImageView.frame.size.height - 15);
    
    if (messageInfo.messageTime.length > 0)
    {
        _timeLabel.text = [messageInfo.messageTime substringWithRange:NSMakeRange(5, 11)];
    }
    
    
    if (messageInfo.messageType == -1)
    {
        _contentLabel.text = messageInfo.messageContent;
        _playVoiceBtn.hidden = YES;
        _voiceTimeLabel.text = @"";
    }
    else
    {
        _playVoiceBtn.hidden = NO;
        _playVoiceBtn.frame = CGRectMake(25, 10, 20, 20);
        _playVoiceImageView.frame = CGRectMake(0, 0, 20, 20);
        
        _playVoiceImageView.image = [messageInfo.messageSenderGuid isEqualToString:MyLoginUserGuid] ? [UIImage imageNamed:@"SenderVoiceNodePlaying_ios7"] : [UIImage imageNamed:@"ReceiverVoiceNodePlaying_ios7"];
        /*
        [_playVoiceBtn setBackgroundImage:[messageInfo.messageSenderGuid isEqualToString:MyLoginUserGuid] ? [UIImage imageNamed:@"SenderVoiceNodePlaying_ios7"] : [UIImage imageNamed:@"ReceiverVoiceNodePlaying_ios7"] forState:UIControlStateNormal];
        
        [_playVoiceBtn setBackgroundImage:[messageInfo.messageSenderGuid isEqualToString:MyLoginUserGuid] ? [UIImage imageNamed:@"SenderVoiceNodePlaying_ios7"] : [UIImage imageNamed:@"ReceiverVoiceNodePlaying_ios7"] forState:UIControlStateSelected];
        */
        _voiceTimeLabel.frame = [messageInfo.messageSenderGuid isEqualToString:MyLoginUserGuid] ? CGRectMake(_contentBgImageView.frame.origin.x - 18, 45, 30, 20) : CGRectMake(_contentBgImageView.frame.origin.x + _contentBgImageView.frame.size.width , 45, 30, 20) ;
        _voiceTimeLabel.textAlignment = [messageInfo.messageSenderGuid isEqualToString:MyLoginUserGuid] ? NSTextAlignmentLeft : NSTextAlignmentRight;
        _voiceTimeLabel.text = [NSString stringWithFormat:@"%d''",messageInfo.messageType];
        _contentLabel.text = @"";
    }
    

    if (size.height < 40)
    {
        
        self.frame = CGRectMake(0, 0, 320, size.height + 70);
    }
    else
    {
        self.frame = CGRectMake(0, 0, 320, size.height + 55);
    }
    
    messageInfo.messageHeight = self.frame.size.height;
}

- (void)labelLongPressed:(UILongPressGestureRecognizer *)longPress
{
   // NSLog(@"长按~~~");
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        CGPoint location = [longPress locationInView:self.superview.superview];
        
       // NSLog(@"%f",location.y);
        
        if ([_delegate respondsToSelector:@selector(LongPressGestureMethod:)])
        {
            [_delegate LongPressGestureMethod:location];
        }
        
    
       
    }
}

- (void)playVoice
{
    //ios 7                         //qipao
  //  NSLog(@"%@",_playVoiceBtn.superview.superview.superview);

    if (_playVoiceBtn.selected)
    {
    //    NSLog(@"停止播放~");
        _playVoiceBtn.selected = NO;
    }
    else
    {
        _playVoiceBtn.selected = YES;
      //  NSLog(@"播放录音~") ;
    }
}


#pragma mark --- gestureRecognizer delegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UIButton class]])
    {
        return YES;
    }
    return YES;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    /*
    if (selected)
    {
        _contentBgImageView.image = _isSelf ? [ [UIImage imageNamed:@"Message_SenderTextNodeBkg_HL"]  stretchableImageWithLeftCapWidth:40 topCapHeight:30] : [ [UIImage imageNamed:@"Message_ReceiverTextNode_HL"]  stretchableImageWithLeftCapWidth:40 topCapHeight:30];
    }
    else
    {
        _contentBgImageView.image = _isSelf ? [ [UIImage imageNamed:@"Message_SenderTextNodeBkg_ios7"]  stretchableImageWithLeftCapWidth:40 topCapHeight:30] : [ [UIImage imageNamed:@"Message_ReceiverTextNodeBkg_ios7"]  stretchableImageWithLeftCapWidth:40 topCapHeight:30];
    }
    */

    // Configure the view for the selected state
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    /*
    if (highlighted)
    {
        _contentBgImageView.image = _isSelf ? [ [UIImage imageNamed:@"Message_SenderTextNodeBkg_HL"]  stretchableImageWithLeftCapWidth:40 topCapHeight:30] : [ [UIImage imageNamed:@"Message_ReceiverTextNode_HL"]  stretchableImageWithLeftCapWidth:40 topCapHeight:30];
    }
    else
    {
        _contentBgImageView.image = _isSelf ? [ [UIImage imageNamed:@"Message_SenderTextNodeBkg_ios7"]  stretchableImageWithLeftCapWidth:40 topCapHeight:30] : [ [UIImage imageNamed:@"Message_ReceiverTextNodeBkg_ios7"]  stretchableImageWithLeftCapWidth:40 topCapHeight:30];
    }
     */
}

@end
