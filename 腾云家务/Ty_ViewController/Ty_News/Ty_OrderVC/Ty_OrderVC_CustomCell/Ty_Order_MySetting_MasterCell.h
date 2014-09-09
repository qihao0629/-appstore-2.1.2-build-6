//
//  Ty_Order_MySetting_MasterCell.h
//  腾云家务
//
//  Created by lgs on 14-6-18.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_Model_XuQiuInfo.h"

@interface Ty_Order_MySetting_MasterCell : UITableViewCell
{
    UIView * upGrayLine;
}
@property(nonatomic,strong)UIImageView * masterBigImageView;
@property(nonatomic,strong)UIImageView * masterSmallImageView;
@property(nonatomic,strong)UILabel * masterSmallImageLabel;
@property(nonatomic,strong)UILabel * workNameLabel;
@property(nonatomic,strong)UILabel * servieceTimeLabel;
@property(nonatomic,strong)UILabel * orderStageLabel;
@property(nonatomic,retain)NSString * orderStageString;
//@property(nonatomic,strong)UILabel * receivedTimeLabel;
@property(nonatomic,strong)UILabel * workerNameLabel;

-(void)setHight;

@end
