//
//  HomeButton.h
//  腾云家务
//
//  Created by 齐 浩 on 13-9-23.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"
@interface Home_Button : UIButton

@property(nonatomic,strong)UIImageView* workTypeImage;
@property(nonatomic,strong)UILabel* workTypeLabel;
@property(nonatomic,strong)CustomLabel* ShopLabel;
@property(nonatomic,strong)CustomLabel* PartTimeLabel;
@property(nonatomic,strong)UIImageView* prayImage;
@property(nonatomic,strong)UIImageView* jiantouImage;
@property(nonatomic,strong)NSString* guid;
@property(nonatomic,strong)NSString* countString;
@property(nonatomic,assign)BOOL change;
@end
