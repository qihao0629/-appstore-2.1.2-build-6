//
//  Ty_Order_MySetting_WorkerCell.h
//  腾云家务
//
//  Created by lgs on 14-6-18.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ty_Order_MySetting_WorkerCell : UITableViewCell
{
    UIView * upGrayLine;
}
@property (nonatomic,strong) UIImageView * workerBigImageView;
@property (nonatomic,strong) UIImageView * workerSmallImageView;
@property (nonatomic,strong) UILabel * workerSmallImageLabel;
@property (nonatomic,strong) UILabel * workNameLabel;
@property (nonatomic,strong) UILabel * orderStageLabel;
@property (nonatomic,retain) NSString * orderStageString;
@property (nonatomic,strong) UILabel * servieceTimeLabel;
@property (nonatomic,strong) UILabel * servieceAreaLabel;

-(void)setHight;

@end
