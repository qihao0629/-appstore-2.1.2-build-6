//
//  Ty_OrderVC_YZFinish_Controller.h
//  腾云家务
//
//  Created by lgs on 14-7-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "Ty_Model_XuQiuInfo.h"

@interface Ty_OrderVC_YZFinish_Controller : TYBaseView

@property(nonatomic,strong)UILabel* finishLabel;
@property(nonatomic,strong)UIImageView* finishImage;
@property(nonatomic,strong)UILabel* contentsLabel;
@property(nonatomic,strong)UIButton* AciontButton;
@property(nonatomic,strong)NSString* requirementGuid;
@property(nonatomic,strong)Ty_Model_XuQiuInfo * xuQiu;

@end
