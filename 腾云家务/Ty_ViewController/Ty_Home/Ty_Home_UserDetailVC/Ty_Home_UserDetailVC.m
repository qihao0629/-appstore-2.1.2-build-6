//
//  Ty_Home_UserDetailVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Home_UserDetailVC.h"
#import "Ty_UserInfoView.h"
#import "Ty_UserInfroCompanyView.h"
#import "Ty_Model_WorkListInfo.h"
#import "Ty_userDetail_defaultCell.h"
#import "Ty_UseDetail_SelectTypeInfoCell.h"
#import "Ty_UserDetail_userInfoCell.h"
#import "Ty_UserDetail_userCell.h"
#import "Ty_UserDetail_evaluationCell.h"
#import "My_LoginViewController.h"
@interface Ty_Home_UserDetailVC ()<UITableViewDataSource,UITableViewDelegate,Ty_UserInfroCompanyDelegate,UIAlertViewDelegate>
{
    UITableView* tableview;
    UIView* heardView;
    UIWebView* phoneCallWebView;
    UIButton* appointmentButton;
    BOOL workBool;
    Ty_Home_UserDetailType home_UserDetailType;
}

@end

@implementation Ty_Home_UserDetailVC
@synthesize userDetailBusine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        workBool = NO;
        userDetailBusine = [[Ty_Home_UserDetailBusine alloc] init];
        userDetailBusine.delegate = self;
    }
    return self;
}
-(void)Home_UserDetail:(enum Ty_Home_UserDetailType)_Ty_Home_UserDetailType
{
    home_UserDetailType = _Ty_Home_UserDetailType;
}
#pragma mark ----初始化UI
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([userDetailBusine.userService.userType isEqualToString:@"0"]) {
        self.title = userDetailBusine.userService.respectiveCompanies;
    }else{
        self.title = userDetailBusine.userService.userRealName;
    }
    userDetailBusine.userService.workTypeArray = [[NSMutableArray alloc]init];
    userDetailBusine.userService.evaluationArray = [[NSMutableArray alloc]init];
    
    heardView = [[UIView alloc]init];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, self.view.frame.size.height-64-49) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.delegate = self;
    tableview.dataSource = self;
    
    tableview.hidden = YES;
    
    
    UIImageView* back = [[UIImageView alloc]initWithFrame:tableview.frame];
    [back setBackgroundColor:view_BackGroudColor];
    tableview.backgroundView = back;
    
    back = nil;
    tableview.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:tableview];
    
    appointmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [appointmentButton setBackgroundImage:JWImageName(@"home_actionButton") forState:UIControlStateNormal];
    if (home_UserDetailType == Ty_Home_UserDetailTypeSelect) {
        [appointmentButton setTitle:@"选定" forState:UIControlStateNormal];
    }else{
        [appointmentButton setTitle:@"预约下单" forState:UIControlStateNormal];
    }
    [appointmentButton addTarget:self action:@selector(appointMentAction) forControlEvents:UIControlEventTouchUpInside];
    [appointmentButton setFrame:CGRectMake(self.view.frame.size.width/2-50, 9, 100, 30)];
    
    
    [userDetailBusine loadDatatarget];
    
    [self.button_ok setImage:JWImageName(@"home_message_red") forState:UIControlStateNormal];
    [self showLoadingInView:self.view];
    
    // Do any additional setup after loading the view.
}
#pragma mark ----设置leftButton关注按钮
-(void)setPayAttentionTo{
    if ([MyLoginUserType isEqualToString:@"2"]) {
        if ([userDetailBusine.userService.userGuid isEqualToString:MyLoginUserGuid]) {
            self.naviGationController.leftBarButton.hidden = YES;
        }else{
            if (userDetailBusine.userService.keep) {
                [self.naviGationController.leftBarButton setTitle:@"取消关注" forState:UIControlStateNormal];
            }else{
                [self.naviGationController.leftBarButton setTitle:@"关注" forState:UIControlStateNormal];
            }
            [self.naviGationController.leftBarButton addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        self.naviGationController.leftBarButton.hidden = YES;
    }
}
#pragma mark ----关注点击方法
-(void)leftBarButtonClick
{
    if (IFLOGINYES) {
        [userDetailBusine setAddUser];
    }else{
        [self showToastMakeToast:@"未登录" duration:1 position:@"bottom"];
    }
    
}
#pragma mark ----设置头信息
                   //设置公司信息
-(UIView* )setUserInfoCompany
{
    Ty_UserInfroCompanyView* userinfo = [[Ty_UserInfroCompanyView alloc]initWithFrame:CGRectMake(0, 0, 300, 190)];
    [userinfo setBackgroundColor:view_BackGroudColor];
    userinfo.delegate = self;
    
    [userinfo.HeadImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userDetailBusine.userService.headPhoto]] placeholderImage:JWImageName(@"Contact_image2")];
    userinfo.HeadImage.userInteractionEnabled = YES;
    userinfo.HeadImage.contentMode = UIViewContentModeScaleAspectFill;
    userinfo.HeadImage.tag = 10000;
    [userinfo.HeadImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)] ];
    
    userinfo.nameLabel.text = userDetailBusine.userService.respectiveCompanies;
    [userinfo.typeLabel setText:@"商户"];
    userinfo.fuzerenLabel.text = [NSString stringWithFormat:@"负责人:%@",userDetailBusine.userService.intermediaryResponsiblePerson];
    userinfo.fuwuquyuLabel.text = [NSString stringWithFormat:@"所在区域:%@",userDetailBusine.userService.intermediary_Area];
    userinfo.kaishiyeTimeLabel.text = [NSString stringWithFormat:@"开业时间:%@",userDetailBusine.userService.intermediaryRegisterTime];
    [userinfo.customStar setCustomStarNumber:[userDetailBusine.userService.evaluate floatValue]];
    [userinfo.sumNumberLabel setText:[NSString stringWithFormat:@"%@人预约",userDetailBusine.userService.serviceNumber]];
    
    NSMutableString * dataString=[[NSMutableString alloc]init];
    [dataString setString:userDetailBusine.userService.introductionString];
    if (dataString.length > 9) {
        [dataString insertString:@"\n" atIndex:8];
    }
    userinfo.introductionString.text = [NSString stringWithFormat:@"商户介绍：%@",dataString];
    
    userinfo.intermediaryBusinessTime.text = [NSString stringWithFormat:@"营业时间:%@",userDetailBusine.userService.intermediaryBusinessTime];
    [userinfo.addressButton setTitle:userDetailBusine.userService.intermediary_AddressDetail forState:UIControlStateNormal];
    [userinfo.addressButton addTarget:self action:@selector(pushMap) forControlEvents:UIControlEventTouchUpInside];
    if (home_UserDetailType==Ty_Home_UserDetailTypeMap||home_UserDetailType==Ty_Home_UserDetailTypeNone) {
        userinfo.addressButton.userInteractionEnabled=NO;
    }else{
        userinfo.addressButton.userInteractionEnabled=YES;
    }
    if ([userDetailBusine.userService.intermediaryResponsiblePersonPhone isEqualToString:@""]||[userDetailBusine.userService.intermediaryResponsiblePersonPhone isEqualToString:@"null"]) {
        [userinfo.telButton setTitle:@"商家暂未填写服务电话！" forState:UIControlStateNormal];
    }else{
        
        [userinfo.telButton setTitle:userDetailBusine.userService.intermediaryResponsiblePersonPhone
                            forState:UIControlStateNormal];
        [userinfo.telButton addTarget:self action:@selector(CallPhone)
                     forControlEvents:UIControlEventTouchUpInside];
    }
    
//    userinfo.telButton.accessoryTypeImage.hidden = YES;
//    userinfo.addressButton.accessoryTypeImage.hidden = YES;
    [userinfo setLoadView];

    return userinfo;
}

//设置公司员工信息
-(UIView*)setUserInfoStaff
{
    Ty_UserInfoView* userinfo = [[Ty_UserInfoView alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
    userinfo.telButton.hidden = YES;
    [userinfo.customStar setCustomStarNumber:[userDetailBusine.userService.evaluate floatValue]];
    [userinfo.sumNumberLabel setText:[NSString stringWithFormat:@"%@人预约",userDetailBusine.userService.serviceNumber]];
    [userinfo.typeLabel setText:userDetailBusine.userService.respectiveCompanies];
    [userinfo setBackgroundColor:view_BackGroudColor];
    if ([userDetailBusine.userService.sex isEqualToString:@"0"]) {
        [userinfo.HeadImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userDetailBusine.userService.headPhoto]] placeholderImage:JWImageName(@"Contact_image1")];
        
    }else{
        [userinfo.HeadImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userDetailBusine.userService.headPhoto]] placeholderImage:JWImageName(@"Contact_image")];
        
    }
    userinfo.HeadImage.userInteractionEnabled = YES;
    userinfo.HeadImage.contentMode = UIViewContentModeScaleAspectFill;
    userinfo.HeadImage.tag = 10000;
    [userinfo.HeadImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)] ];
    
    userinfo.nameLabel.text = userDetailBusine.userService.userRealName;
    userinfo.ageLabel.text = [NSString stringWithFormat:@"%@岁",userDetailBusine.userService.age];
    userinfo.censusLabel.text = userDetailBusine.userService.hometown;
    userinfo.IdCardLabel.text = [NSString stringWithFormat:@"%@",userDetailBusine.userService.idCard];
    
    [userinfo setLoadView];
    
    return userinfo;

}

//设置个人信息
-(UIView*)setUserInfoPersonal
{
    Ty_UserInfoView* userinfo = [[Ty_UserInfoView alloc]initWithFrame:CGRectMake(0, 0, 300, 140)];
    [userinfo setBackgroundColor:view_BackGroudColor];
    if ([userDetailBusine.userService.sex isEqualToString:@"0"]) {
        [userinfo.HeadImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userDetailBusine.userService.headPhoto]]placeholderImage:JWImageName(@"Contact_image1")];
        
    }else{
        [userinfo.HeadImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userDetailBusine.userService.headPhoto]] placeholderImage:JWImageName(@"Contact_image")];
        
    }
    userinfo.HeadImage.userInteractionEnabled = YES;
    userinfo.HeadImage.contentMode = UIViewContentModeScaleAspectFill;
    userinfo.HeadImage.tag = 10000;
    [userinfo.HeadImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)] ];
    
    [userinfo.typeLabel setText:@"个人"];
    userinfo.nameLabel.text = userDetailBusine.userService.userRealName;
    [userinfo.customStar setCustomStarNumber:[userDetailBusine.userService.evaluate floatValue]];
    [userinfo.sumNumberLabel setText:[NSString stringWithFormat:@"%@人预约",userDetailBusine.userService.serviceNumber]];
    userinfo.ageLabel.text = [NSString stringWithFormat:@"%@岁",userDetailBusine.userService.age];
    userinfo.censusLabel.text = userDetailBusine.userService.hometown;
    userinfo.IdCardLabel.text = [NSString stringWithFormat:@"%@",userDetailBusine.userService.idCard];
    if ([userDetailBusine.userService.phoneNumber isEqualToString:@""]||[userDetailBusine.userService.phoneNumber isEqualToString:@"null"]) {
        [userinfo.telButton setTitle:@"商家暂未填写服务电话！" forState:UIControlStateNormal];
    }else{
        [userinfo.telButton setTitle:userDetailBusine.userService.phoneNumber forState:UIControlStateNormal];
        [userinfo.telButton addTarget:self action:@selector(CallPhone) forControlEvents:UIControlEventTouchUpInside];
    }
//    if ([userDetailBusine._selectWorkGuid isEqualToString:@""]) {
//        [userinfo.priceLabel initWithStratString:@"" startColor:Color_orange startFont:FONT20_BOLDSYSTEM centerString:@"" centerColor:Color_orange centerFont:FONT20_BOLDSYSTEM endString:@"" endColor:Color_orange endFont:FONT13_SYSTEM];
//        userinfo.workTypeLabel.text = @"";
//    }else{
//        NSString* priceString;
//        for (int i = 0; i<[userDetailBusine.userService.workTypeArray count]; i++) {
//            if ([userDetailBusine._selectWorkName isEqualToString:[[userDetailBusine.userService.workTypeArray objectAtIndex:i] workName]]) {
//                priceString = [[userDetailBusine.userService.workTypeArray objectAtIndex:i] postSalary];
//            }
//        }
//        [userinfo.priceLabel initWithStratString:priceString startColor:Color_orange startFont:FONT20_BOLDSYSTEM centerString:@"元" centerColor:Color_orange centerFont:FONT20_BOLDSYSTEM endString:[NSString stringWithFormat:@"/%@",[WorkUnitDic objectForKey:userDetailBusine._selectWorkName]] endColor:Color_orange endFont:FONT13_SYSTEM];
//        [userinfo.priceLabel setVerticalAlignment:UIControlContentVerticalAlignmentBottom];
//        [userinfo.priceLabel setTextAlignment:NSTextAlignmentRight];
//        userinfo.workTypeLabel.text = userDetailBusine._selectWorkName;
//    }
    [userinfo setLoadView];
    return userinfo;
}
-(void)setButton_OK
{
    if (home_UserDetailType == Ty_Home_UserDetailTypeNone||![MyLoginUserType isEqualToString:@"2"]) {
        self.button_ok.hidden = YES;
    }else{
        self.button_ok.hidden = NO;
    }
}


#pragma mark ----跳转到地图
-(void)pushMap
{
    [self.naviGationController pushViewController:[userDetailBusine addressForMap] animated:YES];
}
#pragma mark ----调用拨电话
-(void)CallPhone{
    
    if ([userDetailBusine.userService.userType isEqualToString:@"0"]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"确认拨打电话吗？" message:userDetailBusine.userService.intermediaryResponsiblePersonPhone delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
        alert.tag = 1000;
        [alert show];
                
        
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"确认拨打电话吗？" message:userDetailBusine.userService.phoneNumber delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
        alert.tag = 1000;
        [alert show];

    }
//    if ( !phoneCallWebView ) {
//        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
//    }
//    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}
#pragma mark ----alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if ([userDetailBusine.userService.userType isEqualToString:@"0"]) {
            if (MyLoginUserGuid != nil && ![MyLoginUserGuid isEqualToString:@""]) {
                Ty_Phone_Model * phoneModel = [[Ty_Phone_Model alloc] init];
                phoneModel.myGuid = MyLoginUserGuid;
                phoneModel.yourGuid = userDetailBusine.userService.companiesGuid;
                phoneModel.phoneNumber = userDetailBusine.userService.intermediaryResponsiblePersonPhone;
                [PhoneBusine savePhoneData:phoneModel];
            }
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",userDetailBusine.userService.intermediaryResponsiblePersonPhone]]];
            
        }else{
            if (MyLoginUserGuid != nil && ![MyLoginUserGuid isEqualToString:@""]) {
                Ty_Phone_Model * phoneModel = [[Ty_Phone_Model alloc] init];
                phoneModel.myGuid = MyLoginUserGuid;
                phoneModel.yourGuid = userDetailBusine.userService.userGuid;
                phoneModel.phoneNumber = userDetailBusine.userService.phoneNumber;
                [PhoneBusine savePhoneData:phoneModel];
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",userDetailBusine.userService.phoneNumber]]];
        }
    }
}
#pragma mark ----UserInfroCompanyView 点击更多代理
-(void)Ty_UserInfroCompanyView:(Ty_UserInfroCompanyView *)_userInfo
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    tableview.tableHeaderView = _userInfo;
    [UIView commitAnimations];
}

#pragma mark ----点击头像放大
-(void)BtnClick:(UITapGestureRecognizer *)imageTap
{
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    NSString * getImageStrUrl = [NSString stringWithFormat:@"%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@",userDetailBusine.userService.headPhotoGaoQing]]];
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = [NSURL URLWithString: getImageStrUrl ];
    UIImageView * imageView = (UIImageView *)[self.view viewWithTag: imageTap.view.tag ];
    photo.srcImageView = imageView;
    [photos addObject:photo];
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}


#pragma mark ----网络回调通知
-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideLoadingView];
    if([[[_notification object] objectForKey:@"type"] isEqualToString:@"个人信息"]){
        if ([[[_notification object ] objectForKey:@"code"] isEqualToString:@"200"]) {
            tableview.hidden = NO;
            
            if ([[[_notification object] objectForKey:@"userType"] isEqualToString:@"0"]) {
                if ([userDetailBusine.userService.companiesGuid isEqualToString:MyLoginUserGuid]){
                    home_UserDetailType = Ty_Home_UserDetailTypeNone;
                }
                tableview.tableHeaderView = [self setUserInfoCompany];
                self.title = userDetailBusine.userService.respectiveCompanies;
            }else if ([[[_notification object] objectForKey:@"userType"] isEqualToString:@"1"]){
                if ([userDetailBusine.userService.companiesGuid isEqualToString:MyLoginUserGuid]) {
                    home_UserDetailType = Ty_Home_UserDetailTypeNone;
                }
                tableview.tableHeaderView = [self setUserInfoStaff];
                self.title = userDetailBusine.userService.userRealName;
            }else{
                if ([userDetailBusine.userService.userGuid isEqualToString:MyLoginUserGuid]) {
                    home_UserDetailType = Ty_Home_UserDetailTypeNone;
                }
                tableview.tableHeaderView = [self setUserInfoPersonal];
                self.title = userDetailBusine.userService.userRealName;
            }
            if (home_UserDetailType != Ty_Home_UserDetailTypeRequirement && home_UserDetailType != Ty_Home_UserDetailTypeNone) {
                if([userDetailBusine.userService.userType isEqualToString:@"0"]){
                    [self.imageView_background addSubview:appointmentButton];
                }else if([userDetailBusine.userService.userType isEqualToString:@"1"]){
                    [appointmentButton setTitle:@"预约此人" forState:UIControlStateNormal];
                    [self.imageView_background addSubview:appointmentButton];
                }else{
                    appointmentButton.hidden=YES;
                }
            }
            [self setPayAttentionTo];
            [self setButton_OK];
            [tableview reloadData];
        }else if([[[_notification object ] objectForKey:@"code"] isEqualToString:@"203"]){
            [self showMessageInView:self.view message:@"无返回数据"];
        }else if ([[[_notification object ] objectForKey:@"code"] isEqualToString:@"404"]){
            [self showMessageInView:self.view message:@"404错误"];
        }else if ([[[_notification object ] objectForKey:@"code"] isEqualToString:@"202"]){
            [self showMessageInView:self.view message:@"202错误"];
        }else if ([[[_notification object ] objectForKey:@"code"] isEqualToString:@"201"]){
            [self showMessageInView:self.view message:@"201错误"];
        }else if ([[[_notification object ] objectForKey:@"code"] isEqualToString:REQUESTFAIL]){
            [self showNetMessageInView:self.view];
        }
    }else if([[[_notification object] objectForKey:@"type"] isEqualToString:@"员工信息"]){
        [tableview reloadData];
    }else if ([[[_notification object] objectForKey:@"type"] isEqualToString:@"评价信息"]){
        [tableview reloadData];
    }else if ([[[_notification object] objectForKey:@"type"] isEqualToString:@"关注"]){
        if ([[[_notification object] objectForKey:@"code"] isEqualToString:@"3004"]) {
            userDetailBusine.userService.keep = YES;
        }else if ([[[_notification object] objectForKey:@"code"] isEqualToString:@"3005"]) {
            userDetailBusine.userService.keep = NO;
        }else{
            [self showToastMakeToast:[[_notification object] objectForKey:@"code"] duration:1 position:@"bottom"];
        }
        [self setPayAttentionTo];
    }
}
-(void)loading{
    [self showLoadingInView:self.view];
    [userDetailBusine loadDatatarget];
}
#pragma mark ----预约
// 预约服务
-(void)appointMentAction
{
    if (home_UserDetailType == Ty_Home_UserDetailTypeSelect) {
        [userDetailBusine appointMentAction:home_UserDetailType];
        [self.naviGationController popToViewController:[self.naviGationController.viewControllers objectAtIndex:self.naviGationController.viewControllers.count-3] animated:YES];
    }else{
        if(IFLOGINYES){
            [self.naviGationController pushViewController:[userDetailBusine appointMentAction:home_UserDetailType] animated:YES];
        }else{
            My_LoginViewController* loginVC = [[My_LoginViewController alloc]init];
            [self.naviGationController pushViewController:loginVC animated:YES];
        }
        
    }
}

// 预约员工
-(void)userAppointment:(UIButton*)sender
{
    if (home_UserDetailType == Ty_Home_UserDetailTypeSelect) {
        
    }else{
        if (IFLOGINYES) {
            [self.naviGationController pushViewController:[userDetailBusine appointMentUsersAction:sender.tag] animated:YES];
        }else{
            My_LoginViewController* loginVC = [[My_LoginViewController alloc]init];
            [self.naviGationController pushViewController:loginVC animated:YES];
        }
        
    }
}

#pragma mark -----消息 函数
-(void)button_okClick{
    if (IFLOGINYES) {
        [self.naviGationController pushViewController:[userDetailBusine clickMessage] animated:YES];
    }else{
        My_LoginViewController* loginVC = [[My_LoginViewController alloc]init];
        [self.naviGationController pushViewController:loginVC animated:YES];
    }
}
#pragma mark ----UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            if ([userDetailBusine.userService.userType isEqualToString:@"0"]) {
                return 0;
            }else{
                return 2;
            }
            break;
        case 1:
            if ([userDetailBusine.userService.userType isEqualToString:@"0"]) {
                return 0;
            }else{
                return 2;
            }
            break;
        case 2:
            if ([userDetailBusine.userService.userType isEqualToString:@"0"]) {
                if (home_UserDetailType == Ty_Home_UserDetailTypeCoupon) {
                    return 0;
                }else if (userDetailBusine.userService.UserArray.count>5) {
                    return 6;
                }else{
                    return userDetailBusine.userService.UserArray.count+1;
                }
            }else{
                return 0;
            }
            break;
        case 3:
            if (home_UserDetailType == Ty_Home_UserDetailTypeCoupon) {
                return 0;
            }else if (home_UserDetailType == Ty_Home_UserDetailTypeSelect) {
                return 0;
            }else{
                if (workBool) {
                    return userDetailBusine.userService.workTypeArray.count+1;
                }else{
                    return 1;
                }
                
            }
            break;
        case 4:
            if (userDetailBusine.userService.evaluationArray.count>5) {
                return 6;
            }else{
                return userDetailBusine.userService.evaluationArray.count+1;
            }
            break;
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* defaultCell = @"defaultCell";
    static NSString* selectTypeInfoCell = @"selectTypeInfoCell";
    static NSString* userInfoCell = @"userInfoCell";
    static NSString* userCell = @"userCell";
    static NSString* evaluationCell = @"evaluationCell";
    static NSString* Cell = @"Cell";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            Ty_userDetail_defaultCell* cell = [tableView dequeueReusableCellWithIdentifier:defaultCell];
            if (cell == nil) {
                cell = [[Ty_userDetail_defaultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCell];
                
            }
            cell.userInteractionEnabled = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if([userDetailBusine._selectWorkName isEqualToString:@""]){
                if (userDetailBusine.userService.workTypeArray.count>0) {
                    cell.textLabel.text = [[userDetailBusine.userService.workTypeArray objectAtIndex:0]workName];
                    cell.priceLabel.hidden = NO;
                    [cell.priceLabel initWithStratString:[[userDetailBusine.userService.workTypeArray objectAtIndex:0]postSalary] startColor:Color_orange startFont:FONT15_BOLDSYSTEM centerString:@"元" centerColor:Color_orange centerFont:FONT12_SYSTEM endString:[NSString stringWithFormat:@"/%@",[WorkUnitDic objectForKey:userDetailBusine._selectWorkName]] endColor:Color_orange endFont:FONT12_SYSTEM];
                    [cell.priceLabel setVerticalAlignment:UIControlContentVerticalAlignmentBottom];
                    [cell.priceLabel setTextAlignment:NSTextAlignmentRight];
                }
            }else{
                NSString* priceString;
                for (int i = 0; i<[userDetailBusine.userService.workTypeArray count]; i++) {
                    if ([userDetailBusine._selectWorkName isEqualToString:[[userDetailBusine.userService.workTypeArray objectAtIndex:i]workName]]) {
                        priceString = [[userDetailBusine.userService.workTypeArray objectAtIndex:i]postSalary];
                        cell.textLabel.text = [[userDetailBusine.userService.workTypeArray objectAtIndex:i]workName];
                    }
                }
                [cell.priceLabel initWithStratString:priceString startColor:Color_orange startFont:FONT15_BOLDSYSTEM centerString:@"元" centerColor:Color_orange centerFont:FONT12_SYSTEM endString:[NSString stringWithFormat:@"/%@",[WorkUnitDic objectForKey:userDetailBusine._selectWorkName]] endColor:Color_orange endFont:FONT12_SYSTEM];
                [cell.priceLabel setVerticalAlignment:UIControlContentVerticalAlignmentBottom];
                [cell.priceLabel setTextAlignment:NSTextAlignmentRight];
            }
            CGRect rect = cell.frame;
            rect.size.height = 33;
            cell.frame = rect;
            return cell;
        }else{
            Ty_UseDetail_SelectTypeInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:selectTypeInfoCell];
            if (cell == nil) {
                cell = [[Ty_UseDetail_SelectTypeInfoCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:selectTypeInfoCell];
            }
            cell.userInteractionEnabled = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            NSString* jingyan;
            NSString* techang;
            for (int i = 0; i<[userDetailBusine.userService.workTypeArray count]; i++) {
                if ([userDetailBusine._selectWorkName isEqualToString:[[userDetailBusine.userService.workTypeArray objectAtIndex:i]workName]]) {
                    jingyan = [[userDetailBusine.userService.workTypeArray objectAtIndex:i]experience];
                    techang = [[userDetailBusine.userService.workTypeArray objectAtIndex:i]specialty];
                }
            }
            if (![jingyan isEqualToString:@"null"]&&jingyan!= nil) {
                [cell.fristLabel setText:[NSString stringWithFormat:@"工作经验: %@",jingyan]];
            }else{
                [cell.fristLabel setText:[NSString stringWithFormat:@"工作经验: "]];
            }
            if (![techang isEqualToString:@"null"]&&techang!= nil) {
                [cell.secondLabel setText:[NSString stringWithFormat:@"特长标签: %@",techang]];
            }else{
                [cell.secondLabel setText:[NSString stringWithFormat:@"特长标签: "]];
            }
            return cell;
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:Cell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cell];
            }
            [cell.textLabel setTextColor:text_grayColor];
            [cell.textLabel setFont:FONT14_SYSTEM];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.userInteractionEnabled = NO;
            cell.detailTextLabel.text = @"";
            cell.textLabel.text = @"个人信息";
            CGRect rect = cell.frame;
            rect.size.height = 33;
            cell.frame = rect;

            return cell;
        }else{
            Ty_UserDetail_userInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:userInfoCell];
            if(cell == nil){
                cell = [[Ty_UserDetail_userInfoCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:userInfoCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = NO;
            cell.firstValue.text = [DIC_SEX objectForKey:userDetailBusine.userService.sex];
            cell.secondValue.text = userDetailBusine.userService.hometown;
            cell.thridValue.text = [NSString stringWithFormat:@"%@岁",userDetailBusine.userService.age];
            cell.fourthValue.text = [DIC_EDUCATION objectForKey:userDetailBusine.userService.education];
            cell.fifthValue.text = userDetailBusine.userService.addressDetail;
            cell.sixthValue.text = userDetailBusine.userService.detailOtherInfo;
            [cell setHeight];
            return cell;
        }
    
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:Cell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cell];
                
            }
            [cell.textLabel setTextColor:text_grayColor];
            [cell.textLabel setFont:FONT14_SYSTEM];
            [cell.detailTextLabel setFont:FONT14_SYSTEM];
            [cell.detailTextLabel setTextColor:text_RedColor];
            cell.accessoryType = UITableViewCellAccessoryNone;
            if ([userDetailBusine._selectWorkName isEqualToString:@""]) {
                cell.textLabel.text = @"全部员工";
            }else{
                cell.textLabel.text = userDetailBusine._selectWorkName;
            }
            if (userDetailBusine.userService.UserArray.count >= 5) {
                cell.detailTextLabel.text = @"更多";
                cell.userInteractionEnabled = YES;
            }else{
                cell.detailTextLabel.text = @"";
                cell.userInteractionEnabled = NO;
            }
            
            CGRect rect = cell.frame;
            rect.size.height = 33;
            cell.frame = rect;
            return cell;
        }else{
            Ty_UserDetail_userCell* cell = [tableView dequeueReusableCellWithIdentifier:userCell];
            if(cell == nil){
                cell = [[Ty_UserDetail_userCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:userCell];
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if ([[[userDetailBusine.userService.UserArray objectAtIndex:indexPath.row-1] sex] isEqualToString:@"0"]) {
                [cell.headImage setImageWithURL:[NSURL URLWithString:[[userDetailBusine.userService.UserArray objectAtIndex:indexPath.row-1] headPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image1"]];
            }else{
                [cell.headImage setImageWithURL:[NSURL URLWithString:[[userDetailBusine.userService.UserArray objectAtIndex:indexPath.row-1] headPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image"]];
            }
            [cell.customStar setCustomStarNumber:[[[userDetailBusine.userService.UserArray objectAtIndex:indexPath.row-1] evaluate]floatValue]];
            if (![userDetailBusine._selectWorkName isEqualToString:@""]) {
                if ([[userDetailBusine.userService.UserArray objectAtIndex:indexPath.row-1] workTypeArray].count>0) {
                    cell.priceLabel.text = [NSString stringWithFormat:@"%@元/%@",[[[[userDetailBusine.userService.UserArray objectAtIndex:indexPath.row-1] workTypeArray] objectAtIndex:0] postSalary],[WorkUnitDic objectForKey:userDetailBusine._selectWorkName]];
                }
            }
            cell.nameLabel.text = [[userDetailBusine.userService.UserArray objectAtIndex:indexPath.row-1] userRealName];
            if (home_UserDetailType == Ty_Home_UserDetailTypeRequirement||home_UserDetailType == Ty_Home_UserDetailTypeSelect||home_UserDetailType == Ty_Home_UserDetailTypeNone||![MyLoginUserType isEqualToString:@"2"]) {
                cell.yuyueButton.hidden = YES;
            }else{
                cell.yuyueButton.hidden = NO;
            }
            [cell.yuyueButton setTag:indexPath.row-1];
            [cell.yuyueButton addTarget:self action:@selector(userAppointment:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }else if(indexPath.section == 3){
        if (indexPath.row == 0) {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:Cell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cell];
            }
            [cell.textLabel setTextColor:text_grayColor];
            [cell.textLabel setFont:FONT14_SYSTEM];
            [cell.detailTextLabel setFont:FONT14_SYSTEM];
            [cell.detailTextLabel setTextColor:text_RedColor];
            cell.accessoryType = UITableViewCellAccessoryNone;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"全部服务";
            if (workBool) {
                cell.detailTextLabel.text = @"收起";
            }else{
                cell.detailTextLabel.text = @"展开";
            }
            CGRect rect = cell.frame;
            rect.size.height = 33;
            cell.frame = rect;
            return cell;
        }else{
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:Cell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cell];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.textLabel setFont:FONT15_BOLDSYSTEM];
            [cell.textLabel setTextColor:text_grayColor];
//            [cell.textLabel setTextColor:text_blackColor];
            cell.textLabel.text = [[userDetailBusine.userService.workTypeArray objectAtIndex:indexPath.row-1] workName];
            cell.detailTextLabel.text = @"";
            CGRect rect = cell.frame;
            rect.size.height = 44;
            cell.frame = rect;
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:Cell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cell];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell.textLabel setTextColor:text_grayColor];
            [cell.textLabel setFont:FONT14_SYSTEM];
            [cell.detailTextLabel setFont:FONT14_SYSTEM];
            [cell.detailTextLabel setTextColor:text_RedColor];
            cell.textLabel.text = @"评价";
            if (userDetailBusine.userService.evaluationArray.count >= 5) {
                cell.detailTextLabel.text = @"更多";
                cell.userInteractionEnabled = YES;
            }else{
                cell.detailTextLabel.text = @"";
                cell.userInteractionEnabled = NO;
            }
            CGRect rect = cell.frame;
            rect.size.height = 33;
            cell.frame = rect;

            return cell;
        }else{
            Ty_UserDetail_evaluationCell* cell = [tableView dequeueReusableCellWithIdentifier:evaluationCell];
            if (cell == nil) {
                cell = [[Ty_UserDetail_evaluationCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:evaluationCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = NO;
            cell.typeLabel.hidden = YES;
            [cell.headImage setImageWithURL:[NSURL URLWithString:[[userDetailBusine.userService.evaluationArray objectAtIndex:indexPath.row-1] headPhoto]] placeholderImage:JWImageName(@"Contact_image")];
            [cell.customstar setCustomStarNumber:[[[userDetailBusine.userService.evaluationArray objectAtIndex:indexPath.row-1] evaluate] floatValue]];
            if ([[[userDetailBusine.userService.evaluationArray objectAtIndex:indexPath.row-1] quality] isEqualToString:@"null"]) {
                cell.zhiliangLabel.text = [NSString stringWithFormat:@"质量：5"];
                
            }else {
                cell.zhiliangLabel.text = [NSString stringWithFormat:@"质量：%@",[[userDetailBusine.userService.evaluationArray objectAtIndex:indexPath.row-1] quality]];
            }
            if ([[[userDetailBusine.userService.evaluationArray objectAtIndex:indexPath.row-1] attitude] isEqualToString:@"null"]) {
                cell.taiduLabel.text = [NSString stringWithFormat:@"态度：5"];
            }else {
                cell.taiduLabel.text = [NSString stringWithFormat:@"态度：%@",[[userDetailBusine.userService.evaluationArray objectAtIndex:indexPath.row-1] attitude]];
            }
            if ([[[userDetailBusine.userService.evaluationArray objectAtIndex:indexPath.row-1] speedStr] isEqualToString:@"null"]) {
                cell.suduLabel.text = [NSString stringWithFormat:@"速度：5"];
            }else {
                cell.suduLabel.text = [NSString stringWithFormat:@"速度：%@",[[userDetailBusine.userService.evaluationArray objectAtIndex:indexPath.row-1] speedStr]];
            }
            cell.pingjiaLabel.text = [NSString stringWithFormat:@"%@",[[userDetailBusine.userService.evaluationArray objectAtIndex:indexPath.row-1] pingjiaString]];
            [cell setHight];
            return cell;
        }
    }
    Ty_userDetail_defaultCell* cell = [tableView dequeueReusableCellWithIdentifier:defaultCell];
    if (cell == nil) {
        cell = [[Ty_userDetail_defaultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCell];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 1:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
                default:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 1:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
                default:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
            }
            break;
        case 2:
            if (userDetailBusine.userService.UserArray.count == indexPath.row) {
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
            }else{
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
            }
            break;
        case 3:
            if (indexPath.row == userDetailBusine.userService.workTypeArray.count) {
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
            }else{
                if (workBool) {
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                }else{
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                }
            }
            break;
        case 4:
            if (indexPath.row == userDetailBusine.userService.evaluationArray.count) {
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg")  stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
            }else{
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
            }
            break;
        default:
            break;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            if ([userDetailBusine.userService.userType isEqualToString:@"0"]) {
                return 0;
            }else{
                return 10;
            }
            break;
        case 1:
            if ([userDetailBusine.userService.userType isEqualToString:@"0"]) {
                return 0;
            }else{
                return 10;
            }
            break;
        case 2:
            if ([userDetailBusine.userService.userType isEqualToString:@"0"]) {
                return 10;
            }else{
                return 0;
            }
            break;
        case 3:
            if (home_UserDetailType == Ty_Home_UserDetailTypeSelect) {
                return 0;
            }else{
                return 10;
            }
        default:
            return 10;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    return view;
}

#pragma mark ----tableView点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
    
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            if(IFLOGINYES){
                [self.naviGationController pushViewController:[userDetailBusine moreUsersAction:home_UserDetailType] animated:YES];
            }else{
                My_LoginViewController* loginVC = [[My_LoginViewController alloc]init];
                [self.naviGationController pushViewController:loginVC animated:YES];
            }
        }else{
            [self.naviGationController pushViewController:[userDetailBusine clickUsers:indexPath.row-1 Home_UserDetailType:home_UserDetailType] animated:YES];
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            if (workBool) {
                workBool = !workBool;
//                NSMutableArray * indexArr = [[NSMutableArray alloc] init];
//                for (int i = 1 ; i <= userDetailBusine.userService.workTypeArray.count; i++) {
//                    NSIndexPath * index = [NSIndexPath indexPathForRow:i inSection:3];
//                    [indexArr addObject:index];
//                    NSLog(@"index=%@",index);
//                }
//                NSLog(@"执行了");
//                [tableView deleteRowsAtIndexPaths:indexArr withRowAnimation:UITableViewRowAnimationNone];
//                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
                [tableView reloadData];
            }else{
                workBool = !workBool;
//                NSMutableArray * indexArr = [[NSMutableArray alloc] init];
//                for (int i = 1 ; i <= userDetailBusine.userService.workTypeArray.count; i++) {
//                    NSIndexPath * index = [NSIndexPath indexPathForRow:i inSection:3];
//                    [indexArr addObject:index];
//                }
//                [tableView insertRowsAtIndexPaths:indexArr withRowAnimation:UITableViewRowAnimationNone];
//                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
                [tableView reloadData];
            }
            
        }else{
            [self showLoadingInView:self.view];
            [tableview scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
            [userDetailBusine clickWorkType:indexPath.row-1];
            
        }
        
    }else if (indexPath.section == 4){
        if (indexPath.row == 0) {
            if(IFLOGINYES){
                [self.naviGationController pushViewController:[userDetailBusine moreEvaluation] animated:YES];
            }else{
                My_LoginViewController* loginVC = [[My_LoginViewController alloc]init];
                [self.naviGationController pushViewController:loginVC animated:YES];
            }
        }else{
            
        }
    }
    
 /*
    if ([service.typeString isEqualToString:@"0"]) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                Home_ServiceDetailSelectVC* selectVc = [[Home_ServiceDetailSelectVC alloc]init];
                selectVc.title = @"签约员工";
                selectVc.selectTitle = selectTitle;
                selectVc.selectType = selectType;
                selectVc.type = self.type;
                selectVc.typeGuid = self.typeGuid;
                
                selectVc.workTypeArray = [self.worktypeArray mutableCopy];
                [self.navigationController pushViewController:selectVc animated:YES];
                selectVc.service = self.service;
                
            }else{
                Home_ServiceDetailViewController* home = [[Home_ServiceDetailViewController alloc]init];
                home.service = [userArray objectAtIndex:indexPath.row-1];
                home.selectTitle = selectTitle;
                home.service.typeString = @"1";
                home.selectType = 0;
                [self.navigationController pushViewController:home animated:YES];
                
            }
        }else if(indexPath.section == 1){
            if (indexPath.row == 0) {
                Home_ServiceDetailSelectVC* selectVc = [[Home_ServiceDetailSelectVC alloc]init];
                selectVc.title = @"全部服务";
                selectVc.workTypeArray = [worktypeArray mutableCopy];
                selectVc.type = self.type;
                selectVc.selectType = selectType;
                selectVc.userArray = [self.userArray mutableCopy];
                selectVc.service = self.service;
                [self.navigationController pushViewController:selectVc animated:YES];
                
            }else{
                Home_ServiceDetailViewController *detailVC = [[Home_ServiceDetailViewController alloc]init];
                detailVC.typeGuid = [[worktypeArray objectAtIndex:indexPath.row-1] workGuid];
                detailVC.whereComeIn = 0;//从首页找服务进入的
                detailVC.selectTitle = [[worktypeArray objectAtIndex:indexPath.row-1] workname];
                detailVC.service = self.service;
                detailVC.selectType = 0;
                UIViewController* viewController = (UIViewController*)[self.navigationController.childViewControllers objectAtIndex:([self.navigationController.childViewControllers indexOfObject:self]-1)];
                
                //            [[[self.navigationController.childViewControllers objectAtIndex:([self.navigationController.childViewControllers indexOfObject:self]-1)] navigationController] pushViewController:detailVC animated:YES];
                [self.navigationController popViewControllerAnimated:NO];
                [viewController.navigationController pushViewController:detailVC animated:YES];
            }
        }else if(indexPath.section == 2){
            if (indexPath.row == 0) {
                Home_ServiceDetailSelectVC* selectVc = [[Home_ServiceDetailSelectVC alloc]init];
                selectVc.title = @"评价";
                selectVc.service = service;
                selectVc.selectType = selectType;
                [self.navigationController pushViewController:selectVc animated:YES];
            }
        }
    }else{
        if(indexPath.section == 2){
            if (indexPath.row == 0) {
                Home_ServiceDetailSelectVC* selectVc = [[Home_ServiceDetailSelectVC alloc]init];
                selectVc.title = @"全部服务";
                selectVc.workTypeArray = [worktypeArray mutableCopy];
                selectVc.type = self.type;
                selectVc.selectType = selectType;
                selectVc.userArray = [self.userArray mutableCopy];
                selectVc.service = self.service;
                [self.navigationController pushViewController:selectVc animated:YES];
                
            }else{
                Home_ServiceDetailViewController *detailVC = [[Home_ServiceDetailViewController alloc]init];
                detailVC.typeGuid = [[worktypeArray objectAtIndex:indexPath.row-1] workGuid];
                detailVC.whereComeIn = 0;//从首页找服务进入的
                detailVC.selectTitle = [[worktypeArray objectAtIndex:indexPath.row-1] workname];
                detailVC.service = self.service;
                detailVC.selectType = 0;
                UIViewController* viewController = (UIViewController*)[self.navigationController.childViewControllers objectAtIndex:([self.navigationController.childViewControllers indexOfObject:self]-1)];
                
                //            [[[self.navigationController.childViewControllers objectAtIndex:([self.navigationController.childViewControllers indexOfObject:self]-1)] navigationController] pushViewController:detailVC animated:YES];
                [self.navigationController popViewControllerAnimated:NO];
                [viewController.navigationController pushViewController:detailVC animated:YES];
            }
        }else if(indexPath.section == 3){
            if (indexPath.row == 0) {
                Home_ServiceDetailSelectVC* selectVc = [[Home_ServiceDetailSelectVC alloc]init];
                selectVc.title = @"评价";
                selectVc.service = service;
                selectVc.selectType = selectType;
                [self.navigationController pushViewController:selectVc animated:YES];
            }
        }
    }
    */
    
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
