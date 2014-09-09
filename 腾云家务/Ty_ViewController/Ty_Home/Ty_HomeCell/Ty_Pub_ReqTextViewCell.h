//
//  Ty_Pub_ReqTextViewCell.h
//  腾云家务
//
//  Created by 齐 浩 on 14-7-25.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ty_Pub_ReqTextViewCell : UITableViewCell<UITextViewDelegate>

@property(nonatomic,strong) UIImageView * leftImageView;
@property(nonatomic,strong) UILabel * leftLabel;
@property(nonatomic,strong) UITextView * detailTextView;
@property(nonatomic,strong) UIView * lineView;
@property(nonatomic,strong) UILabel * helpLabel;

-(void)setHeight;
@end
