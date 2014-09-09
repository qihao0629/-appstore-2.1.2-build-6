//
//  Reserve_FinishViewController.h
//  腾云家务
//
//  Created by 齐 浩 on 14-4-10.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
//
//#import "MasterDirectlyViewController.h"
//#import "MasterStartRequirementViewController.h"

#import "Ty_Model_XuQiuInfo.h"
@interface Ty_pub_ReqFinishViewController : TYBaseView
@property(nonatomic,strong)UILabel* finishLabel;
@property(nonatomic,strong)UIImageView* finishImage;
@property(nonatomic,strong)UILabel* contentsLabel;
@property(nonatomic,strong)UIButton* AciontButton;
@property(nonatomic,strong)UIButton* backButton;
@property(nonatomic,strong)Ty_Model_XuQiuInfo* xuqiuInfo;
@end
