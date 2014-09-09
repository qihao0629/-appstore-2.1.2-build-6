//
//  ServiceObject.h
//  腾云家务
//
//  Created by 齐 浩 on 13-10-9.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ty_Model_ServiceObject : NSObject
{
    Ty_Model_ServiceObject* copy;
}

@property(nonatomic,strong)NSString* headPhoto;//头像

@property(nonatomic,strong)NSString* headPhotoGaoQing;//高清头像

@property(nonatomic,assign)BOOL keep;//是否收藏（YES＝收藏，NO=未收藏）

@property(nonatomic,strong)NSString* numTemper;//锤炼号

@property(nonatomic,strong)NSString* userGuid;//用户GUID

@property(nonatomic,strong)NSString * userName;//userName

@property(nonatomic,strong)NSString* userRealName;//userRealName

@property(nonatomic,strong)NSString* userType;//类型 (中介->0 中介下雇工->1 个人->2)

@property (nonatomic,retain) NSString *city; //城市

@property (nonatomic,retain) NSString* province;//省

@property (nonatomic,retain) NSString* area;//区

@property (nonatomic,retain) NSString* region;//区域

@property (nonatomic,retain) NSString *addressDetail;//详细地址

@property(nonatomic,strong)NSString* evaluate;//星级

@property(nonatomic,strong)NSString* idCard;//身份证

@property(nonatomic,strong)NSString* distanceString;//这个对象距离用户多少米

@property(nonatomic,strong)NSString* serviceNumber;//即多少人预约成功了

@property(nonatomic,strong)NSString* phoneNumber;//用户的联系电话

@property(nonatomic,strong)NSString* detailOtherInfo;//介绍

@property(nonatomic,strong) NSString * YZQuote;//某条应征时候的报价

@property(nonatomic,strong)NSString * YZRemark;//某条应征时候的备注

@property(nonatomic,strong) NSString * YZTime;//某条应征的时间

@property(nonatomic,strong)NSString* price;//某一工种报价

//公司的相关信息

@property(nonatomic,strong)NSString * companiesGuid;//公司GUID

@property(nonatomic,strong)NSString* companyPhoto;//公司头像

@property(nonatomic,strong)NSString* companyUserName;//公司用户名

@property(nonatomic,strong)NSString* companyUserRealName;//公司的真实姓名 可能没有用处

@property(nonatomic,strong)NSString *companyUserAnnear;//中介的锤炼号

@property(nonatomic,strong)NSString* respectiveCompanies;//公司名称

@property(nonatomic,strong)NSString* introductionString;//中介介绍

@property(nonatomic,strong)NSString* intermediaryResponsiblePerson;//中介负责人联系人

@property(nonatomic,strong)NSString* intermediaryResponsiblePersonPhone;//中介负责人联系人电话

@property(nonatomic,strong)NSString* intermediaryRegisterTime;//中介创建时间/开业时间

@property(nonatomic,strong)NSString* intermediaryBusinessTime;//中介营业时间

@property (nonatomic,retain) NSString *intermediary_City; //中介城市

@property (nonatomic,retain) NSString* intermediary_Province;//中介省

@property (nonatomic,retain) NSString* intermediary_Area;//中介区

@property (nonatomic,retain) NSString* intermediary_Region;//中介区域

@property (nonatomic,retain) NSString *intermediary_AddressDetail;//中介详细地址

@property (nonatomic,retain) NSString * companyPhoneNumber;//中介信息里面留下的电话

@property(nonatomic,strong)NSString* empCount;//拥有阿姨数

@property(nonatomic,strong)NSMutableArray* UserArray;//中介下短工


@property(nonatomic,retain)NSString* quality;//质量评价
@property(nonatomic,retain)NSString* attitude;//态度评价
@property(nonatomic,retain)NSString* speedStr;//速度评价

@property(nonatomic,retain)NSString* pingjiaString;//评价内容

@property(nonatomic,retain)NSString* longitude;//所在的经度
@property(nonatomic,retain)NSString* latitude;//所在的维度

@property (nonatomic,copy)NSString * sex ;//性别   0:男 1:女
@property (nonatomic,copy)NSString * age ;//年龄
@property (nonatomic,copy)NSString * education ;//学历
@property (nonatomic,copy)NSString * workExperience ;//工作经验
@property (nonatomic,copy)NSString * ethnic;//民族
@property (nonatomic,copy)NSString * hometown ;//籍贯

@property(nonatomic,strong)NSMutableArray* workTypeArray;//所具备的技能工种
@property(nonatomic,strong)NSMutableArray* evaluationArray;//所有评价

@property (nonatomic,strong) NSString *userNameSpell;//拼音
@property (nonatomic,strong) NSString *userPost;

@end
