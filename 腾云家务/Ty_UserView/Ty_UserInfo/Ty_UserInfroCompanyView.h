//
//  Ty_UserInfroCompanyView.h
//  腾云家务
//
//  Created by 齐 浩 on 14-2-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomStar.h"
#import "Ty_UserInfoButton.h"
@class Ty_UserInfroCompanyView;
@protocol Ty_UserInfroCompanyDelegate <NSObject>
@required
-(void)Ty_UserInfroCompanyView:(Ty_UserInfroCompanyView*)_userInfo;

@end
@interface Ty_UserInfroCompanyView : UIView
{
    BOOL _bool;
    BOOL _addBool;
}
@property(nonatomic,strong)UIImageView* HeadImage;
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UILabel* typeLabel;
@property(nonatomic,strong)CustomStar* customStar;
@property(nonatomic,strong)UILabel* intermediaryBusinessTime;
@property(nonatomic,strong)UILabel* introductionLabel;
@property(nonatomic,strong)UILabel* introductionString;
@property(nonatomic,strong)UIButton* xiangxiButton;
@property(nonatomic,strong)UILabel * sumNumberLabel;
@property(nonatomic,strong)Ty_UserInfoButton* addressButton;
@property(nonatomic,strong)Ty_UserInfoButton* telButton;
@property(nonatomic,assign)id<Ty_UserInfroCompanyDelegate>delegate;
@property(nonatomic,assign)BOOL _addBool;
@property(nonatomic,strong)UILabel* fuwuquyuLabel;//所在区域
@property(nonatomic,strong)UILabel* kaishiyeTimeLabel;//开业时间
@property(nonatomic,strong)UILabel* fuzerenLabel;//负责人


-(void)setLoadView;
@end
