//
//  MasterLookYZPeopleCell.h
//  腾云家务
//
//  Created by lgs on 14-6-20.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_Model_ServiceObject.h"

@protocol MasterDeterminePersonButton <NSObject>
@optional
-(void)masterDeterminePersonButtonPressed:(id)sender;
@end

@interface MasterLookYZPeopleCell : UITableViewCell
@property (nonatomic,assign) id<MasterDeterminePersonButton>masterDeterminePersonButton;
@property(nonatomic,strong) UIView * leftHeadView;
@property(nonatomic,strong) UIImageView * headImageView;
@property(nonatomic,strong) UILabel * workerNameLabel;
@property(nonatomic,strong) UILabel * workerTypeLabel;//私人接活或者中介接单
@property(nonatomic,strong) UIView * greenView;//绿色的背景
@property(nonatomic,strong) UILabel * YZtimeLabel;
@property(nonatomic,strong) UILabel * priceLabel;
@property(nonatomic,strong) UILabel * unitLabel;
@property(nonatomic,strong) UIButton * privateLetterButton;
@property(nonatomic,strong) UILabel * serviceTimeLabel;//服务次数
@property(nonatomic,strong) UIButton * determineButton;
@property(nonatomic,strong) UILabel * buttonTitleLabel;
@property(nonatomic,strong) UIImageView * redIcon;
@property(nonatomic,strong) UILabel * newsLabel;
@property(nonatomic,strong) Ty_Model_ServiceObject * serviceObject;
@property(nonatomic,strong) UILabel * remarkLabel;

-(void)loadCustom;//加载界面
-(void)loadValues;//加载数据
-(void)setHight;//调整
-(void)privateButtonPressed:(id)sender;//私信按钮点击
-(void)masterDetermineButtonPressed:(id)sender;//确定人的按钮点击

@end
