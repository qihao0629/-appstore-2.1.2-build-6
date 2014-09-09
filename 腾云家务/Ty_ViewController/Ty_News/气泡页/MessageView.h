//
//  MessageView.h
//  MessageMVC
//
//  Created by liu on 14-5-27.
//  Copyright (c) 2014年 刘美超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageVC;

@interface MessageView : UIView<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
   
    UIView *_recordHideView;
    
}

@property (nonatomic,strong) NSMutableArray *allMessageArr;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIView *inputBgView;

@property (nonatomic,strong) UIImageView *textBgImageView;

@property (nonatomic,strong) UITextView *messageTextView;

@property (nonatomic,strong) UIButton *voiceBtn;

@property (nonatomic,strong) UIButton *recordBtn;

@property (nonatomic,assign) MessageVC *messageDelegate;

@property (nonatomic,strong) UIView *hideView;

@property (nonatomic,assign) CGFloat keyBoardHeight;

@property (nonatomic,strong) NSString *contactPhoto;

@property (nonatomic,assign) CGFloat allCellHeight;

@property (nonatomic,strong) UIImageView *recordStatusImageView;

/**
 *  根据音量，来调整录音峰值
 *
 *  @param voiceVolume 音量值
 */
- (void)recordAnimation:(float)voiceVolume;


/**
 *  录音结束，若时间太短，更新背景图片
 */
- (void)updateRecordImageView;

@end
