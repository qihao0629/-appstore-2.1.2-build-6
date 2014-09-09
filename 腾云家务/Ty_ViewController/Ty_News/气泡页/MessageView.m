//
//  MessageView.m
//  MessageMVC
//
//  Created by liu on 14-5-27.
//  Copyright (c) 2014年 刘美超. All rights reserved.
//

#import "MessageView.h"
#import "MessageVC.h"
#import "MessageCell.h"
#import "Ty_Model_MessageInfo.h"

@implementation MessageView

@synthesize tableView = _tableView;
@synthesize inputBgView = _inputBgView;
@synthesize textBgImageView = _textBgImageView;
@synthesize messageTextView = _messageTextView;
@synthesize voiceBtn = _voiceBtn;
@synthesize recordBtn = _recordBtn;
@synthesize messageDelegate = _messageDelegate;
@synthesize hideView = _hideView;

@synthesize allMessageArr = _allMessageArr;
@synthesize contactPhoto = _contactPhoto;
@synthesize keyBoardHeight = _keyBoardHeight;
@synthesize allCellHeight = _allCellHeight;

@synthesize recordStatusImageView = _recordStatusImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
       // NSLog(@"%f",frame.size.height);
    
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, frame.size.height - 44 - 20 - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.backgroundView = nil;
        _tableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_tableView];
       
       
        
        _inputBgView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 44 - 44 - 20, 320, 216 + 44)];
        _inputBgView.backgroundColor = [UIColor whiteColor];
        _inputBgView.clipsToBounds = YES;
        [self addSubview:_inputBgView];
        //_inputBgView = nil;
        
        
        _textBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        _textBgImageView.image = [UIImage imageNamed:@"Message_ToolViewBkg_Black_ios7"];
        _textBgImageView.userInteractionEnabled = YES;
        [_inputBgView addSubview:_textBgImageView];
        
        
        _messageTextView = [[UITextView alloc]initWithFrame:CGRectMake(50, 7, 250, 30)];
        _messageTextView.backgroundColor = [UIColor whiteColor];
        _messageTextView.layer.borderColor = [UIColor colorWithRed:212.0/255 green:212.0/255 blue:212.0/255 alpha:1.0].CGColor;
        _messageTextView.layer.cornerRadius = 4.0;
        _messageTextView.layer.borderWidth = 0.6;
        _messageTextView.delegate = self;
        _messageTextView.font = [UIFont systemFontOfSize:14];
        _messageTextView.returnKeyType = UIReturnKeySend;
        _messageTextView.enablesReturnKeyAutomatically = YES;
        
        
        [_inputBgView addSubview:_messageTextView];
       
        
        
        _voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _voiceBtn.frame = CGRectMake(8, 5, 34, 34);
        [_voiceBtn setBackgroundImage:[UIImage imageNamed:@"Message_ToolViewInputVoice_ios7"] forState:UIControlStateNormal];
        [_voiceBtn setBackgroundImage:[UIImage imageNamed:@"Message_ToolViewInputText_ios7"] forState:UIControlStateSelected];
        _voiceBtn.selected = NO;
        [_voiceBtn addTarget:self action:@selector(voiceBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_inputBgView addSubview:_voiceBtn];
     
        
        _recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordBtn.frame = CGRectMake(50, 5, 250, 34);
        [_recordBtn setBackgroundImage:[UIImage imageNamed:@"Message_Voice_Normal"] forState:UIControlStateNormal];
        
        _recordBtn.selected = NO;
        [_inputBgView addSubview:_recordBtn];
        _recordBtn.hidden = YES;
        
        //录音按钮触发的事件
        [_recordBtn addTarget:self action:@selector(startRecord) forControlEvents:UIControlEventTouchDown];
        [_recordBtn addTarget:self action:@selector(recordOver) forControlEvents:UIControlEventTouchUpInside];
        [_recordBtn addTarget:self action:@selector(breakRecord_DragOut) forControlEvents:UIControlEventTouchDragOutside];
        [_recordBtn addTarget:self action:@selector(continueRecord_DragInside) forControlEvents:UIControlEventTouchDragInside];
        [_recordBtn addTarget:self action:@selector(cancleRecord) forControlEvents:UIControlEventTouchUpOutside];
        
        
        
        _hideView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 44)];
        _hideView.backgroundColor = [UIColor clearColor];
        _hideView.hidden = YES;
        [self addSubview:_hideView];
        [self bringSubviewToFront:_inputBgView];
        
        _keyBoardHeight = 0;
        
        
        _recordHideView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 44)];
        _recordHideView.backgroundColor = [UIColor clearColor];
        _recordHideView.hidden = YES;
        _recordHideView.userInteractionEnabled = YES;
        [self addSubview:_recordHideView];
        [self bringSubviewToFront:_inputBgView];
        
        _recordStatusImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 160)/2, 105, 160, 160)];
        _recordStatusImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_recordStatusImageView];
        _recordStatusImageView.hidden = YES;
        
        
        
        
        
    }
    return self;
}

- (void)dealloc
{
    self.tableView = nil;
    self.inputBgView = nil;
    self.textBgImageView = nil;
    self.messageTextView = nil;
    self.hideView = nil;
    self.allMessageArr = nil;
}
#pragma mark -- tableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allMessageArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    MessageCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.delegate = _messageDelegate;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selected = NO;
    
    [cell.playVoiceBtn addTarget:self action:@selector(playVoice:) forControlEvents:UIControlEventTouchUpInside];
    [cell.sendFailBtn addTarget:self action:@selector(sendMessageAgain:) forControlEvents:UIControlEventTouchUpInside];
    Ty_Model_MessageInfo *messageInfo = [_allMessageArr objectAtIndex:indexPath.row];
    
    /*
    if (![messageInfo.messageSenderGuid isEqualToString:MyLoginUserGuid] && [messageInfo.messageContactPhoto isEqualToString:@""])
    {
        messageInfo.messageContactPhoto = _contactPhoto;
        
    }
    NSLog(@"%@",messageInfo.messageContactPhoto);
    */
    [cell setCellContent:messageInfo];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

#pragma mark scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offsetPoint = _tableView.contentOffset;
    if (offsetPoint.y == 0 || offsetPoint.y < 0)
    {
        [_messageDelegate getMoreData];
    }
}
#pragma mark ---- textView delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [_messageTextView becomeFirstResponder];
}
- (void)textViewDidChange:(UITextView *)textView
{
   
    CGSize size = [textView.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(1000, 20) lineBreakMode:NSLineBreakByWordWrapping];
   // NSLog(@"%f",size.height);

    int lineNum = size.width  / 238 + 1 ;
    
  
    if (lineNum != 1)
    {
        _messageTextView.frame = CGRectMake(50, 7, 250, 30 + 17 * (lineNum - 1 ));
        _textBgImageView.frame = CGRectMake(0, 0, 320, 44 + 17 * (lineNum - 1 ) );
        _inputBgView.frame = CGRectMake(0, self.frame.size.height - _keyBoardHeight - 44 -  44-  20 - 17 * (lineNum - 1 ) , 320, _keyBoardHeight + 44 + 17 * (lineNum - 1 ));
 
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            if (_allCellHeight > _inputBgView.frame.origin.y  && _allCellHeight < _tableView.frame.size.height  )
            {
                _tableView.transform = CGAffineTransformMakeTranslation(0,  - (_allCellHeight - _inputBgView.frame.origin.y) - 17 * (lineNum - 1));
                
            }
            else if (  _allCellHeight > _tableView.frame.size.height )
            {
                _tableView.transform = CGAffineTransformMakeTranslation(0, -_keyBoardHeight - 17 * (lineNum - 1));
            }
            
        }completion:^(BOOL finished)
         {
             
             
         }];
        
    }
    else
    {
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            if (_allCellHeight > _inputBgView.frame.origin.y && _allCellHeight < _tableView.frame.size.height )
            {
                _tableView.transform = CGAffineTransformMakeTranslation(0, - (_allCellHeight - _inputBgView.frame.origin.y));
                
                
            }
            else if (_allCellHeight > _tableView.frame.size.height)
            {
                _tableView.transform = CGAffineTransformMakeTranslation(0, -_keyBoardHeight);
            }
            
            
        }completion:^(BOOL finished)
         {
             if (_allCellHeight > _inputBgView.frame.origin.y )
             {
                 _messageTextView.frame = CGRectMake(50, 7, 250, 30);
                 _textBgImageView.frame = CGRectMake(0, 0, 320, 44);
                 if ([_messageTextView isFirstResponder])
                 {
                     _inputBgView.frame = CGRectMake(0, self.frame.size.height - _keyBoardHeight -44 - 44 - 20, 320, 216 + 44);
                 }
                 
             }
             
         }];
        
        
      //  _tableView.frame = CGRectMake(0, 0, 320, self.frame.size.height  - _keyBoardHeight - 44 - 20 - 44);
        
        
    }
    
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        if (textView.text.length > 0)
        {
            CGFloat textHeight = 0;
            
            CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.frame.size.width - 150, 500) lineBreakMode:NSLineBreakByCharWrapping];
            if (size.height < 40)
            {
                
                textHeight = size.height + 70;
                
            }
            else
            {
                textHeight = size.height + 55;
            }
            
            _allCellHeight += textHeight;
            
            //此处加入send触发事件
            [_messageDelegate sendMessage:textView.text];
            
            _messageTextView.text = @"";
            
            
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                if (_allCellHeight > _inputBgView.frame.origin.y && _allCellHeight < _tableView.frame.size.height   /*_allMessageArr.count > 3*/ )
                {
                    _tableView.transform = CGAffineTransformMakeTranslation(0, - (_allCellHeight - _inputBgView.frame.origin.y));
                    
                    
                }
                else if ( _allCellHeight > _tableView.frame.size.height  )
                {
                    _tableView.transform = CGAffineTransformMakeTranslation(0, -_keyBoardHeight );
                    
                }
                
                
            }completion:^(BOOL finished)
             {
                 if (_allCellHeight > _inputBgView.frame.origin.y )
                 {
                     _messageTextView.frame = CGRectMake(50, 7, 250, 30);
                     _textBgImageView.frame = CGRectMake(0, 0, 320, 44);
                     _inputBgView.frame = CGRectMake(0, self.frame.size.height - _keyBoardHeight -44 - 44 - 20, 320, 216 + 44);
                 }
             }];
        }

        
        return NO;
    }
    return YES;
}

#pragma mark --- voiceBtnMethod
- (void)voiceBtnPressed:(id)sender
{
    if (_voiceBtn.selected)
    {
        _voiceBtn.selected = NO;
        _recordBtn.hidden = YES;
        _messageTextView.hidden = NO;
    }
    else
    {
        _voiceBtn.selected = YES;
        _recordBtn.hidden = NO;
        _messageTextView.hidden = YES;
    }
    
    [_messageDelegate changeMessageStatus];
}

#pragma mark ----  录音按钮触发的所有事件
/**
 *  录音开始
 */
- (void)startRecord
{
    _recordBtn.selected = YES;
    [_recordBtn setBackgroundImage:[UIImage imageNamed:@"Message_Voice_Select"] forState:UIControlStateNormal];
    
    //通知controller开始录音
    [_messageDelegate startRecord];
    
    _recordHideView.hidden = NO;
    _recordStatusImageView.hidden = NO;
    //[self addSubview:_recordStatusImageView];
    
}
/**
 *  录音结束
 */
- (void)recordOver
{
    [_recordBtn setBackgroundImage:[UIImage imageNamed:@"Message_Voice_Normal"] forState:UIControlStateNormal ];
    _recordBtn.selected = NO;
    _recordHideView.hidden = YES;
    
    
    //通知controller结束录音并发送
    [_messageDelegate recordEnd];

}

- (void)breakRecord_DragOut
{
    //NSLog(@"松手取消");
    //recordStatusImageView图片改变
    [_messageDelegate prepareCancelRecord];
    _recordStatusImageView.image = [UIImage imageNamed:@"Message_Cancle"];
    
}
- (void)continueRecord_DragInside
{
  //  NSLog(@"继续");
    //recordStatusImageView图片改变
    [_messageDelegate continueRecord];
    _recordStatusImageView.image = [UIImage imageNamed:@"Message_barRVD_1"];
    
}
- (void)cancleRecord
{
  //  NSLog(@"取消");
    _recordHideView.hidden = YES;
    _recordStatusImageView.hidden = YES;
  //  [_recordStatusImageView removeFromSuperview];
    [_recordBtn setBackgroundImage:[UIImage imageNamed:@"Message_Voice_Normal"] forState:UIControlStateNormal ];
    _recordBtn.selected = NO;
}

#pragma mark --录音时间太短，更改图片
- (void)updateRecordImageView
{
    _recordStatusImageView.image = [UIImage imageNamed:@"Message_voiceTime_"];
}
#pragma mark --- 录音动画
- (void)recordAnimation:(float)voiceVolume
{
    if (voiceVolume < 0.14)
    {
        _recordStatusImageView.image = [UIImage imageNamed:@"Message_barRVD_1"];
    }
    else if (voiceVolume >= 0.14 && voiceVolume < 0.28)
    {
        _recordStatusImageView.image = [UIImage imageNamed:@"Message_barRVD_2"];
    }
    else if (voiceVolume >= 0.28 && voiceVolume < 0.42)
    {
        _recordStatusImageView.image = [UIImage imageNamed:@"Message_barRVD_3"];
    }
    else if (voiceVolume >= 0.42 && voiceVolume < 0.56)
    {
        _recordStatusImageView.image = [UIImage imageNamed:@"Message_barRVD_4"];
    }
    else if (voiceVolume >= 0.56 && voiceVolume < 0.70)
    {
        _recordStatusImageView.image = [UIImage imageNamed:@"Message_barRVD_5"];
    }
    else if (voiceVolume >= 0.70 && voiceVolume < 0.84)
    {
        _recordStatusImageView.image = [UIImage imageNamed:@"Message_barRVD_6"];
    }
    else
    {
        _recordStatusImageView.image = [UIImage imageNamed:@"Message_barRVD_7"];
    }
}

#pragma mark -- 播放语音
- (void)playVoice:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
//    NSLog(@"%@",button.superview.superview.superview);
//    NSLog(@"%@",button.superview.superview);
//    NSLog(@"%@",button.superview);
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    MessageCell *cell ;
    if (version >= 7.0 && version < 8.0)
    {
        cell = (MessageCell *)button.superview.superview.superview;
    }
    else
    {
        cell = (MessageCell *)button.superview.superview;
    }
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
  //  NSLog(@"%d",indexPath.row);
    
    [_messageDelegate playVoice:cell indexRow:indexPath.row];
}

#pragma mark ---- 再次发送消息
- (void)sendMessageAgain:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    MessageCell *cell ;
    if (IOS7)
    {
        cell = (MessageCell *)button.superview.superview.superview;
    }
    else
    {
        cell = (MessageCell *)button.superview.superview;
    }
    
   // NSLog(@"%@",cell);
    NSIndexPath *indexpath = [_tableView indexPathForCell:cell];
    Ty_Model_MessageInfo *messageInfo = [_allMessageArr objectAtIndex:indexpath.row];
    [_messageDelegate sendFailMessageAgain:messageInfo];
    
}


#pragma mark -- 刷新

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
