//
//  MessageVC.m
//  MessageMVC
//
//  Created by liu on 14-5-26.
//  Copyright (c) 2014年 刘美超. All rights reserved.
//

#import "MessageVC.h"
#import "Guid.h"
#import "Ty_Model_MessageInfo.h"
#import "XmppManager.h"
#import "Ty_NewsVC.h"
#import "MessageCell.h"
#import "Ty_MessageList_Busine.h"
#import "AppDelegateViewController.h"



@interface MessageVC ()

@end

@implementation MessageVC

@synthesize contactGuid = _contactGuid;
@synthesize contactName = _contactName;
@synthesize contactRealName = _contactRealName;
@synthesize contactJIDName = _contactJIDName;
@synthesize  contactType = _contactType;
@synthesize contactSex = _contactSex;
@synthesize contactAnnear = _contactAnnear;
@synthesize contactImg = _contactImg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _contactJIDName = @"";
        _contactPhotoUrl = @"";
        _contactAnnear = @"";
        _contactSex = 0;
        _oldMessageCell = nil;
        _oldMessageInfo = nil;
        _pageNum = 0;
        _contactImg = @"";
    }
    return self;
}
- (void)dealloc
{
   // [super dealloc];
    _messageView = nil;
    _messageBusine = nil;
    
}

#pragma mark -----addKeyBoardNotification
#pragma mark notification
- (void)addKeyboardNotification
{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark --- key board selector
- (void)keyboardWillShow:(NSNotification *)notification
{
    //取得cell总得高度
    CGFloat allHeight = 0;
    for (Ty_Model_MessageInfo *messageInfo in _messageView.allMessageArr)
    {
        allHeight += messageInfo.messageHeight;
    }
    
    _messageView.allCellHeight = allHeight;
    
    NSDictionary* userInfo = [notification userInfo];
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    _messageView.keyBoardHeight = keyboardFrame.size.height;
    
    if (_messageView.allMessageArr.count > 0)
    {
        [_messageView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messageView.allMessageArr.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        _messageView.inputBgView.transform = CGAffineTransformMakeTranslation(0, -keyboardFrame.size.height);
        
        
        if (allHeight > _messageView.inputBgView.frame.origin.y && allHeight < _messageView.tableView.frame.size.height    )
        {
             _messageView.tableView.transform = CGAffineTransformMakeTranslation(0, - (allHeight - _messageView.inputBgView.frame.origin.y));
            
        }
        else if (allHeight > _messageView.tableView.frame.size.height  )
        {
           _messageView.tableView.transform = CGAffineTransformMakeTranslation(0, -keyboardFrame.size.height);
        }
        
        
        
    }completion:^(BOOL finished)
     {
          _messageView.hideView.hidden = NO;
 
        
     }];
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
  //  NSDictionary* userInfo = [notification userInfo];
   // CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
     //NSLog(@"~~~~~~~~~~~~~~~~~");
       // _messageView.tableView.transform = CGAffineTransformMakeTranslation(0, 0);
       // _messageView.inputBgView.transform = CGAffineTransformMakeTranslation(0, 0);
        
        _messageView.tableView.transform = CGAffineTransformIdentity;
        _messageView.inputBgView.transform = CGAffineTransformIdentity;
        
        
    }completion:^(BOOL finished)
     {
         _messageView.hideView.hidden = YES;
         /*
          _addBtn.selected = NO;
          _isSelfShow = YES;
          _hideView.hidden = NO;
          */
         
     }];
}

#pragma mark ---- touch delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (!_messageView.hideView.hidden)
    {
        _messageView.hideView.hidden = YES;
        
        [_messageView.messageTextView resignFirstResponder];

        
    }
    
}

#pragma mark -- voiceBtnPresses
/**
 *  语音与文字按钮的切换
 */
- (void)changeMessageStatus
{
    if (_messageView.voiceBtn.selected)
    {
        [_messageView.messageTextView resignFirstResponder];
    }
    
    
}

#pragma mark -- 录音相关---------------------
#pragma mark --- 开始录音
- (void)startRecord
{
    
    
        if ([self canRecord])
        {
            // 用户同意获取数据
            //创建录音文件，开始录音
            
            [self recordPrepare];
            
            //开始
            AVAudioSession *audioSession = [AVAudioSession sharedInstance];
            [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
            [audioSession setActive:YES error:nil];
            
            if ([_audioRecorder prepareToRecord])
            {
                [_audioRecorder record];
            }
            
            
            //设置定时检测
            _timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
        }
        else
        {
            // 可以显示一个提示框告诉用户这个app没有得到允许？
            [[[UIAlertView alloc] initWithTitle:@"无法录音" message:@"请在“设置-隐私-麦克风”选项中允许“腾云家务”访问你的麦克风" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            
        } 
   
    
    
    
}

- (void)prepareCancelRecord
{

    [_timer invalidate];
    _timer = nil;
}
- (void)continueRecord
{
    //设置定时检测
    if (_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
    }
    
}
//取消录音
- (void)cancelRecord
{
    [_audioRecorder deleteRecording];
    [_audioRecorder stop];
    [_timer invalidate];
    _audioRecorder = nil;
    _timer = nil;
}

//录音结束
- (void)recordEnd
{
   
    double voiceTime = _audioRecorder.currentTime;
  //  NSLog(@"%f",voiceTime);
    
    [_timer invalidate];
    _timer = nil;
    [_audioRecorder stop];
    
    _audioRecorder = nil;
    
    
    if (voiceTime < 1)//若录制时间小于1S，删除
    {
        [_messageView updateRecordImageView];
        [_audioRecorder deleteRecording];
        
        
         _messageView.recordStatusImageView.image = [UIImage imageNamed:@"Message_voiceTime_"];
        
        [self performSelector:@selector(changeStatusImageView) withObject:nil afterDelay:1];
        
    }
    else
    {
        _messageView.recordStatusImageView.image = [UIImage imageNamed:@"Message_barRVD_1"];
        _messageView.recordStatusImageView.hidden = YES;
        [self sendVoiceMessage:voiceTime];
        
    }
    
    //NSLog(@"%f",voiceTime);
    
}
- (void)changeStatusImageView
{
    _messageView.recordStatusImageView.image = [UIImage imageNamed:@"Message_voiceTime_"];
    _messageView.recordStatusImageView.hidden = YES;
}


- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                bCanRecord = YES;
            } else {
                bCanRecord = NO;
            }
        }];
    }
    
    return bCanRecord;
}

#pragma mark ------ 录音开始的准备工作
- (void)recordPrepare
{
    
    
    //录音设置
    NSMutableDictionary *recordSettingDic = [[NSMutableDictionary alloc]init];
    
    //设置录音格式
    [recordSettingDic setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    //设置录音采样频率
    [recordSettingDic setValue:[NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];
    //设置录音通道数 1或2
    [recordSettingDic setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样卫视 8 16 24 32
    [recordSettingDic setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [recordSettingDic setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [recordSettingDic setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    //录音的质量
    [recordSettingDic setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
     
     //设置存放路
    _voiceGuidStr = [[Guid share]getGuid];
    NSURL *recordUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@.wav",VoicePath,_voiceGuidStr]];
    

    //初始化
    NSError *error = nil;
    _audioRecorder = [[AVAudioRecorder alloc]initWithURL:recordUrl settings:recordSettingDic error:&error];
    //开启音量检测
    _audioRecorder.meteringEnabled = YES;
    _audioRecorder.delegate = self;
    recordSettingDic = nil;
    

    
  
}


#pragma mark --- 检测音量
- (void)detectionVoice
{
    //刷新音量数据
    [_audioRecorder updateMeters];
    
    double volume = pow(10, (0.05 * [_audioRecorder peakPowerForChannel:0]));
   // NSLog(@"%f",volume);
    //通知view更改动画
    [_messageView recordAnimation:volume];
                        
}

#pragma mark ----录音相关结束-----------------
#pragma mark --- 发送语音私信-----------------
- (void)sendVoiceMessage:(double)messageTime
{
    Ty_Model_MessageInfo *messageInfo = [[Ty_Model_MessageInfo alloc]init];
    
    messageInfo.messageType = messageTime;
    messageInfo.messageIsDelete = 0;
    messageInfo.messageIsRead = 1;
    messageInfo.messageIsSendSuccess = 1;
    messageInfo.messageIsVoiceRead = 1;
    messageInfo.messageSenderGuid = MyLoginUserGuid;
    messageInfo.messageContactGuid = _contactGuid;
    messageInfo.messageContactName = _contactName;
    messageInfo.messageContactRealName = _contactRealName;
    messageInfo.messageContactSex = _contactSex;
    messageInfo.messageContactType = _contactType;
    
    messageInfo.messageContactPhoto = _contactPhotoUrl.length > 0 ? _contactPhotoUrl :_contactImg;
    
     messageInfo.messageContactAnnear = _contactAnnear;
    
    if (_contactJIDName.length == 0 && [_contactJIDName isEqualToString:@""])
    {
        messageInfo.messageContactJIDName = [NSString stringWithFormat:@"%@_family",messageInfo.messageContactName];
    }
    else
    {
        messageInfo.messageContactJIDName = _contactJIDName;
    }
    messageInfo.messageContent = [NSString stringWithFormat:@"%@%@.wav",VoicePath,_voiceGuidStr];
    messageInfo.messageGuid = _voiceGuidStr;
    messageInfo.messageTime = [self getCurrentTime];
    
   
    [_messageView.allMessageArr addObject:messageInfo];
   // [_messageView.allMessageArr insertObject:messageInfo atIndex:0];
    [_messageView.tableView reloadData];
    if (_messageView.allMessageArr.count > 0)
    {
        [_messageView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messageView.allMessageArr.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    NSInteger indexRow = [_messageView.allMessageArr indexOfObject:messageInfo];
    MessageCell *cell = (MessageCell *)[_messageView.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexRow inSection:0]];

    [cell.activityIndicatorView startAnimating];

    
     [_messageBusine insertMessageIntoTable:messageInfo];
    //先上传到服务器，上传服务器成功之后，发送xmpp
    [_messageBusine sendVoiceMessageToService:messageInfo];
  //  messageInfo = nil;
    
    _pageNum ++;

}

#pragma mark --- 发送文字信息
- (void)sendMessage:(NSString *)message
{
    Ty_Model_MessageInfo *messageInfo = [[Ty_Model_MessageInfo alloc]init];
    
    
    messageInfo.messageContent = message;
    messageInfo.messageGuid = [[Guid share] getGuid];
    
    messageInfo.messageContactGuid = _contactGuid;
    messageInfo.messageContactName = _contactName;
    messageInfo.messageContactRealName = _contactRealName;
    messageInfo.messageContactType = _contactType;
    messageInfo.messageContactSex = _contactSex;
    messageInfo.messageIsGroupDelete = 0;
    messageInfo.messageContactPhoto = _contactPhotoUrl.length > 0 ? _contactPhotoUrl :_contactImg;
    messageInfo.messageContactAnnear = _contactAnnear;
  //  NSLog(@"~~~~%@",messageInfo.messageContactJIDName);
    if (_contactJIDName.length == 0 && [_contactJIDName isEqualToString:@""])
    {
        messageInfo.messageContactJIDName = [NSString stringWithFormat:@"%@_family",messageInfo.messageContactName];
    }
    else
    {
        messageInfo.messageContactJIDName = _contactJIDName;
    }
    
   // NSLog(@"%@",MyLoginUserGuid);
    
    messageInfo.messageType = -1;
    messageInfo.messageSenderGuid = MyLoginUserGuid;
    //发消息时，将自己发送的消息置为已读状态
    messageInfo.messageIsRead = 1;
    messageInfo.messageTime = [self getCurrentTime];
    
    [_messageBusine insertMessageIntoTable:messageInfo];
    [_messageView.allMessageArr addObject:messageInfo];
    // [_messageView.allMessageArr insertObject:messageInfo atIndex:0];
    
    [_messageView.tableView reloadData];
    if (_messageView.allMessageArr.count > 0)
    {
        [_messageView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messageView.allMessageArr.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    NSInteger indexRow = [_messageView.allMessageArr indexOfObject:messageInfo];
    MessageCell *cell = (MessageCell *)[_messageView.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexRow inSection:0]];
   // cell.activityIndicatorView.hidden = NO;
  //  NSLog(@"%@",cell);
  //  NSLog(@"%@",cell.activityIndicatorView);
    [cell.activityIndicatorView startAnimating];
 //   NSLog(@"%d",cell.activityIndicatorView.isAnimating);
    
    
    [[XmppManager shareXmppManager] sendMessage:messageInfo];
    messageInfo = nil;
    
    _pageNum ++;
    
}

#pragma mark ---  播放语音
- (void)playVoice:(MessageCell *)cell indexRow:(int)row
{
    Ty_Model_MessageInfo *messageInfo = [_messageView.allMessageArr objectAtIndex:row];

    cell.voiceUnreadImageView.hidden = YES;
    
    if (messageInfo.messageIsVoiceRead == 0)
    {
        messageInfo.messageIsVoiceRead = 1;
        [_messageBusine updateVoiceReadStatusByMessageGuid:messageInfo.messageGuid];
    }
    
    
    
    if (cell.playVoiceBtn.selected)
    {
        
        [cell.playVoiceImageView stopAnimating];
       cell.playVoiceBtn.selected = NO;
        
        [_audioPlayer stop];
        //播放完关闭红外感应
        [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    }
    else
    {
        //播放时，开启红外感用
        [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
        
        cell.playVoiceBtn.selected = YES;
        
        if (nil != _oldMessageInfo)//说明之前有语音正在播放，且并不是现在点击的这一条
        {
            _oldMessageCell.playVoiceBtn.selected = NO;

            [_oldMessageCell.playVoiceImageView stopAnimating];
            [_audioPlayer stop];
            _audioPlayer = nil;
            
            _oldMessageCell = nil;
            _oldMessageInfo = nil;
        }
        
       
        
        _oldMessageInfo = messageInfo;
        _oldMessageCell = cell;
        
      //   NSLog(@"%@",_oldMessageCell);
        
        UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,sizeof(sessionCategory),&sessionCategory);
        
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        //默认情况下扬声器播
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [audioSession setActive:YES error:nil];

        
        
        _audioPlayer = [[AVAudioPlayer alloc]initWithData:[NSData dataWithContentsOfFile:messageInfo.messageContent] error:nil];
        _audioPlayer.delegate = self;
        [_audioPlayer play];
        
        [self playVoiceAnimation:cell isSelf:[messageInfo.messageSenderGuid isEqualToString:MyLoginUserGuid] ? YES : NO];
        
    }
}

- (void)playVoiceAnimation:(MessageCell *)cell isSelf:(BOOL)isSelf
{
   
    
    NSArray *array =  isSelf ? [NSArray arrayWithObjects:
                      //  [UIImage imageNamed:@"kehuCell.png"],
                      [UIImage imageNamed:@"SenderVoiceNodePlaying000_ios7"],
                      [UIImage imageNamed:@"SenderVoiceNodePlaying001_ios7"],
                      [UIImage imageNamed:@"SenderVoiceNodePlaying002_ios7"],
                      [UIImage imageNamed:@"SenderVoiceNodePlaying003_ios7"],
                                nil] : [NSArray arrayWithObjects:[UIImage imageNamed:@"ReceiverVoiceNodePlaying000_ios7"],
                                        [UIImage imageNamed:@"ReceiverVoiceNodePlaying001_ios7"],
                                        [UIImage imageNamed:@"ReceiverVoiceNodePlaying002_ios7"],
                                        [UIImage imageNamed:@"ReceiverVoiceNodePlaying003_ios7"],
                                        nil]  ;
    cell.playVoiceImageView.animationImages = array;
    //切换动作的时间3秒，来控制图像显示的速度有多快，
    cell.playVoiceImageView.animationDuration = 1.2f;
    //动画的重复次数，想让它无限循环就赋成0
    cell.playVoiceImageView.animationRepeatCount = 0;
    [cell.playVoiceImageView setAnimationImages:array];
    [cell.playVoiceImageView startAnimating];

    
/*
    [cell.playVoiceBtn setBackgroundImage:isSelf ? [UIImage imageNamed:@"SenderVoiceNodePlaying000_ios7"] : [UIImage imageNamed:@"ReceiverVoiceNodePlaying000_ios7"] forState:UIControlStateNormal] ;
    [cell.playVoiceBtn setBackgroundImage:isSelf ? [UIImage imageNamed:@"SenderVoiceNodePlaying001_ios7"] : [UIImage imageNamed:@"ReceiverVoiceNodePlaying001_ios7"] forState:UIControlStateNormal] ;
    [cell.playVoiceBtn setBackgroundImage:isSelf ? [UIImage imageNamed:@"SenderVoiceNodePlaying002_ios7"] : [UIImage imageNamed:@"ReceiverVoiceNodePlaying002_ios7"] forState:UIControlStateNormal] ;
    [cell.playVoiceBtn setBackgroundImage:isSelf ? [UIImage imageNamed:@"SenderVoiceNodePlaying003_ios7"] : [UIImage imageNamed:@"ReceiverVoiceNodePlaying003_ios7"] forState:UIControlStateNormal] ;
 */
}
#pragma mark -- audioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //播放完关闭红外感应
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    player = nil;
    [_oldMessageCell.playVoiceImageView stopAnimating];
    _oldMessageCell = nil;
    _oldMessageInfo = nil;
}

- (void)sensorStateChange:(NSNotificationCenter *)notification
{
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗
     if ([[UIDevice currentDevice] proximityState] == YES)
     {
         [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
     }
    else
    {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }

}

#pragma mark --- 再次发送消息
- (void)sendFailMessageAgain:(Ty_Model_MessageInfo *)messageInfo
{
    _failMessageInfo = messageInfo;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"重发该消息？" message:@"" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [alertView show];
    alertView = nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
      //  NSLog(@"不发送~");
        _failMessageInfo = nil;
    }
    else
    {
     //   NSLog(@"发送");
        [[XmppManager shareXmppManager] sendMessage:_failMessageInfo];
        for (Ty_Model_MessageInfo *messageInfo in _messageView.allMessageArr)
        {
            if ([messageInfo.messageGuid isEqualToString:_failMessageInfo.messageGuid])
            {
                messageInfo.messageIsSendSuccess = 1;
                [_messageBusine updateMessageSendStatusSuccessByMessageGuid:messageInfo.messageGuid];
                break;
            }
        }
        
        [_messageView.tableView reloadData];
        
    }
}


#pragma mark --- 下拉时，刷新数据
- (void)getMoreData
{
    
    
    int oldNum = _messageView.allMessageArr.count;
    
    [_messageBusine selectMessageDataFromTableByContactGuid:_contactGuid pageNum:_pageNum];
    _messageView.allMessageArr = _messageBusine.messageArr;
    
    int newNum = _messageView.allMessageArr.count - oldNum;
    
    [_messageView.tableView reloadData];
    
    if (newNum != 0)
    {
        [_messageView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:newNum inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    
    _pageNum += 10 ;
    
   // [];
}

#pragma mark --- 收到消息时，刷新气泡页
- (void)refreshMessageTableView:(NSNotification *)notification
{
    Ty_Model_MessageInfo *messageInfo = [notification object];
    if ([messageInfo.messageContactGuid isEqualToString:_contactGuid] )
    {
        messageInfo.messageContactPhoto = _contactPhotoUrl;
        [_messageBusine.messageArr addObject:messageInfo];
       // [_messageBusine.messageArr insertObject:messageInfo atIndex:0];
        _messageView.allMessageArr = _messageBusine.messageArr;
        [_messageView.tableView reloadData];
        if (_messageView.allMessageArr.count > 0)
        {
            [_messageView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messageView.allMessageArr.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }
    
    _pageNum ++;
    
}

#pragma mark ----- 发送消息失败时，刷新列表
- (void)refreshMessageTableViewWhenSendFail:(NSNotification *)notification
{
    //[_messageBusine selectMessageDataFromTableByContactGuid:_contactGuid pageNum:1];
    Ty_Model_MessageInfo *failMessageInfo = [notification object];
    
    NSInteger indexRow = [_messageView.allMessageArr indexOfObject:failMessageInfo];
    MessageCell *cell = (MessageCell *)[_messageView.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexRow inSection:0]];
    //failMessageInfo.messageIsSendSuccess = 0;
    [cell.activityIndicatorView stopAnimating];
    
    
    for (Ty_Model_MessageInfo *messageInfo in _messageView.allMessageArr)
    {
        if ([failMessageInfo.messageGuid isEqualToString:messageInfo.messageGuid])
        {
          //  NSLog(@"我是");
            messageInfo.messageIsSendSuccess = 0;
            break;
        }
       // NSLog(@"~~~~~~~~~~~~~~");
        
        
    }
    
    
    [_messageView.tableView reloadData];
    
}

- (void)refreshMessageTableViewWhenSendSuccess:(NSNotification *)notification
{
    Ty_Model_MessageInfo *failMessageInfo = [notification object];
    NSInteger indexRow = [_messageView.allMessageArr indexOfObject:failMessageInfo];
    MessageCell *cell = (MessageCell *)[_messageView.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexRow inSection:0]];
    //failMessageInfo.messageIsSendSuccess = 0;
    [cell.activityIndicatorView stopAnimating];
}

- (void)sendVoiceMessageFailed
{
    [_messageView.tableView reloadData];
}


#pragma mark ---- 获取头像地址
- (void)updateContactPhoto:(NSNotification *)notification
{
   NSMutableDictionary *dic = [notification object];
    if ([[dic objectForKey:@"userGuid"] isEqualToString:_contactGuid])
    {
        _contactPhotoUrl = [dic objectForKey:@"userPhoto"];
        if (_contactPhotoUrl.length > PhotoUrl.length)
        {
            _contactPhotoUrl = [_contactPhotoUrl substringFromIndex:PhotoUrl.length];
        }
        _messageView.contactPhoto = _contactPhotoUrl;
        [_messageView.tableView reloadData];
    }
 //   NSLog(@"%@",_contactPhotoUrl);
}

#pragma mark --- 辅助信息-获取时间
- (NSString *)getCurrentTime
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *current = [dateFormatter stringFromDate:currentDate];
    dateFormatter = nil;
    return current;
}

#pragma mark --- 长按事件协议
- (void)LongPressGestureMethod:(CGPoint)point
{
    _pasteboardStr = nil;
    
    NSIndexPath * indexPath = [_messageView.tableView indexPathForRowAtPoint:point];
    
    Ty_Model_MessageInfo *messageInfo = [_messageView.allMessageArr objectAtIndex:indexPath.row];
    
    MessageCell *cell = (MessageCell *)[_messageView.tableView cellForRowAtIndexPath:indexPath];
    
    [cell becomeFirstResponder];
    
    [cell setHighlighted:YES animated:YES];
    
    _pasteboardStr = messageInfo.messageContent;
    
    if (messageInfo.messageType == -1)
    {
        UIMenuItem *itCopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(handleCopyCell:)];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:[NSArray arrayWithObjects:itCopy,   nil]];
        [menu setTargetRect:CGRectMake([messageInfo.messageSenderGuid isEqualToString:MyLoginUserGuid] ? 170 : 50, 40, 100, 50) inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
    
    
    
}
//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    return YES;
//}
- (void)handleCopyCell:(id)sender
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    [pasteBoard setString:_pasteboardStr];
    _pasteboardStr = nil;

}

#pragma mark --- 创建一条小Q数据
- (void)createQData
{
    Ty_Model_MessageInfo *messageInfo = [[Ty_Model_MessageInfo alloc]init];
    
    messageInfo.messageGuid = [[Guid share]getGuid];
    messageInfo.messageContent = @"欢迎使用腾云家务。\n我是腾云小Q，您的家务助手！\n如果您在使用中有任何问题或建议，记得发消息告诉我，小Q随时准备回答您的问题哦！";
    messageInfo.messageContactGuid = Message_Q_Guid;
    messageInfo.messageContactJIDName = Message_Q_JID;
    messageInfo.messageContactName = @"腾云小Q";
    messageInfo.messageContactRealName = @"腾云小Q";
    messageInfo.messageContactSex = 1;
    messageInfo.messageContactType = 1;
    messageInfo.messageIsDelete = 0;
    messageInfo.messageIsDownloadSuccess = 1;
    messageInfo.messageIsRead = 1;
    messageInfo.messageIsSendSuccess = 1;
    messageInfo.messageTime = [self getCurrentTime];
    messageInfo.messageType = -1;
    messageInfo.messageSenderGuid = Message_Q_Guid;
    
    [_messageBusine.messageArr insertObject:messageInfo atIndex:_messageBusine.messageArr.count];
    messageInfo = nil;
}


- (void)viewWillbackAction
{
    [super viewWillbackAction];
    [_messageBusine updateMessageReadStatusByContactGuid:_contactGuid];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMessageList" object:nil];
}
#pragma mark -- popToRootController
- (void)popToPreviousController
{
  //  NSLog(@"%@",self.naviGationController);
    //离开页面时，将与该联系人有关的信息置为已读状态
    [_messageBusine updateMessageReadStatusByContactGuid:_contactGuid];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMessageList" object:nil];
    
    [self.naviGationController popViewControllerAnimated:YES];
}


#pragma mark --- view lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSLog(@"%@",_contactRealName);
    self.view.backgroundColor = [UIColor grayColor];
    
    NSString *titleStr = _contactRealName.length > 0 ? _contactRealName : @"腾云用户";
    titleStr = _contactAnnear.length > 0 ? [titleStr stringByAppendingFormat:@"(%@)",_contactAnnear] : titleStr;
    self.title = titleStr;
    
    _messageView = [[MessageView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height )];
    _messageView.messageDelegate = self;
    [self.view addSubview:_messageView];
    
    [self.view bringSubviewToFront:self.naviGationController];
    
    self.naviGationController.userInteractionEnabled = YES;
    [self.naviGationController.leftBarButton setImage:[UIImage imageNamed:@"Message_back"] forState:UIControlStateNormal];
    [self.naviGationController.leftBarButton addTarget:self action:@selector(popToPreviousController) forControlEvents:UIControlEventTouchUpInside];
    self.naviGationController.leftBarButton.showsTouchWhenHighlighted = YES;
    
    
    _messageBusine = [[Ty_Message_Busine alloc]init];
    
    [_messageBusine selectMessageDataFromTableByContactGuid:_contactGuid pageNum:_pageNum];
    _messageView.allMessageArr = _messageBusine.messageArr;
    
    
    //创建一条小Q数据，用于每次进入小Q页面都显示小Q提示
    if ([_contactGuid isEqualToString:Message_Q_Guid] && _messageBusine.messageArr.count > 1)
    {
        [self createQData];
    }
    
    
    [_messageView.tableView reloadData];
    
    if (_messageView.allMessageArr.count > 0)
    {
        [_messageView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messageView.allMessageArr.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    _pageNum += 10;
    

    Ty_MessageList_Busine *messageListBusine = [[Ty_MessageList_Busine alloc]init];
    [messageListBusine getMsgContactInfoFromNetWithContactGuid:_contactGuid];
    messageListBusine = nil;

    
    
    // 创建录音存放的路径
    [[NSFileManager defaultManager] createDirectoryAtPath:VoicePath withIntermediateDirectories:YES attributes:nil error:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addKeyboardNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMessageTableView:) name:@"GetMessage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMessageTableViewWhenSendFail:) name:@"GetMessage_SendMsgFail" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMessageTableViewWhenSendSuccess:) name:@"GetMessage_SendMsgSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateContactPhoto:) name:@"Msg_UpdatePhoto" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendVoiceMessageFailed) name:@"SendVoiceFail" object:nil];
    
    //添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sensorStateChange:)name:@"UIDeviceProximityStateDidChangeNotification" object:nil];

    self.imageView_background.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.imageView_background.hidden = NO;
    
    if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[AppDelegateViewController class]])
    {
        AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
        if (![appDelegateVC isKindOfClass:[Ty_NewsVC class]])
        {
            Ty_MessageList_Busine *messageListBusine = [[Ty_MessageList_Busine alloc]init];
            AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
            [appDelegateVC setTabBarIcon:[messageListBusine getAllUnreadMessageNum] atIndex:1];
            messageListBusine = nil;
        }
        
        
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
