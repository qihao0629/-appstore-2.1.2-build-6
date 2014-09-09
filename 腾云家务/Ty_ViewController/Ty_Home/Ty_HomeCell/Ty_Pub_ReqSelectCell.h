//
//  ReserveTextLeftCustomCell.h
//  腾云家务
//
//  Created by lgs on 14-1-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ty_Pub_ReqSelectCell : UITableViewCell
{
    
}
@property(nonatomic,strong) UIImageView * leftImageView;
@property(nonatomic,strong) UILabel * leftLabel;
@property(nonatomic,strong) UILabel * detailLabel;
@property(nonatomic,strong) UIView * lineView;
-(void)setHigh;
@end
