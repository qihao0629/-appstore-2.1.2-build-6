//
//  My_ShopInformationModel.h
//  腾云家务
//
//  Created by AF on 14-8-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//商户信息Model
#import <Foundation/Foundation.h>

@interface My_ShopInformationModel : NSObject

/**商户头像*/
//@property (nonatomic,strong) UIImage * 

/**商户名称*/
@property (nonatomic,strong) NSString * detailIntermediaryName;

/**负责人*/
@property (nonatomic,strong) NSString * detailIntermediaryResponsiblePerson;

/**开店时间*/
@property (nonatomic,strong) NSString * detailIntermediaryRegisterTime;

/**营业时间*/
@property (nonatomic,strong) NSString * detailIntermediaryBusinessTime;

/**店铺区域*/
@property (nonatomic,strong) NSString * detailIntermediaryArea;

/**营业地址*/
@property (nonatomic,strong) NSString * detailIntermediaryAddress;

/**服务热线*/
@property (nonatomic,strong) NSString * detailIntermediaryPhone;

/**商户经度*/
@property (nonatomic,strong) NSString * userCoordinateLng;

/**商户维度*/
@property (nonatomic,strong) NSString * userCoordinateLat;

/**店铺介绍*/
@property (nonatomic,strong) NSString * detailIntermediaryOtherInfo;

/**营业执照大图*/
@property (nonatomic,strong) UIImage * intermediaryElectronic;

/**营业执照小图*/
@property (nonatomic,strong) UIImage * smallIntermediaryElectronic;


@end
