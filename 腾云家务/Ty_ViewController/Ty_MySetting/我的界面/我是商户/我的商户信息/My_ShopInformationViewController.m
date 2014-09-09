//
//  My_ShopInformationViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14/7/1.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_ShopInformationViewController.h"
#import "MyShopCell.h"
#import "My_ShopInformation_bunsine.h"
#import "CustomDatePicker.h"//时间滚轮
#import "UserAddressViewController.h"//区域
#import "EmploymentNextViewController.h"//店铺介绍
#import "MyShopAddSkillViewController.h"//服务项目
#import "My_ShopInformationModel.h"//商户信息model

@interface My_ShopInformationViewController ()
{
    My_ShopInformationModel * my_shopModel;
}
@end

@implementation My_ShopInformationViewController
@synthesize checkState;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self setNavigationBarHidden:NO animated:NO];
    [_tableView reloadData];

}
- (void)viewDidLoad
{
    [super viewDidLoad];

    my_shopModel = [[My_ShopInformationModel alloc]init];
    
  

    but_add_ok = [UIButton buttonWithType:UIButtonTypeCustom];
    but_add_ok.frame = CGRectMake(110, 9, 100, 30);
    [but_add_ok setBackgroundImage:[UIImage imageNamed:@"i_setupbutaddok.png"] forState:UIControlStateNormal];
    [but_add_ok setTitle:@"保存" forState:UIControlStateNormal];
    but_add_ok.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [but_add_ok setTitleColor:[UIColor colorWithRed:244.0/255.0 green:29.0/255.0 blue:31.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [but_add_ok addTarget:self action:@selector(but_add_ok:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageView_background addSubview:but_add_ok];
    
    //审核中 和 审核通过状态 隐藏保存按钮
    if ([checkState intValue] == 3 || [checkState intValue] == 2 ) {
        but_add_ok.hidden = YES;

    }
    //初始化导航右侧按钮
    [self.naviGationController.rightBarButton setTitle:@"提交审核" forState:UIControlStateNormal];
    [self.naviGationController.rightBarButton.titleLabel setFont:FONT15_BOLDSYSTEM];
    [self.naviGationController.rightBarButton setExclusiveTouch:YES];
    [self.naviGationController.rightBarButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.naviGationController.rightBarButton setExclusiveTouch:YES];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, 300,SCREEN_HEIGHT - 20- 44- 49 )style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    //     _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    

    [self addNotificationForName:@"MyShopInFormation"];
    
    [[My_ShopInformation_bunsine alloc]My_Shopinformation_Req];
    [self showLoadingInView:self.view];
}

#pragma mark - 商户信息 提交审核
-(void)rightButtonAction{

    [[My_ShopInformation_bunsine alloc]My_ShopsubmitCheck_Req];
    [self showLoadingInView:self.view];
    
}

#pragma mark - 网络_回调
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            [_tableView reloadData];
            
        }else if ([[[_notification object] objectForKey:@"code"]intValue] == 2434){
        
            [self alertViewTitle:@"提示" message:@"保存成功!"];
        
        }else if ([[[_notification object] objectForKey:@"code"]intValue] == 2435){
            
            [self alertViewTitle:@"提示" message:@"提交成功!"];
            
            checkState = @"2";
            
            [_tableView reloadData];
            
        }else{
            
            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
            
        }
        
    }
    
}

#pragma mark - 编辑完成
-(void)but_add_ok:(UIButton *)but{

    
    UITextField * textName = (UITextField *)[self.view viewWithTag:1001];//商户名字
    UITextField * textArea = (UITextField *)[self.view viewWithTag:1002];//商户区域
    UITextField * textAddress = (UITextField *)[self.view viewWithTag:1003];//商户地址
    UITextField * textPhone = (UITextField *)[self.view viewWithTag:1004];//商户电话
    UITextField * textRegisterTime = (UITextField *)[self.view viewWithTag:1005];//开业时间
    UITextField * textBusinessTime = (UITextField *)[self.view viewWithTag:1006];//营业时间
    UITextField * textPerson = (UITextField *)[self.view viewWithTag:1007];//负责人
    UITextField * textOtherInfo = (UITextField *)[self.view viewWithTag:1008];//店铺介绍
    
        if (ISNULLSTR(textName.text)) {
            [self alertViewTitle:@"提示" message:@"请输入店铺名称！" ];
            return;
        }
        if (ISNULLSTR(textArea.text)) {
            [self alertViewTitle:@"提示" message:@"请输入店铺所在区域！" ];
            return;
        }
        if (ISNULLSTR(textPhone.text)) {
            [self alertViewTitle:@"提示" message:@"请输入店铺联系电话！" ];
            return;
        }
        if (ISNULLSTR(textRegisterTime.text)) {
            [self alertViewTitle:@"提示" message:@"请输入店铺开业时间！"];
            return;
        }
        if (ISNULLSTR(textBusinessTime.text)) {
            [self alertViewTitle:@"提示" message:@"请输入店铺营业时间！" ];
            return;
        }
        if (ISNULLSTR(textPerson.text)) {
            [self alertViewTitle:@"提示" message:@"请输入店铺负责人！" ];
            return;
        }
        if (ISNULLSTR(textAddress.text)) {
            [self alertViewTitle:@"提示" message:@"请输入店铺地址！" ];
            return;
        }
        if (ISNULLSTR(textOtherInfo.text)) {
            [self alertViewTitle:@"提示" message:@"请输入店铺介绍！" ];
            return;
        }
    
    NSMutableDictionary * _dicShop = [[NSMutableDictionary alloc]init];
    [_dicShop setObject:textName.text forKey:@"detailIntermediaryName"];
    [_dicShop setObject:textPerson.text forKey:@"detailIntermediaryResponsiblePerson"];
    [_dicShop setObject:textArea.text forKey:@"detailIntermediaryArea"];
    [_dicShop setObject:textAddress.text forKey:@"detailIntermediaryAddress"];
    [_dicShop setObject:textPhone.text forKey:@"detailIntermediaryPhone"];
    [_dicShop setObject:textOtherInfo.text forKey:@"detailIntermediaryOtherInfo"];
    [_dicShop setObject:textRegisterTime.text forKey:@"detailIntermediaryRegisterTime"];
    [_dicShop setObject:textBusinessTime.text forKey:@"detailIntermediaryBusinessTime"];

    [[My_ShopInformation_bunsine alloc]My_ShopinformationUpdate_Req:_dicShop];
    [self showLoadingInView:self.view];
}


#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }else{
        return 2;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * tableViewCell = [NSString stringWithFormat:@"MyShopCell%d%d",indexPath.section,indexPath.row];
    MyShopCell * cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    if (cell == nil) {
        cell = [[MyShopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell];
        
    }
    cell.textContent.delegate = self;
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.textContent.returnKeyType = UIReturnKeyDone;
    cell.textContent.keyboardType = UIKeyboardTypeDefault;
    if ([checkState intValue] == 3 || [checkState intValue] == 2 ) {
        [cell setUserInteractionEnabled:NO];
    }
    //界面
    if (IOS7) {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"i_setupcellbgtop.png"]];
        
        if (indexPath.section == 0 && indexPath.row == 7) {
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"i_setupcellbg.png"]];
            
        }
        if (indexPath.section == 1 && indexPath.row == 1) {
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"i_setupcellbg.png"]];
            
        }
        if (indexPath.section == 2 && indexPath.row == 0) {
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"i_setupcellbg.png"]];
            
        }
    }else{
        //非ios 7
        cell.textContent.frame = CGRectMake(90, 12, 180, 20);
    }
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                
                cell.lableName.text = @"店铺Logo:";
                cell.textContent.placeholder = @"请上传店铺Logo";
                cell.textContent.enabled = NO;
                cell.textContent.tag = 1009;
                cell.selectionStyle =  UITableViewCellSelectionStyleGray;
                
                break;
            case 1:
                cell.lableName.text = @"店铺名称:";
                cell.textContent.placeholder = @"请输入店铺名称";
                cell.textContent.tag = 1001;
                cell.textContent.text = [MyShopInforDefaults objectForKey:@"detailIntermediaryName"];
                
                break;
            case 2:
                cell.lableName.text = @"负责人:";
                cell.textContent.placeholder = @"请输店铺入负责人";
                cell.textContent.tag = 1007;
                cell.textContent.text = [MyShopInforDefaults objectForKey:@"detailIntermediaryResponsiblePerson"];

                
                break;
            case 3:
                
                cell.lableName.text = @"所在区域:";
                cell.textContent.placeholder = @"请输入店铺所在区域";
                cell.textContent.enabled = NO;
                cell.textContent.tag = 1002;
                cell.selectionStyle =  UITableViewCellSelectionStyleGray;
                cell.textContent.text = [MyShopInforDefaults objectForKey:@"detailIntermediaryArea"];

                break;
            case 4:
                cell.lableName.text = @"详细地址:";
                cell.textContent.placeholder = @"请输入详细地址";
                cell.textContent.tag = 1003;
                cell.textContent.text = [MyShopInforDefaults objectForKey:@"detailIntermediaryAddress"];

                break;
            case 5:
                cell.lableName.text = @"联系电话:";
                cell.textContent.placeholder = @"请输入联系电话";
                cell.textContent.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                cell.textContent.tag = 1004;
                cell.textContent.text = [MyShopInforDefaults objectForKey:@"detailIntermediaryPhone"];

                break;
            case 6:
                cell.lableName.text = @"营业执照:";
                cell.textContent.placeholder = @"请上传营业执照";
                cell.textContent.enabled = NO;
                cell.textContent.tag = 1009;
                cell.selectionStyle =  UITableViewCellSelectionStyleGray;
                
                break;
            case 7:
                cell.lableName.text = @"店铺介绍:";
                cell.textContent.placeholder = @"请输入店铺介绍";
                cell.textContent.enabled = NO;
                cell.textContent.tag = 1008;
                cell.selectionStyle =  UITableViewCellSelectionStyleGray;
                cell.textContent.text = [MyShopInforDefaults objectForKey:@"detailIntermediaryOtherInfo"];

                break;
            
                
            default:
                break;
        }
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.selectionStyle =  UITableViewCellSelectionStyleGray;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textContent.enabled = NO;
                
                cell.lableName.text = @"开业时间:";
                cell.textContent.placeholder = @"例如 2014-01-01";
                cell.textContent.tag = 1005;
                cell.textContent.text = [MyShopInforDefaults objectForKey:@"detailIntermediaryRegisterTime"];

                
                break;
            case 1:
                cell.lableName.text = @"营业时间:";
                cell.textContent.placeholder = @"例如 全天8:00-18:00";
                cell.textContent.tag = 1006;
                cell.textContent.text = [MyShopInforDefaults objectForKey:@"detailIntermediaryBusinessTime"];

                
                break;
            default:
                break;
        }
    }

    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0 && indexPath.row == 0  ) {
//        return 88;
//    }
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 5)];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ResignFirstResponder;
    
    
    if(indexPath.section == 1 && indexPath.row == 0 ){
        
        CustomDatePicker* customDatePicker=[[CustomDatePicker alloc]initWithTitle:@"选择起始日期" delegate:self];
        [customDatePicker setTag:100];
        //                [customDatePicker.datePicker setMaximumDate:[self.date2 dateByAddingTimeInterval:-3600*24]];
        [customDatePicker setDatePickerMode:UIDatePickerModeDate];
        
        [customDatePicker showInView:self.view];
        
    }
    
    if (indexPath.section == 0 && indexPath.row == 3) {
        UserAddressViewController * useraddress = [[UserAddressViewController alloc]init];
        [self.naviGationController pushViewController:useraddress animated:YES];
    }
    
    if (indexPath.section == 0 && indexPath.row == 7) {
        
        EmploymentNextViewController * employment = [[EmploymentNextViewController alloc]init];
        employment.str_OtherInfo = [MyShopInforDefaults objectForKey:@"detailIntermediaryOtherInfo"];
        [self.naviGationController pushViewController:employment animated:YES];
    }
 
    if (indexPath.section == 0 && indexPath.row == 6) {
    
        //营业执照
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"相机",@"相册",nil];
        actionSheet.tag = 3000;
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        [actionSheet showInView:self.view];
    }

    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        //店铺logo
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"相机",@"相册",nil];
        actionSheet.tag = 4000;
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        [actionSheet showInView:self.view];
    }

}
#pragma mark - 选择时间
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 3000) {
        if (buttonIndex == 0 ) {
            
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
            //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
            //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.allowsEditing = YES;//设置可编辑
            picker.sourceType = sourceType;
            picker.view.tag = actionSheet.tag;
            [self presentModalViewController:picker animated:YES];//进入照相界面
            
        }else if (buttonIndex == 1){
            UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
                
            }
            pickerImage.delegate = self;
            pickerImage.allowsEditing = YES;
            pickerImage.view.tag = actionSheet.tag;
            
            [self presentModalViewController:pickerImage animated:YES];
        }
        
    }
    
    if(actionSheet.tag==100){
        CustomDatePicker *datepicker = (CustomDatePicker *)actionSheet;
        NSDateFormatter* dateformatter=[[NSDateFormatter alloc]init];
        
        if (buttonIndex==1) {
            
            [dateformatter setDateFormat:@"yyyy-MM-dd"];
            NSLog(@"%@",datepicker.dateNow.date);
            NSMutableDictionary * dicDefaults = [[NSMutableDictionary alloc]init];
            [dicDefaults setDictionary:MyShopInforDefaults];
            [dicDefaults setObject:[dateformatter stringFromDate:datepicker.dateNow.date] forKey:@"detailIntermediaryRegisterTime"];
            [[NSUserDefaults standardUserDefaults]setObject:dicDefaults forKey:@"MyShopInformation"];
            [_tableView reloadData];
            
        }else{
            
            if (IS_IPHONE_5) {
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.2];
                _tableView.center = CGPointMake(_tableView.center.x, 227.5);
                [UIView commitAnimations];
                
            }else{
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.2];
                _tableView.center = CGPointMake(_tableView.center.x,183.5);
                [UIView commitAnimations];
                
            }
            
        }
    }
    
}
#pragma mark - UIImagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    
    if (picker.view.tag == 40001) {
        
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];

    
        [_tableView reloadData];
        
        //身份证照片处理
    }

    
    
}


#pragma mark - UITextField Delegate

//将要完成编辑时
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1001:{
            NSMutableDictionary * dicDefaults = [[NSMutableDictionary alloc]init];
            [dicDefaults setDictionary:MyShopInforDefaults];
            [dicDefaults setObject:textField.text forKey:@"detailIntermediaryName"];
            [[NSUserDefaults standardUserDefaults]setObject:dicDefaults forKey:@"MyShopInformation"];
            
            my_shopModel.detailIntermediaryName = textField.text;
            
            break;
        }
        case 1007:
        {
            NSMutableDictionary * dicDefaults = [[NSMutableDictionary alloc]init];
            [dicDefaults setDictionary:MyShopInforDefaults];
            [dicDefaults setObject:textField.text forKey:@"detailIntermediaryResponsiblePerson"];
            [[NSUserDefaults standardUserDefaults]setObject:dicDefaults forKey:@"MyShopInformation"];

            my_shopModel.detailIntermediaryResponsiblePerson = textField.text;

            break;
        }
            
        case 1003:{
            
            NSMutableDictionary * dicDefaults = [[NSMutableDictionary alloc]init];
            [dicDefaults setDictionary:MyShopInforDefaults];
            [dicDefaults setObject:textField.text forKey:@"detailIntermediaryAddress"];
            [[NSUserDefaults standardUserDefaults]setObject:dicDefaults forKey:@"MyShopInformation"];
            
            my_shopModel.detailIntermediaryAddress = textField.text;

            break;
        }
        case 1004:{
            NSMutableDictionary * dicDefaults = [[NSMutableDictionary alloc]init];
            [dicDefaults setDictionary:MyShopInforDefaults];
            [dicDefaults setObject:textField.text forKey:@"detailIntermediaryPhone"];
            [[NSUserDefaults standardUserDefaults]setObject:dicDefaults forKey:@"MyShopInformation"];

            my_shopModel.detailIntermediaryPhone = textField.text;

            
            break;
        }
        case 1006:{
            NSMutableDictionary * dicDefaults = [[NSMutableDictionary alloc]init];
            [dicDefaults setDictionary:MyShopInforDefaults];
            [dicDefaults setObject:textField.text forKey:@"detailIntermediaryBusinessTime"];
            [[NSUserDefaults standardUserDefaults]setObject:dicDefaults forKey:@"MyShopInformation"];

            my_shopModel.detailIntermediaryBusinessTime = textField.text;

            
            break;
        }
        default:
            break;
    }
    
    return YES;

}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    ResignFirstResponder;
    return YES;
    
}

#pragma mark - 键盘弹出
- (void)keyboardDidShow:(NSNotification *)notification{

    NSDictionary *info = [notification userInfo];
    
    NSValue   *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.25];
    _tableView.frame = CGRectMake(10, 0, 300,SCREEN_HEIGHT - 20- 44- 49 - keyboardSize.height);//底部导航
    [UIView commitAnimations];
}

#pragma mark - 键盘落下
- (void)keyboardWillHide:(NSNotification *)notification{
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.25];
    _tableView.frame = CGRectMake(10, 0, 300,SCREEN_HEIGHT - 20- 44- 49 );//底部导航
    imageView_background.frame = CGRectMake(0, SCREEN_HEIGHT- 20 - 44 -49, SCREEN_WIDTH, 49);//底部导航

    [UIView commitAnimations];
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
