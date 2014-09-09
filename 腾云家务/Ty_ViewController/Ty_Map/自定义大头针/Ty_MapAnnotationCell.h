//
//  Ty_MapAnnotationCell.h
//  腾云家务
//
//  Created by AF on 14-7-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"
#import "CustomStar.h"
@interface Ty_MapAnnotationCell : UITableViewCell
/**用户头像*/
@property(nonatomic,strong)UIImageView *imagePhotoView;
/**商户名字*/
@property(nonatomic,strong)UILabel *labTitle;
/**商户阿姨*/
@property(nonatomic,strong)CustomLabel *labContent;
/**点击触发button*/
@property(nonatomic,strong) UIButton * butClickCell;
/**评价等级*/
@property(nonatomic,strong)CustomStar* customStar;

@end
