//
//  Ty_News_Busine_HandlePlist.h
//  腾云家务
//
//  Created by lgs on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ty_News_Busine_HandlePlist : TY_BaseBusine

-(NSString* )findWorkNameAndworkTypeLevel:(int)_workTypeLevel andWorkGuid:(NSString *)_workGuid;/*根据工种的guid获取工种的名字*/
-(NSString *)findWorkUnitAndWorkName:(NSString *)_workName;/*根据工种的名字获取工种的单位*/
-(NSString *)findWorkPhotoAddress:(NSString *)_workName;/*根据工种名字获取工种的图片地址*/
@end
