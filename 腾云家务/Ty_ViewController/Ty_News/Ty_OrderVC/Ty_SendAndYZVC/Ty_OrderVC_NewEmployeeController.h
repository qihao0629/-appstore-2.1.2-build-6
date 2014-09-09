//
//  Ty_OrderVC_NewEmployeeController.h
//  腾云家务
//
//  Created by lgs on 14-7-15.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "My_AddEmployeeModel.h"
#import "Ty_Model_ServiceObject.h"
#import "Ty_News_Busine_Network.h"//

@interface Ty_OrderVC_NewEmployeeController : TYBaseView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    UITableView * _tableView;
    My_AddEmployeeModel * my_AddemployeeModel;
    Ty_News_Busine_Network * newEmployeeBusine;
    NSString * postSalary;
}
@property (nonatomic,strong) NSString * workGuid;
@property (nonatomic,strong) NSString * workName;
@property (nonatomic,strong) Ty_Model_ServiceObject * companyNewObject;
@property (nonatomic,strong) NSString * tip;
@end