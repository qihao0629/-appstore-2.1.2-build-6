//
//  RefreshView.h
//  腾云家务
//
//  Created by 齐 浩 on 13-10-14.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefreshView : UIView

@property (nonatomic,retain) UIActivityIndicatorView *_netMind;

@property (nonatomic,retain) UILabel *_messageLabel;

- (void)statAnimation;
- (void)stopAnimation;


@end
