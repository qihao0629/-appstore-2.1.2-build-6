//
//  My_AddEmployeeModel.h
//  腾云家务
//
//  Created by 艾飞 on 14/7/9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface My_AddEmployeeModel : NSObject
/**姓名*/
@property (nonatomic,copy)NSString * userRealName;
/**性别*/
@property (nonatomic,copy)NSString * userSex;
/**生日*/
@property (nonatomic,copy)NSString * userBirthday;
/**头像*/
@property (nonatomic,retain)UIImage * userPhoto;
/**头像小*/
@property (nonatomic,retain)UIImage * userSmallPhoto;
/**地址*/
@property (nonatomic,copy)NSString * userAddressDetail;
/**编号*/
@property (nonatomic,copy)NSString * detailIntermediaryUserNumber;
/**电话号码*/
@property (nonatomic,copy)NSString * detailPhone;
/**身份证号*/
@property (nonatomic,copy)NSString * detailIdcard;
/**身份证照片*/
@property (nonatomic,retain)UIImage * detailIdcardElectronic;
/**身份证照片小*/
@property (nonatomic,retain)UIImage * smallDetailIdcardElectronic;
/**学历*/
@property (nonatomic,copy)NSString * detailRecord;
/**籍贯*/
@property (nonatomic,copy)NSString * detailCensus;

/**allkeyParameter集合*/
@property (nonatomic,strong)NSMutableArray * allkey_ModelParameter;
/**allkeyParameter集合名字*/
@property (nonatomic,strong)NSMutableArray * allkey_ModelParameterName;

/**allkeyFile集合*/
@property (nonatomic,strong)NSMutableArray * allkey_ModelFile;
/**allkeyFile集合名字*/
@property (nonatomic,strong)NSMutableArray * allkey_ModelFileName;

/**添加allkey集合*/
-(void)addAllkey_Model;

@end
