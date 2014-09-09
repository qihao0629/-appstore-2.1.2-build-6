//
//  CreateMyReqVC.h
//  腾云家务
//
//  Created by 齐 浩 on 13-10-27.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_Model_XuQiuInfo.h"

@interface Ty_Pub_SelectCityVC : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* tableview;
}
@property(nonatomic,strong)Ty_Model_XuQiuInfo* xuqiuInfo;
@property(nonatomic,strong)NSMutableArray* arrContent;
@property(nonatomic,strong)NSString* area;

@end
