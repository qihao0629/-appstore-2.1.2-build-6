//
//  Ty_AppointmentVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_AppointmentVC.h"
#import "Ty_Pub_ReqSelectCell.h"
#import "Ty_Pub_ReqRightTextCell.h"
#import "Ty_Pub_ReqCinCell.h"
#import "Ty_Pub_ReqMemoCell.h"
#import "Ty_Appointment_AddUserCell.h"
#import "Ty_Pub_SelectCategoryVC.h"
#import "Ty_Pub_SelectCityVC.h"
#import "Ty_CustomDatePicker.h"
#import "Ty_Home_UserDetail_selectUsersVC.h"
#import "Ty_pub_ReqFinishViewController.h"
#import "Ty_AppointmentSelectCategoryVC.h"
#import "AppDelegate.h"
#import "Ty_Pub_ReqTextViewCell.h"
#import "Ty_Model_ServiceObject.h"
#import "Ty_Model_WorkListInfo.h"
#import "Ty_Pub_selectCouponVC.h"
#import "Ty_Pub_CouponPriceCell.h"
@interface Ty_AppointmentVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,AddUserViewDataSource,AddUserViewDelegate,UIActionSheetDelegate,UITextViewDelegate>
{
    UITableView* tableview;
    UITapGestureRecognizer * tapGesture;
    int textFieldTag;
    UIButton* submitButton;//确认预约按钮
}
@end
@implementation Ty_AppointmentVC
@synthesize appointMentBusine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        appointMentBusine = [[Ty_AppointmentBusine alloc]init];
        appointMentBusine.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CityChangedAppoint) name:@"CityChanged" object:nil];
    }
    return self;
}

#pragma mark ----键盘下落方法
-(void)dismissKeyBoard
{
    ResignFirstResponder
}

#pragma mark ----键盘弹出和落下
-(void)keyboardWillShow:(NSNotification *)notification
{
//    [super keyboardWillShow:notification];
    [tableview addGestureRecognizer:tapGesture];
    
    NSDictionary *info = [notification userInfo];
    
    NSValue   *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.25];
    [tableview setFrame:CGRectMake(10, 0, tableview.frame.size.width, self.view.frame.size.height-64-keyboardSize.height)];
//    if ([appointMentBusine.userService.userType isEqualToString:@"2"]) {
//        switch (textFieldTag) {
//            case 100:
//                if (tableview.frame.size.height-348<keyboardSize.height) {
//                    [tableview setFrame:CGRectMake(10, -keyboardSize.height+tableview.frame.size.height-348, tableview.frame.size.width, tableview.frame.size.height)];
//                }
//                break;
//            case 200:
//                if (tableview.frame.size.height-392<keyboardSize.height) {
//                    if (keyboardSize.height-tableview.frame.size.height+392>tableview.frame.size.height-keyboardSize.height) {
//                        [tableview setFrame:CGRectMake(10, -tableview.frame.size.height+keyboardSize.height-49, tableview.frame.size.width, tableview.frame.size.height)];
//                    }else{
//                        [tableview setFrame:CGRectMake(10, -keyboardSize.height+tableview.frame.size.height-392, tableview.frame.size.width, tableview.frame.size.height)];
//                    }
//                }
//                break;
//            case 300:
//                if (tableview.frame.size.height-196<keyboardSize.height) {
//                    [tableview setFrame:CGRectMake(10, -keyboardSize.height+tableview.frame.size.height-196, tableview.frame.size.width, tableview.frame.size.height)];
//                }
//                break;
//            case 1000:
//                if (tableview.frame.size.height-294<keyboardSize.height) {
//                    [tableview setFrame:CGRectMake(10, -keyboardSize.height+tableview.frame.size.height-294, tableview.frame.size.width, tableview.frame.size.height)];
//                }
//
//                break;
//            default:
//                break;
//        }
//    }else{
//        switch (textFieldTag) {
//            case 1000:
//                if (tableview.frame.size.height-399<keyboardSize.height) {
//                    if (keyboardSize.height-tableview.frame.size.height+399>tableview.frame.size.height-keyboardSize.height) {
//                        [tableview setFrame:CGRectMake(10, -tableview.frame.size.height+keyboardSize.height-49, tableview.frame.size.width, tableview.frame.size.height)];
//                    }else{
//                        [tableview setFrame:CGRectMake(10, -keyboardSize.height+tableview.frame.size.height-399, tableview.frame.size.width, tableview.frame.size.height)];
//                    }
//                }
//                break;
//            case 100:
//                if (tableview.frame.size.height-453<keyboardSize.height) {
//                    if (keyboardSize.height-tableview.frame.size.height+453>tableview.frame.size.height-keyboardSize.height) {
//                        [tableview setFrame:CGRectMake(10, -tableview.frame.size.height+keyboardSize.height-49, tableview.frame.size.width, tableview.frame.size.height)];
//                    }else{
//                        [tableview setFrame:CGRectMake(10, -keyboardSize.height+tableview.frame.size.height-453, tableview.frame.size.width, tableview.frame.size.height)];
//                    }
//                }
//                break;
//            case 200:
//                if (tableview.frame.size.height-493<keyboardSize.height) {
//                    if (keyboardSize.height-tableview.frame.size.height+399>tableview.frame.size.height-keyboardSize.height) {
//                        [tableview setFrame:CGRectMake(10, -tableview.frame.size.height+keyboardSize.height-49, tableview.frame.size.width, tableview.frame.size.height)];
//                    }else{
//                        [tableview setFrame:CGRectMake(10, -keyboardSize.height+tableview.frame.size.height-493, tableview.frame.size.width, tableview.frame.size.height)];
//                    }
//                }
//                break;
//            default:
//                break;
//        }
//    }
    [UIView commitAnimations];
}
-(void)keyboardWillHide:(NSNotification *)notification
{
//    [super keyboardWillHide:notification];
    [tableview removeGestureRecognizer:tapGesture];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.25];
    [tableview setFrame:CGRectMake(10, 0, tableview.frame.size.width, self.view.frame.size.height-64-49)];
//    [UIView commitAnimations];

}

#pragma mark ----视图加载
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [tableview reloadData];
//    [self setRightLabel];
//    if (appointMentBusine.xuqiuInfo.selectUserArray.count > 0) {
//        [appointMentBusine loadDatatarget];
//    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, self.view.frame.size.height-64-49) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.showsVerticalScrollIndicator = NO;
    [tableview setBackgroundColor:view_BackGroudColor];
    
    [self.view addSubview:tableview];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"pub_reqactionButton"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(Submit) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setFrame:CGRectMake(0, 0, 100, 30)];
    [submitButton setCenter:CGPointMake(self.imageView_background.frame.size.width/2, self.imageView_background.frame.size.height/2)];
    [submitButton setTitle:@"确认下单" forState:UIControlStateNormal];
    
    [self.imageView_background addSubview:submitButton];
    
    appointMentBusine.xuqiuInfo.province = USERPROVINCE;
    appointMentBusine.xuqiuInfo.city = USERCITY;
    if (USERAREA != nil&&![USERAREA isEqualToString:@""]) {
        appointMentBusine.xuqiuInfo.area = USERAREA;
    }
//    if (USERREGION != nil&&![USERREGION isEqualToString:@""]) {
//        appointMentBusine.xuqiuInfo.region = USERREGION;
//    }
    if (USERADDRESSDETAIL != nil&&![USERADDRESSDETAIL isEqualToString:@""]) {
        appointMentBusine.xuqiuInfo.addressDetail = USERADDRESSDETAIL;
    }
    tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard)];
    
    // Do any additional setup after loading the view.
}
#pragma mark ----通知修改选择城市和地址
-(void)CityChangedAppoint
{
    appointMentBusine.xuqiuInfo.province = USERPROVINCE;
    appointMentBusine.xuqiuInfo.city = USERCITY;
    if (USERAREA != nil&&![USERAREA isEqualToString:@""]) {
        appointMentBusine.xuqiuInfo.area = USERAREA;
    }else{
        appointMentBusine.xuqiuInfo.area = @"";
    }
    //    if (USERREGION != nil&&![USERREGION isEqualToString:@""]) {
    //        appointMentBusine.xuqiuInfo.region = USERREGION;
    //    }
    if (USERADDRESSDETAIL != nil&&![USERADDRESSDETAIL isEqualToString:@""]) {
        appointMentBusine.xuqiuInfo.addressDetail = USERADDRESSDETAIL;
    }else{
        appointMentBusine.xuqiuInfo.addressDetail = @"";
    }
    [tableview reloadData];
}
#pragma mark ----当要返回的时候。触发方法
-(void)viewWillbackAction
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"信息尚未保存发布，是否退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert setTag:1000];
    [alert show];
}
-(void)backClick
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"信息尚未保存发布，是否退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert setTag:1000];
    [alert show];
}
-(void)setRightLabel
{
    if (![appointMentBusine.xuqiuInfo.workName isEqualToString:@""]) {
        if (appointMentBusine.xuqiuInfo.selectUserArray.count>0) {
            
            if ([appointMentBusine.xuqiuInfo.priceUnit isEqualToString:@""]||appointMentBusine.xuqiuInfo.priceUnit == nil) {
                self.rightLabel.text = @"";
            }else{
                NSArray * arr = [appointMentBusine.xuqiuInfo.priceUnit componentsSeparatedByString:@"-"];
                if (arr.count>1) {
                    if ([arr[0] isEqualToString: arr[1]]) {
                        if ([appointMentBusine.xuqiuInfo.usedCouponInfo.couponGuid isEqualToString:@""]) {
                            self.rightLabel.text = [NSString stringWithFormat:@"应付金额：￥%0.2f",[appointMentBusine.xuqiuInfo.appointMoney floatValue]];
                        }else{
                            if (([appointMentBusine.xuqiuInfo.appointMoney floatValue]-[appointMentBusine.xuqiuInfo.usedCouponInfo.couponCutPrice floatValue])>0) {
                                self.rightLabel.text = [NSString stringWithFormat:@"应付金额：￥%0.2f",[appointMentBusine.xuqiuInfo.appointMoney floatValue]-[appointMentBusine.xuqiuInfo.usedCouponInfo.couponCutPrice floatValue]];
                            }else{
                                self.rightLabel.text = @"应付金额：￥0.00";
                            }
                        }
                    }else{
                        self.rightLabel.text = @"";
                    }
                }else{
                    self.rightLabel.text = @"";
                }
            }
        }else{
            if ([appointMentBusine.xuqiuInfo.priceUnit isEqualToString:@""]||appointMentBusine.xuqiuInfo.priceUnit == nil) {
                self.rightLabel.text = @"";
            }else{
                NSArray * arr = [appointMentBusine.xuqiuInfo.priceUnit componentsSeparatedByString:@"-"];
                if (arr.count>1) {
                    if ([arr[0] isEqualToString: arr[1]]) {
                        if ([appointMentBusine.xuqiuInfo.usedCouponInfo.couponGuid isEqualToString:@""]) {
                            self.rightLabel.text = [NSString stringWithFormat:@"应付金额：￥%0.2f",[appointMentBusine.xuqiuInfo.appointMoney floatValue]];
                        }else{
                            if (([appointMentBusine.xuqiuInfo.appointMoney floatValue]-[appointMentBusine.xuqiuInfo.usedCouponInfo.couponCutPrice floatValue])>0) {
                                self.rightLabel.text = [NSString stringWithFormat:@"应付金额：￥%0.2f",[appointMentBusine.xuqiuInfo.appointMoney floatValue]-[appointMentBusine.xuqiuInfo.usedCouponInfo.couponCutPrice floatValue]];
                            }else{
                                self.rightLabel.text = @"应付金额：￥0.00";
                            }
                        }
                    }else{
                        self.rightLabel.text = @"";
                    }
                    
                }else{
                    if ([appointMentBusine.xuqiuInfo.usedCouponInfo.couponGuid isEqualToString:@""]) {
                        self.rightLabel.text = [NSString stringWithFormat:@"应付金额：￥%0.2f",[appointMentBusine.xuqiuInfo.appointMoney floatValue]];
                    }else{
                        if (([appointMentBusine.xuqiuInfo.appointMoney floatValue]-[appointMentBusine.xuqiuInfo.usedCouponInfo.couponCutPrice floatValue])>0) {
                            self.rightLabel.text = [NSString stringWithFormat:@"应付金额：￥%0.2f",[appointMentBusine.xuqiuInfo.appointMoney floatValue]-[appointMentBusine.xuqiuInfo.usedCouponInfo.couponCutPrice floatValue]];
                        }else{
                            self.rightLabel.text = @"应付金额：￥0.00";
                        }
                    }
                }
            }
        }
    }else{
        self.rightLabel.text = @"应付金额：￥0.00";
    }
    
//    if ([appointMentBusine.xuqiuInfo.appointMoney isEqualToString:@""]) {
//        self.rightLabel.text = @"";
//    }else{
//        if ([appointMentBusine.xuqiuInfo.usedCouponInfo.couponGuid isEqualToString:@""]) {
//            self.rightLabel.text = [NSString stringWithFormat:@"应付金额：￥%0.2f",[appointMentBusine.xuqiuInfo.appointMoney floatValue]];
//        }else{
//            if (([appointMentBusine.xuqiuInfo.appointMoney floatValue]-[appointMentBusine.xuqiuInfo.usedCouponInfo.couponCutPrice floatValue])>0) {
//                self.rightLabel.text = [NSString stringWithFormat:@"应付金额：￥%0.2f",[appointMentBusine.xuqiuInfo.appointMoney floatValue]-[appointMentBusine.xuqiuInfo.usedCouponInfo.couponCutPrice floatValue]];
//            }else{
//                self.rightLabel.text = @"应付金额：￥0.00";
//            }
//        }
//    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 1000:
            switch (buttonIndex) {
                case 0:
                    
                    break;
                case 1:
                    [self.naviGationController popViewControllerAnimated:YES];
                    break;
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
}
#pragma mark ----确认下单
-(void)Submit
{
    [self dismissKeyBoard];
    [self showLoadingInView:self.view];
    submitButton.userInteractionEnabled = NO;
    self.view.userInteractionEnabled = NO;
    submitButton.alpha = 0.5f;
    [appointMentBusine pub_Appointment];
}

-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideLoadingView];
    submitButton.userInteractionEnabled = YES;
    self.view.userInteractionEnabled = YES;
    submitButton.alpha = 1.0f;
    if ([[[_notification object] objectForKey:@"message"] isEqualToString:@"个人信息"]) {
        [tableview reloadData];
    }else if ([[[_notification object] objectForKey:@"code"]isEqualToString:REQUESTFAIL]) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:[[_notification object] objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }else if([[[_notification object] objectForKey:@"code"] isEqualToString:REQUESTSUCCESS]){
        [self pushFinishViewFaBu];
        
        AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication].delegate window].rootViewController;
        
        [appDelegateVC setOrderTabBarIcon:1];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowTopTipNotification" object:nil];
    }
}
#pragma mark ----发布成功
-(void)pushFinishViewFaBu
{
    Ty_pub_ReqFinishViewController* finishView = [[Ty_pub_ReqFinishViewController alloc]init];
    [finishView.finishLabel setText:@"您的预约已预约成功！"];
    finishView.xuqiuInfo = appointMentBusine.xuqiuInfo;
    [finishView.contentsLabel setText:@"服务商将会在15分钟内响应您，请稍候..."];
    [finishView.finishImage setImage:JWImageName(@"pub_qiangdanimage")];
    [finishView.AciontButton setTitle:@"查看我的订单详细" forState:UIControlStateNormal];
    finishView.title = @"预约成功";
    TYBaseView* viewController = [[appDelegate appTabBarController] appNavigation];
    NSRange range;
    range.length = self.naviGationController.viewControllers.count-1;
    range.location = 1;
    NSArray* array = [self.naviGationController.viewControllers subarrayWithRange:range];
    [self removeViewControllersFromWindow:array];
    [viewController.naviGationController pushViewController:finishView animated:YES];
    
}
#pragma mark ----AddUserViewDelegate
-(int)NumberOfView:(AddUserView*)_AddUserView
{
    return appointMentBusine.xuqiuInfo.selectUserArray.count;
}
-(int)NumberOfRows:(AddUserView*)_AddUserView
{
    return 3;
}
-(int)MaxNumberOfView:(AddUserView*)_AddUserView
{
    return 1;
}

-(void)AddUserView:(AddUserView*)_AddUserView selectViewOfTag:(int)_Number
{
    if (_Number == [appointMentBusine.xuqiuInfo.selectUserArray count]||[appointMentBusine.xuqiuInfo.selectUserArray count] == 0) {
        
        NSLog(@"push");
        Ty_Home_UserDetail_selectUsersVC* res_selectUser = [[Ty_Home_UserDetail_selectUsersVC alloc] init];
        [res_selectUser Home_UserDetail:Ty_Home_UserDetailTypeSelect];
        res_selectUser.title = @"选择员工";
        res_selectUser.selectUsersBusine.userService  = [appointMentBusine.userService copy];
        res_selectUser.selectUsersBusine.xuqiuInfo = appointMentBusine.xuqiuInfo;
        res_selectUser.selectUsersBusine._selectWorkGuid = appointMentBusine.xuqiuInfo.workGuid;
        res_selectUser.selectUsersBusine._selectWorkName = appointMentBusine.xuqiuInfo.workName;
        [self.naviGationController pushViewController:res_selectUser animated:YES];
    }else{
        //        NSLog(@"%@",[a objectAtIndex:_Number]);
//        Home_ServiceDetailViewController* detail = [[Home_ServiceDetailViewController alloc]init];
//        detail.service = [xuqiuInfo.selectUserArray objectAtIndex:_Number];
//        [self.navigationController pushViewController:detail animated:YES];
    }
}
-(void)AddUserView:(AddUserView*)_AddUserView moveViewOfTag:(int)_Number
{
//    [self.service.UserArray addObject:[xuqiuInfo.selectUserArray objectAtIndex:_Number]];
    [appointMentBusine.xuqiuInfo.selectUserArray removeObjectAtIndex:_Number];
    if (![appointMentBusine.xuqiuInfo.workGuid isEqualToString:@""] && appointMentBusine.xuqiuInfo.workGuid != nil) {
        for (int i = 0; i<[appointMentBusine.userService.workTypeArray count]; i++) {
            if ([appointMentBusine.xuqiuInfo.workGuid isEqualToString:[[appointMentBusine.userService.workTypeArray objectAtIndex:i] workGuid]]) {
                appointMentBusine.xuqiuInfo.priceUnit = [[appointMentBusine.userService.workTypeArray objectAtIndex:i] postSalary];
            }
        }
    }else{
        appointMentBusine.xuqiuInfo.priceUnit = @"";
    }
    [tableview reloadData];
}
#pragma mark ----AddUserViewDatasource
-(void)AddUserView:(AddUserView *)_AddUserView getCAppButton:(CAppButton *)_appButton numberOftag:(int)_Number
{
    [_appButton setTitle:[[appointMentBusine.xuqiuInfo.selectUserArray objectAtIndex:_Number] userRealName] forState:UIControlStateNormal];
    if ([[[appointMentBusine.xuqiuInfo.selectUserArray objectAtIndex:_Number] headPhoto] isEqualToString:@""]) {
        if ([[[appointMentBusine.xuqiuInfo.selectUserArray objectAtIndex:_Number] sex] isEqualToString:@"0"]) {
            [_appButton setImage:[UIImage imageNamed:@"Contact_image1"] forState:UIControlStateNormal];
        }else{
            [_appButton setImage:[UIImage imageNamed:@"Contact_image"] forState:UIControlStateNormal];
        }
        
    }else{
        if ([[[appointMentBusine.xuqiuInfo.selectUserArray objectAtIndex:_Number] sex] isEqualToString:@"0"]) {
            [_appButton setImageWithURL:[NSURL URLWithString:[[appointMentBusine.xuqiuInfo.selectUserArray objectAtIndex:_Number] headPhoto]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Contact_image1"]];
        }else{
            [_appButton setImageWithURL:[NSURL URLWithString:[[appointMentBusine.xuqiuInfo.selectUserArray objectAtIndex:_Number] headPhoto]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Contact_image"]];
        }
        
        
    }

}
#pragma mark ----textField代理
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textFieldTag = textField.tag;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag == 100){
        appointMentBusine.xuqiuInfo.contact = textField.text;
    }else if(textField.tag == 200){
        appointMentBusine.xuqiuInfo.contactPhone = textField.text;
    }else if(textField.tag == 300){
        appointMentBusine.xuqiuInfo.addressDetail = textField.text;
    }else if(textField.tag == 1000){
        appointMentBusine.xuqiuInfo.workAmount = textField.text;
    }
//    if (![appointMentBusine.xuqiuInfo.workName isEqualToString:@""]) {
//        if (appointMentBusine.xuqiuInfo.selectUserArray.count>0) {
//            
//            NSString * salary ;
//            
//            for (int i = 0; i < [[appointMentBusine.xuqiuInfo.selectUserArray[0] workTypeArray] count]; i++) {
//                if ([[[[appointMentBusine.xuqiuInfo.selectUserArray[0] workTypeArray] objectAtIndex:i] workName] isEqualToString:appointMentBusine.xuqiuInfo.workName]) {
//                    salary = [[[appointMentBusine.xuqiuInfo.selectUserArray[0] workTypeArray] objectAtIndex:i] postSalary];
//                }
//            }
//            if ([salary isEqualToString:@""]||salary == nil) {
//                
//                
//            }else{
//                NSArray * arr = [salary componentsSeparatedByString:@"-"];
//                if (arr.count>1) {
//                    if ([arr[0] isEqualToString: arr[1]]) {
//                        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
//                        NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:2 inSection:1];
//                        NSArray* arr = [[NSArray alloc] initWithObjects:indexPath,indexPath2, nil];
//                        [tableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
//                    }else{
//                        
//                    }
//                }else{
//                    
//                }
//            }
//        }else{
//            for (int i = 0; i<[appointMentBusine.userService.workTypeArray count]; i++) {
//                if ([appointMentBusine.xuqiuInfo.workGuid isEqualToString:[[appointMentBusine.userService.workTypeArray objectAtIndex:i] workGuid]]) {
//                    if ([[[appointMentBusine.userService.workTypeArray objectAtIndex:i]postSalary] isEqualToString:@""]||[[appointMentBusine.userService.workTypeArray objectAtIndex:i]postSalary] == nil) {
//                        
//                    }else{
//                        NSArray * arr = [[[appointMentBusine.userService.workTypeArray objectAtIndex:i]postSalary] componentsSeparatedByString:@"-"];
//                        if (arr.count>1) {
//                            if ([arr[0] isEqualToString: arr[1]]) {
//                                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
//                                NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:2 inSection:1];
//                                NSArray* arr = [[NSArray alloc] initWithObjects:indexPath,indexPath2, nil];
//                                [tableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
//                            }else{
//                                
//                            }
//                            
//                        }else{
//                            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
//                            NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:2 inSection:1];
//                            NSArray* arr = [[NSArray alloc] initWithObjects:indexPath,indexPath2, nil];
//                            [tableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
//                        }
//                    }
//                }
//            }
//        }
//    }else{
//        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
//        NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:2 inSection:1];
//        NSArray* arr = [[NSArray alloc] initWithObjects:indexPath,indexPath2, nil];
//        [tableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
//    }
    [tableview removeGestureRecognizer:tapGesture];
//    [self setRightLabel];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 100){
        
    }else if(textField.tag == 200){
        int length = textField.text.length;
        if (length >= 11  &&  string.length >0)
        {
            return  NO;
        }
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered  = 
        [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basic = [string isEqualToString:filtered];
        return basic;
    }else if(textField.tag == 1000){
        int length = textField.text.length;
        if (length >= 5  &&  string.length >0)
        {
            return  NO;
        }
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered  = 
        [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basic = [string isEqualToString:filtered];
        if (basic) {
            
        }
        return basic;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark ----tableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 5;
            break;
        case 1:
            return 1;
//            if (![appointMentBusine.xuqiuInfo.workName isEqualToString:@""]) {
//                if (appointMentBusine.xuqiuInfo.selectUserArray.count>0) {
//                    
//                    if ([appointMentBusine.xuqiuInfo.priceUnit isEqualToString:@""]||appointMentBusine.xuqiuInfo.priceUnit == nil) {
//                        return 1;
//                        break;
//                        
//                    }else{
//                        NSArray * arr = [appointMentBusine.xuqiuInfo.priceUnit componentsSeparatedByString:@"-"];
//                        if (arr.count>1) {
//                            if ([arr[0] isEqualToString: arr[1]]) {
//                                return 3;
//                                break;
//                            }else{
//                                return 1;
//                                break;
//                            }
//                        }else{
//                            return 1;
//                            break;
//                        }
//                    }
//                }else{
//                    if ([appointMentBusine.xuqiuInfo.priceUnit isEqualToString:@""]||appointMentBusine.xuqiuInfo.priceUnit == nil) {
//                        return 1;
//                        break;
//                    }else{
//                        NSArray * arr = [appointMentBusine.xuqiuInfo.priceUnit componentsSeparatedByString:@"-"];
//                        if (arr.count>1) {
//                            if ([arr[0] isEqualToString: arr[1]]) {
//                                return 3;
//                                break;
//                            }else{
//                                return 1;
//                                break;
//                            }
//                            
//                        }else{
//                            return 3;
//                            break;
//                        }
//                    }
//                }
//            }else{
//                return 3;
//                break;
//            }
        case 2:
            return 4;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellSelect = @"CellSelect";
    static NSString* CouponPriceCell = @"CouponPriceCell";
    static NSString* CellText = @"CellText";
    static NSString* CellTextView = @"CellTextView";
    static NSString* CellCin = @"CellCin";
    static NSString* CellMemo = @"CellMemo";
    static NSString* CellAddUsers = @"CellAddUsers";
    Ty_Pub_ReqSelectCell * cellSelect = [tableView dequeueReusableCellWithIdentifier:CellSelect];
    if(cellSelect == nil)
    {
        cellSelect = [[Ty_Pub_ReqSelectCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellSelect];
        cellSelect.backgroundColor = [UIColor whiteColor];
        cellSelect.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cellSelect setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    Ty_Pub_CouponPriceCell * couponPriceCell = [tableView dequeueReusableCellWithIdentifier:CouponPriceCell];
    if (couponPriceCell == nil) {
        couponPriceCell = [[Ty_Pub_CouponPriceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CouponPriceCell];
        cellSelect.backgroundColor = [UIColor whiteColor];
        cellSelect.accessoryType = UITableViewCellAccessoryNone;
        [cellSelect setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    Ty_Pub_ReqRightTextCell * rightTextFieldCell  = [tableView dequeueReusableCellWithIdentifier:CellText];
    if (rightTextFieldCell  ==  nil)
    {
        rightTextFieldCell = [[Ty_Pub_ReqRightTextCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellText];
        rightTextFieldCell.backgroundColor = [UIColor whiteColor];
        rightTextFieldCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Ty_Pub_ReqTextViewCell * TextViewCell  = [tableView dequeueReusableCellWithIdentifier:CellTextView];
    if (TextViewCell  ==  nil)
    {
        TextViewCell = [[Ty_Pub_ReqTextViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTextView];
        TextViewCell.backgroundColor = [UIColor whiteColor];
        TextViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Ty_Pub_ReqCinCell * cincell = [tableView dequeueReusableCellWithIdentifier:CellCin];
    if(cincell == nil)
    {
        cincell = [[Ty_Pub_ReqCinCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellCin];
        cincell.backgroundColor = [UIColor whiteColor];
        //                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cincell.textLabel setFont:FONT14_BOLDSYSTEM];
        cincell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Ty_Pub_ReqMemoCell * cellMemo  = [tableview dequeueReusableCellWithIdentifier:CellMemo];
    if (cellMemo == nil) {
        cellMemo = [[Ty_Pub_ReqMemoCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellMemo];
        cellMemo.selectionStyle = UITableViewCellSelectionStyleNone;
        cellMemo.backgroundColor = [UIColor whiteColor];
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cellSelect.leftLabel.text = @"类别";
                cellSelect.detailTextLabel.text = @"";
                cellSelect.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                if ([appointMentBusine.xuqiuInfo.workName isEqualToString:@""]) {
                    cellSelect.userInteractionEnabled = YES;
                    cellSelect.detailLabel.text = @"请选择服务分类";
                }else{
                    cellSelect.userInteractionEnabled = YES;
                    cellSelect.detailLabel.text = appointMentBusine.xuqiuInfo.workName;
                }
                cellSelect.detailLabel.textColor = [appointMentBusine.xuqiuInfo.workName isEqualToString:@""]  ? text_morenGrayColor:text_blackColor;
                return cellSelect;
                break;
            case 1:
                if (![appointMentBusine.userService.userType isEqualToString:@"2"]) {
                    Ty_Appointment_AddUserCell* reservecell = [tableview dequeueReusableCellWithIdentifier:CellAddUsers];
                    if (reservecell == nil) {
                        reservecell = [[Ty_Appointment_AddUserCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellAddUsers];
                    }
                    reservecell.selectionStyle = UITableViewCellSelectionStyleNone;
                    reservecell.backgroundColor = [UIColor whiteColor];
                    reservecell.shopLabel.text = @"商家";
                    reservecell.shopNameLabel.text = appointMentBusine.userService.respectiveCompanies;
                    reservecell.userLabel.text = @"待选雇工";
                    reservecell.addUsers.delegate = self;
                    reservecell.addUsers.datasource = self;
                    reservecell.addUsers.editing = YES;
                    [reservecell.textLabel setFont:FONT14_BOLDSYSTEM];
                    reservecell.shopNameLabel.textColor = [appointMentBusine.userService.respectiveCompanies isEqualToString:@""]  ? text_morenGrayColor:text_blackColor;
                    if (appointMentBusine.xuqiuInfo.selectUserArray.count>0) {
                        reservecell.tishiLabel.text = @"长按删除雇工～";
                    }else{
                        reservecell.tishiLabel.text = @"如不点击添加雇工，服务商将为您推荐合适人员";
                    }
                    return reservecell;
                }else{
                    cellSelect.accessoryType = UITableViewCellAccessoryNone;
                    cellSelect.leftLabel.text = @"服务人";
                    cellSelect.detailTextLabel.text = @"";
                    cellSelect.detailLabel.text = appointMentBusine.userService.userRealName;
                    cellSelect.detailLabel.textColor = [appointMentBusine.userService.userRealName isEqualToString:@""]  ? text_morenGrayColor:text_blackColor;
                    cellSelect.userInteractionEnabled = NO;
                    return cellSelect;
                }
                break;
            case 2:
                cellSelect.userInteractionEnabled = YES;
                cellSelect.detailTextLabel.text = @"";
                cellSelect.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cellSelect.leftLabel.text = @"服务时间";
                cellSelect.detailLabel.text = [appointMentBusine.xuqiuInfo.startTime isEqualToString:@""] ?  @"请选择预约时间" :  appointMentBusine.xuqiuInfo.startTime;
                cellSelect.detailLabel.textColor = [appointMentBusine.xuqiuInfo.startTime isEqualToString:@""]  ? text_morenGrayColor:text_blackColor;
                return cellSelect;
                break;
            case 3:
                cincell.textLabel.text = @"工作量";
                [cincell.textfield setPlaceholder:@"请输入工作量"];
                [cincell.textfield setKeyboardType:UIKeyboardTypeNumberPad];
                [cincell.textfield setTag:1000];
                if ([appointMentBusine.xuqiuInfo.workName isEqualToString:@""]) {
                    cincell.detailTextLabel.text = @"小时";
                }else{
                    cincell.detailTextLabel.text = [[[NSDictionary alloc] initWithContentsOfFile:WorkUnitTypefileForPath] objectForKey:appointMentBusine.xuqiuInfo.workName];
                }
                [cincell.detailTextLabel setFont:FONT14_BOLDSYSTEM];
                [cincell.textfield setDelegate:self];
                [cincell.textfield setText:appointMentBusine.xuqiuInfo.workAmount];
                
                return cincell;
                break;
            case 4:
                TextViewCell.leftLabel.text=@"备注";
                [TextViewCell.helpLabel setText:@"点击填写备注信息（选填）"];
                [TextViewCell.detailTextView setDelegate:self];
                
                [TextViewCell.detailTextView setTag:2000];
                if ([appointMentBusine.xuqiuInfo.ask_Other isEqualToString:@""]) {
                    TextViewCell.helpLabel.hidden=NO;
                }else{
                    TextViewCell.helpLabel.hidden=YES;
                }
                [TextViewCell.detailTextView setText:appointMentBusine.xuqiuInfo.ask_Other];
//                TextViewCell.detailTextView.scrollEnabled = NO;
//                [TextViewCell setHeight];
                return TextViewCell;
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                cellSelect.leftLabel.text = @"优惠券";
                cellSelect.detailTextLabel.text = @"";
                cellSelect.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cellSelect.detailLabel.text = [appointMentBusine.xuqiuInfo.usedCouponInfo.couponTitle isEqualToString:@""] ?  @"请选择优惠券" :  appointMentBusine.xuqiuInfo.usedCouponInfo.couponTitle;
                cellSelect.detailLabel.textColor = [appointMentBusine.xuqiuInfo.usedCouponInfo.couponTitle isEqualToString:@""]  ? text_morenGrayColor:text_blackColor;
                return cellSelect;
                break;
            case 1:
                cellSelect.leftLabel.text = @"小计";
                cellSelect.accessoryType = UITableViewCellAccessoryNone;
                if (![appointMentBusine.xuqiuInfo.workName isEqualToString:@""]) {
                    if (appointMentBusine.xuqiuInfo.selectUserArray.count>0) {
                        
//                        NSString * salary ;
//                        
//                        for (int i = 0; i < [[appointMentBusine.xuqiuInfo.selectUserArray[0] workTypeArray] count]; i++) {
//                            if ([[[[appointMentBusine.xuqiuInfo.selectUserArray[0] workTypeArray] objectAtIndex:i] workName] isEqualToString:appointMentBusine.xuqiuInfo.workName]) {
//                                salary = [[[appointMentBusine.xuqiuInfo.selectUserArray[0] workTypeArray] objectAtIndex:i] postSalary];
//                            }
//                        }
                        if ([appointMentBusine.xuqiuInfo.priceUnit isEqualToString:@""]||appointMentBusine.xuqiuInfo.priceUnit == nil) {
                            appointMentBusine.xuqiuInfo.appointMoney = @"";
                            cellSelect.detailLabel.text = @"请按实际情况支付";
                        }else{
                            NSArray * arr = [appointMentBusine.xuqiuInfo.priceUnit componentsSeparatedByString:@"-"];
                            if (arr.count>1) {
                                if ([arr[0] isEqualToString: arr[1]]) {
                                    appointMentBusine.xuqiuInfo.appointMoney = [NSString stringWithFormat:@"%d",[appointMentBusine.xuqiuInfo.workAmount intValue]*[arr[0] intValue]];
                                    
                                    cellSelect.detailLabel.text = [appointMentBusine.xuqiuInfo.workAmount isEqualToString:@""] ?  @"0元" : [NSString stringWithFormat:@"%@元×%@%@",arr[0],appointMentBusine.xuqiuInfo.workAmount,[[[NSDictionary alloc] initWithContentsOfFile:WorkUnitTypefileForPath] objectForKey:appointMentBusine.xuqiuInfo.workName]];
                                    ;
                                    cellSelect.detailTextLabel.text =[appointMentBusine.xuqiuInfo.workAmount isEqualToString:@""] ?  @"=0元" : [NSString stringWithFormat:@"=%@元",appointMentBusine.xuqiuInfo.appointMoney];
                                }else{
                                    appointMentBusine.xuqiuInfo.appointMoney = @"";
                                    cellSelect.detailLabel.text = @"请按实际情况支付";
                                }
                            }else{
                                appointMentBusine.xuqiuInfo.appointMoney = [NSString stringWithFormat:@"%d",[appointMentBusine.xuqiuInfo.workAmount intValue]*[[[[appointMentBusine.xuqiuInfo.selectUserArray[0] workTypeArray] objectAtIndex:0] postSalary] intValue]];
                                cellSelect.detailLabel.text = [appointMentBusine.xuqiuInfo.workAmount isEqualToString:@""] ?  @"0元" : [NSString stringWithFormat:@"%@元×%@%@",appointMentBusine.xuqiuInfo.priceUnit,appointMentBusine.xuqiuInfo.workAmount,[[[NSDictionary alloc] initWithContentsOfFile:WorkUnitTypefileForPath] objectForKey:appointMentBusine.xuqiuInfo.workName]];
                                cellSelect.detailTextLabel.text =[appointMentBusine.xuqiuInfo.workAmount isEqualToString:@""] ?  @"=0元" : [NSString stringWithFormat:@"=%@元",appointMentBusine.xuqiuInfo.appointMoney];
                            }
                        }
                        
                    }else{
                        
//                        for (int i = 0; i<[appointMentBusine.userService.workTypeArray count]; i++) {
//                            if ([appointMentBusine.xuqiuInfo.workGuid isEqualToString:[[appointMentBusine.userService.workTypeArray objectAtIndex:i] workGuid]]) {
                                if ([appointMentBusine.xuqiuInfo.priceUnit isEqualToString:@""] || appointMentBusine.xuqiuInfo.priceUnit == nil) {
                                    appointMentBusine.xuqiuInfo.appointMoney = @"";
                                    cellSelect.detailLabel.text = @"请按实际情况支付";
                                }else{
                                    NSArray * arr = [appointMentBusine.xuqiuInfo.priceUnit componentsSeparatedByString:@"-"];
                                    if (arr.count>1) {
                                        if ([arr[0] isEqualToString: arr[1]]) {
                                            appointMentBusine.xuqiuInfo.appointMoney = [NSString stringWithFormat:@"%d",[appointMentBusine.xuqiuInfo.workAmount intValue]*[arr[0] intValue]];
                                            cellSelect.detailLabel.text = [appointMentBusine.xuqiuInfo.workAmount isEqualToString:@""] ?  @"0元" :  [NSString stringWithFormat:@"%@元×%@%@",arr[0],appointMentBusine.xuqiuInfo.workAmount,[[[NSDictionary alloc] initWithContentsOfFile:WorkUnitTypefileForPath] objectForKey:appointMentBusine.xuqiuInfo.workName]];
                                            
                                            cellSelect.detailTextLabel.text =[appointMentBusine.xuqiuInfo.workAmount isEqualToString:@""] ?  @"=0元" : [NSString stringWithFormat:@"=%@元",appointMentBusine.xuqiuInfo.appointMoney];
                                        }else{
                                            appointMentBusine.xuqiuInfo.appointMoney = @"";
                                            cellSelect.detailLabel.text = @"请按实际情况支付";
                                        }
                                        
                                    }else{
                                        appointMentBusine.xuqiuInfo.appointMoney = [NSString stringWithFormat:@"%d",[appointMentBusine.xuqiuInfo.workAmount intValue]*[appointMentBusine.xuqiuInfo.priceUnit intValue]];
                                        cellSelect.detailLabel.text = [appointMentBusine.xuqiuInfo.workAmount isEqualToString:@""] || [appointMentBusine.xuqiuInfo.workGuid isEqualToString:@""] ?  @"0元" :  [NSString stringWithFormat:@"%@元×%@%@",appointMentBusine.xuqiuInfo.priceUnit,appointMentBusine.xuqiuInfo.workAmount,[[[NSDictionary alloc] initWithContentsOfFile:WorkUnitTypefileForPath] objectForKey:appointMentBusine.xuqiuInfo.workName]];
                                        cellSelect.detailTextLabel.text =[appointMentBusine.xuqiuInfo.workAmount isEqualToString:@""] ?  @"=0元" : [NSString stringWithFormat:@"=%@元",appointMentBusine.xuqiuInfo.appointMoney];
                                    }
                                }
                            }
//                        }
//                    }
                    cellSelect.detailLabel.textColor = [appointMentBusine.xuqiuInfo.workAmount isEqualToString:@""]  ? text_morenGrayColor:text_blackColor;
                    cellSelect.detailTextLabel.textColor = [appointMentBusine.xuqiuInfo.workAmount isEqualToString:@""]  ? text_morenGrayColor:text_blackColor;
                }else{
                    appointMentBusine.xuqiuInfo.appointMoney = @"0";
                    cellSelect.detailLabel.text = @"0元";
                    cellSelect.detailTextLabel.text = @"=0元";
                    cellSelect.detailLabel.textColor = text_morenGrayColor;
                    cellSelect.detailTextLabel.textColor = text_morenGrayColor;
                }
//                [self setRightLabel];
                return cellSelect;
                break;
        
            case 2:
                couponPriceCell.leftLabel.text = @"订单金额";
                if ([appointMentBusine.xuqiuInfo.appointMoney isEqualToString:@""]) {
                    couponPriceCell.detailTextLabel.text = @"请按实际情况支付";
                    couponPriceCell.detailfristLabel.text = @"";
                    couponPriceCell.detailsecondLabel.text = @"";
                }else{
                    if ([appointMentBusine.xuqiuInfo.usedCouponInfo.couponGuid isEqualToString:@""]) {
                        couponPriceCell.detailTextLabel.text = [NSString stringWithFormat:@"￥%0.2f",[appointMentBusine.xuqiuInfo.appointMoney floatValue]];
                        couponPriceCell.detailfristLabel.text = @"";
                        couponPriceCell.detailsecondLabel.text =@"";
                    }else{
                        couponPriceCell.detailTextLabel.text = @"";
                        couponPriceCell.detailfristLabel.text = [NSString stringWithFormat:@"优惠：￥-%0.2f",[appointMentBusine.xuqiuInfo.usedCouponInfo.couponCutPrice floatValue]];
                        if (([appointMentBusine.xuqiuInfo.appointMoney floatValue]-[appointMentBusine.xuqiuInfo.usedCouponInfo.couponCutPrice floatValue])>0) {
                            couponPriceCell.detailsecondLabel.text = [NSString stringWithFormat:@"￥%0.2f",[appointMentBusine.xuqiuInfo.appointMoney floatValue]-[appointMentBusine.xuqiuInfo.usedCouponInfo.couponCutPrice floatValue]];
                        }else{
                            couponPriceCell.detailsecondLabel.text = @"￥0.00";
                        }
                    }
                }
                couponPriceCell.detailTextLabel.textColor = text_RedColor;
                couponPriceCell.detailfristLabel.textColor = text_GreenColor;
                couponPriceCell.detailsecondLabel.textColor = text_RedColor;
                return couponPriceCell;
                break;
            default:
                break;
        }
    }
//    else if (indexPath.section == 1){
//        switch (indexPath.row) {
//            case 0:
//                cellSelect.userInteractionEnabled = YES;
//                cellSelect.leftLabel.text = @"服务时间";
//                cellSelect.detailLabel.text = [appointMentBusine.xuqiuInfo.startTime isEqualToString:@""] ?  @"请选择预约时间" :  appointMentBusine.xuqiuInfo.startTime;
//                cellSelect.detailLabel.textColor = [appointMentBusine.xuqiuInfo.startTime isEqualToString:@""]  ? text_morenGrayColor:text_blackColor;
//                return cellSelect;
//                break;
//            case 1:
//                cincell.textLabel.text = @"工作量";
//                [cincell.textfield setPlaceholder:@"请输入工作量"];
//                [cincell.textfield setKeyboardType:UIKeyboardTypeNumberPad];
//                [cincell.textfield setTag:1000];
//                if ([appointMentBusine.xuqiuInfo.workName isEqualToString:@""]) {
//                    cincell.detailTextLabel.text = @"小时";
//                }else{
//                    cincell.detailTextLabel.text = [[[NSDictionary alloc] initWithContentsOfFile:WorkUnitTypefileForPath] objectForKey:appointMentBusine.xuqiuInfo.workName];
//                }
//                [cincell.detailTextLabel setFont:FONT14_BOLDSYSTEM];
//                [cincell.textfield setDelegate:self];
//                [cincell.textfield setText:appointMentBusine.xuqiuInfo.workAmount];
//                
//                return cincell;
//                break;
//#pragma mark ----待完善
//            case 3:
//                return cellSelect;
//            default:
//                return cellSelect;
//                break;
//        }
//        
//    }
    else if(indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                cellSelect.userInteractionEnabled = YES;
                cellSelect.detailTextLabel.text = @"";
                cellSelect.leftLabel.text = @"所在区域";
                cellSelect.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cellSelect.detailLabel.text = [appointMentBusine.xuqiuInfo.area isEqualToString:@""] ?  @"请选择所在区域" :[NSString stringWithFormat:@"%@  %@",appointMentBusine.xuqiuInfo.area,appointMentBusine.xuqiuInfo.region];
                cellSelect.detailLabel.textColor = [appointMentBusine.xuqiuInfo.area isEqualToString:@""]  ? text_morenGrayColor:text_blackColor;
                return cellSelect;
                break;
            case 1:
                TextViewCell.leftLabel.text=@"详细地址";
                [TextViewCell.helpLabel setText:@"至少5字,不超过50字。"];
                [TextViewCell.detailTextView setDelegate:self];
                [TextViewCell.detailTextView setTag:1000];
                if ([appointMentBusine.xuqiuInfo.addressDetail isEqualToString:@""]) {
                    TextViewCell.helpLabel.hidden=NO;
                }else{
                    TextViewCell.helpLabel.hidden=YES;
                }
                [TextViewCell.detailTextView setText:appointMentBusine.xuqiuInfo.addressDetail];
                return TextViewCell;
//                rightTextFieldCell.leftLabel.text  = @"详细地址";
//                [rightTextFieldCell.detailTextField setPlaceholder:@"至少5字"];
//                [rightTextFieldCell.detailTextField setDelegate:self];
//                [rightTextFieldCell.detailTextField setTag:300];
//                [rightTextFieldCell.detailTextField setText:appointMentBusine.xuqiuInfo.addressDetail];
                return rightTextFieldCell;
                break;
            case 2:
                rightTextFieldCell.leftLabel.text  = @"联系人";
                [rightTextFieldCell.detailTextField setPlaceholder:@"请填写联系人"];
                [rightTextFieldCell.detailTextField setDelegate:self];
                [rightTextFieldCell.detailTextField setTag:100];
                [rightTextFieldCell.detailTextField setText: appointMentBusine.xuqiuInfo.contact];
                return rightTextFieldCell;
                break;
            case 3:
                rightTextFieldCell.leftLabel.text  = @"手机号";
                [rightTextFieldCell.detailTextField setPlaceholder:@"请填写联系人手机号"];
                [rightTextFieldCell.detailTextField setDelegate:self];
                [rightTextFieldCell.detailTextField setTag:200];
                [rightTextFieldCell.detailTextField setText: appointMentBusine.xuqiuInfo.contactPhone];
                return rightTextFieldCell;
                
                break;
                
            default:
                break;
                
        }
    }else if (indexPath.section == 3){
        switch (indexPath.row) {
            
            default:
                break;
        }
    }else if (indexPath.section == 4){
        switch (indexPath.row) {
           
            case 2:
                return cellMemo;
                break;
                
            default:
                break;
        }
    }
    return cellSelect;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 4:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    
                    break;
                case 1:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    if (![appointMentBusine.userService.userType isEqualToString:@"2"]) {
                        Ty_Appointment_AddUserCell*adduser = (Ty_Appointment_AddUserCell*)cell;
                        [adduser.addUsers reloadData];
                    }
                    break;
                default:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 2:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
                default:
                    if ([tableview numberOfRowsInSection:1]==indexPath.row+1) {
                        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    }else{
                        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    }
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 3:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
                default:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
            }
            break;
        case 3:
            switch (indexPath.row) {
                case 1:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
                default:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
            }
            break;
        case 4:
            switch (indexPath.row) {
                case 0:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
                default:
                   
                    break;
            }
            break;
        default:
            break;
    }
    
}


#pragma mark ----tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1 || indexPath.row == 4) {
            UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
            return cell.frame.size.height;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 2) {
            UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
            return cell.frame.size.height;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
            return cell.frame.size.height;
        }
    }
//    else if(indexPath.section == 2){
//        if (indexPath.row == 1) {
//            UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//            return cell.frame.size.height;
//        }
//    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 10;
            break;
        default:
            return 0;
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,10)];
    switch (section) {
        case 0:
            return view;
            break;
        default:
            return nil;
            break;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissKeyBoard];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            Ty_AppointmentSelectCategoryVC* create = [[Ty_AppointmentSelectCategoryVC alloc]init];
            create.appointmentBusine.xuqiuInfo = appointMentBusine.xuqiuInfo;
            create.appointmentBusine.home_user_detailType = appointMentBusine.home_userDetailType;
            create.appointmentBusine.userService = appointMentBusine.userService;
            create.title = @"服务类型";
            [self.naviGationController pushViewController:create animated:YES];
        }else if (indexPath.row == 2) {
            Ty_CustomDatePicker *customDatePicker = [[Ty_CustomDatePicker alloc]initWithTitle:@"选择服务时间" delegate:self];
            [customDatePicker setTag:100];
            [customDatePicker showInView:self.view];
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            if ([appointMentBusine.xuqiuInfo.workGuid isEqualToString:@""] && appointMentBusine.home_userDetailType != Ty_Home_UserDetailTypeCoupon) {
                [self showToastMakeToast:@"请选择服务类型" duration:1.0f position:@"bottom"];
            }else{
                if (appointMentBusine.home_userDetailType != Ty_Home_UserDetailTypeCoupon) {
                    Ty_Pub_selectCouponVC * pub_selectCoupon = [[Ty_Pub_selectCouponVC alloc] init];
                    pub_selectCoupon.selectCouponBusine.xuqiuInfo = appointMentBusine.xuqiuInfo;
                    pub_selectCoupon.selectCouponBusine.serverObject = appointMentBusine.userService;
                    [self.naviGationController pushViewController:pub_selectCoupon animated:YES];
                }
            }
            
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            Ty_Pub_SelectCityVC* create = [[Ty_Pub_SelectCityVC alloc]init];
            create.xuqiuInfo = appointMentBusine.xuqiuInfo;
            create.title = @"选择区";
            [self.naviGationController pushViewController:create animated:YES];
        }
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        ResignFirstResponder
        return NO;
    }
    if ([text isEqualToString:@" "]) {
        return NO;
    }
    if (range.location == 0 && [text isEqualToString:@""] && range.length <= 1 && textView.text.length<=1) {
        for(UIView* helpLabel in textView.subviews)
        {
            if ([helpLabel isKindOfClass:[UILabel class]] && helpLabel.tag == 1000) {
                helpLabel.hidden=NO;
            }
        }
    }else{
        for(UIView* helpLabel in textView.subviews)
        {
            if ([helpLabel isKindOfClass:[UILabel class]] && helpLabel.tag == 1000) {
                helpLabel.hidden=YES;
            }
        }
    }
    if (range.location>50&&range.length==0) {
        return NO;
    }else{
        return YES;
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 1000) {
        appointMentBusine.xuqiuInfo.addressDetail = textView.text;
        [tableview removeGestureRecognizer:tapGesture];
    }else if(textView.tag == 2000){
        appointMentBusine.xuqiuInfo.ask_Other = textView.text;
        [tableview removeGestureRecognizer:tapGesture];
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 100){
        Ty_CustomDatePicker *datepicker = (Ty_CustomDatePicker *)actionSheet;
        if (buttonIndex == 1) {
            appointMentBusine.xuqiuInfo.startTime = [NSString stringWithFormat:@"%@",datepicker.customDate.dateString];
            [tableview reloadData];
        }
    }
    if (actionSheet.tag == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark ----- Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
