//
//  MessageCell.h
//  Message
//
//  Created by liu on 14-5-29.
//  Copyright (c) 2014年 刘美超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LongPressGestureDelegate.h"

@class Ty_Model_MessageInfo;

@interface MessageCell : UITableViewCell<UIGestureRecognizerDelegate>
{
    BOOL _isSelf;
}

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UIImageView *contentBgImageView;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *sendFailImgView;
@property (nonatomic,strong) UIButton *sendFailBtn;

@property (nonatomic,strong) UIButton *playVoiceBtn; //播放按钮
@property (nonatomic,strong) UILabel *voiceTimeLabel;
@property (nonatomic,strong) UIImageView *voiceUnreadImageView;
@property (nonatomic,strong) UIImageView *playVoiceImageView;//播放按钮上的imageView



@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;


@property (nonatomic,assign) id<LongPressGestureDelegate>delegate;


/**
 *  设置cell里的内容及frame大小
 *
 *  @param messageInfo  信息详细信息
 */
- (void)setCellContent:(Ty_Model_MessageInfo *)messageInfo;

@end
