//
//  My_AddEmployeeViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14/7/9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_AddEmployeeViewController.h"
#import "MyShopCell.h"
#import "CustomDatePicker.h"//时间滚轮
#import "My_ShopManage_busine.h"//数据
#import "My_AddEducationVC.h"//学历

#import "My_AddManangeInformationViewController.h"//签约雇工信息

@interface My_AddEmployeeViewController ()

@end

@implementation My_AddEmployeeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [self setNavigationBarHidden:NO animated:NO];

}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [_tableView reloadData];
    [self setNavigationBarHidden:NO animated:NO];

}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"添加服务人员";
    //添加完成
    UIButton * but_add_ok = [UIButton buttonWithType:UIButtonTypeCustom];
    but_add_ok.frame = CGRectMake(110, 9, 100, 30);
    [but_add_ok setBackgroundImage:[UIImage imageNamed:@"i_setupbutaddok.png"] forState:UIControlStateNormal];
    [but_add_ok setTitle:@"添加雇工" forState:UIControlStateNormal];
    but_add_ok.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [but_add_ok setTitleColor:[UIColor colorWithRed:244.0/255.0 green:29.0/255.0 blue:31.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [but_add_ok addTarget:self action:@selector(but_add_ok:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageView_background addSubview:but_add_ok];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, 300,SCREEN_HEIGHT - 20- 44- 49 )style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    //    _tableView.scrollEnabled = NO;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    
    [self addNotificationForName:@"MyAddEmployee"];
    my_AddemployeeModel = [[My_AddEmployeeModel alloc]init];
    
}
#pragma mark - 滑动返回
-(void)viewWillbackAction
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                    message:@"您填写的信息将不被保存，确定返回吗？"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定",nil];
    
    [alert show];

}

#pragma mark - 重写返回方法
-(void)backClick{

    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                    message:@"您填写的信息将不被保存，确定返回吗？"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定",nil];
    
    [alert show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1) {
        
        [self.naviGationController popViewControllerAnimated:YES];

    }
}

#pragma mark - 添加员工
-(void)but_add_ok:(UIButton *)but{

    ResignFirstResponder;
    
    if (ISNULLSTR(my_AddemployeeModel.userRealName)) {
        
        [self alertViewTitle:@"提示" message:@"请输入姓名"];
        
    }else if(ISNULLSTR(my_AddemployeeModel.detailIdcard)){
        
        [self alertViewTitle:@"提示" message:@"请输身份证号"];
        
    }else if(ISNULLSTR(my_AddemployeeModel.detailPhone)){
        
        [self alertViewTitle:@"提示" message:@"请输入联系电话"];
        
    }else{
        
        ResignFirstResponder;
        [my_AddemployeeModel addAllkey_Model];
        My_ShopManage_busine * my_shopManage = [[My_ShopManage_busine alloc]init];
        my_shopManage.delegate = self;
        [my_shopManage My_AddEmployeeCode_Req:my_AddemployeeModel];
        [self showLoadingInView:self.view];
    }
    
}

#pragma mark - 网络_回调
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            My_AddManangeInformationViewController * my_addmainfor = [[My_AddManangeInformationViewController alloc]init];
            my_addmainfor.title = @"签约雇工信息";
            my_addmainfor.my_AddemployeeModel = my_AddemployeeModel;
            [self.naviGationController pushViewController:my_addmainfor animated:YES];
            
        }else {
            
            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
            
        }
        
    }
    
}


#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 11;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * strID = [NSString stringWithFormat:@"MyCellAdd%d%d",indexPath.section,indexPath.row];
    MyShopCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        
        cell = [[MyShopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
        
    }
    cell.textContent.delegate = self;
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.textContent.returnKeyType = UIReturnKeyDone;
    
    //界面
    if (IOS7) {
        
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"i_setupcellbgtop.png"]];
        
        if (indexPath.row == 10 ) {
            
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"i_setupcellbg.png"]];
            
        }
        
    }else{
        
        //非ios 7
        cell.textContent.frame = CGRectMake(90, 12, 180, 20);
        
    }
    
    
    switch (indexPath.row) {
        case 0:
            cell.lableName.text = @"雇工头像:";
            cell.textContent.placeholder = @"请上传雇工头像";
            cell.selectionStyle =  UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textContent.enabled = NO;
            if (!ISNULL(my_AddemployeeModel.userPhoto)) {
                cell.textContent.placeholder = @"";
                cell.PerfImageView.hidden = NO;
                cell.PerfImageView.image = my_AddemployeeModel.userPhoto;
            }
            
            break;
        case 1:
            cell.lableName.text = @"雇工姓名:";
            cell.textContent.placeholder = @"请输入雇工姓名(必填)";
            cell.textContent.tag = 1001;
            if (!ISNULLSTR(my_AddemployeeModel.userRealName)) {
                cell.textContent.text = my_AddemployeeModel.userRealName;
            }
            break;
        case 2:
            //编号
            cell.lableName.text = @"雇工编号:";
            cell.textContent.tag = 1002;
            cell.textContent.placeholder = @"请输入雇工编号";
            cell.textContent.keyboardType = UIKeyboardTypeASCIICapable;
            if (!ISNULLSTR(my_AddemployeeModel.detailIntermediaryUserNumber)) {
                cell.textContent.text = my_AddemployeeModel.detailIntermediaryUserNumber;
            }
            break;
            
        case 3:
            cell.lableName.text = @"身份证号:";
            cell.textContent.tag = 1003;
            cell.textContent.placeholder = @"请输入雇工身份证号(必填)";
            cell.textContent.keyboardType = UIKeyboardTypeASCIICapable;
            if (!ISNULLSTR(my_AddemployeeModel.detailIdcard)) {
                cell.textContent.text = my_AddemployeeModel.detailIdcard;
            }
            break;
        case 4:
            cell.lableName.text = @"身份证照:";
            cell.textContent.placeholder = @"请身份证正面照片";
            cell.selectionStyle =  UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textContent.enabled = NO;
            
            if (!ISNULL(my_AddemployeeModel.detailIdcardElectronic)) {
                cell.textContent.placeholder = @"";
                cell.PerfImageView.hidden = NO;
                cell.PerfImageView.image = my_AddemployeeModel.detailIdcardElectronic;
            }
            break;
            
        case 5:
            cell.lableName.text = @"服务电话:";
            cell.textContent.tag = 1004;
            cell.textContent.placeholder = @"请输入雇工服务电话(必填)";
            cell.textContent.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            if (!ISNULLSTR(my_AddemployeeModel.detailPhone)) {
                cell.textContent.text = my_AddemployeeModel.detailPhone;
            }
            break;
        case 6:
            cell.lableName.text = @"雇工性别:";
            cell.textContent.placeholder = @"请选择雇工性别";
     
            cell.selectionStyle =  UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textContent.enabled = NO;
            if (!ISNULLSTR(my_AddemployeeModel.userSex)) {
                if ([my_AddemployeeModel.userSex isEqualToString:@"0"]) {
                    
                    cell.textContent.text = @"男";

                }else{
                    
                    cell.textContent.text = @"女";
                    
                }
            }
            break;
        case 7:
            cell.lableName.text = @"雇工生日:";
            cell.textContent.placeholder = @"例如:1989-01-01";
            cell.selectionStyle =  UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textContent.enabled = NO;
            if (!ISNULLSTR(my_AddemployeeModel.userBirthday)) {
                cell.textContent.text = my_AddemployeeModel.userBirthday;
            }
            break;
            
        case 8:
            cell.lableName.text = @"最高学历:";
            cell.textContent.placeholder = @"请选择雇工最高学历";
            if (!ISNULLSTR(my_AddemployeeModel.detailRecord)) {
                cell.textContent.text = [DIC_EDUCATION objectForKey:my_AddemployeeModel.detailRecord];
            }
            cell.selectionStyle =  UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textContent.enabled = NO;
            
            break;
        case 9:
            cell.lableName.text = @"雇工籍贯:";
            cell.textContent.tag = 1005;
            cell.textContent.placeholder = @"例如 安徽合肥";
            if (!ISNULLSTR(my_AddemployeeModel.detailCensus)) {
                cell.textContent.text = my_AddemployeeModel.detailCensus;
            }
            break;
        case 10:
            cell.lableName.text = @"雇工地址:";
            cell.textContent.tag = 1006;
            cell.textContent.placeholder = @"请输入雇工所在地址";
            if (!ISNULLSTR(my_AddemployeeModel.userAddressDetail)) {
                cell.textContent.text = my_AddemployeeModel.userAddressDetail;
            }
            break;
        default:
            break;
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ResignFirstResponder;
    
    if (indexPath.row == 6) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"性别选择"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"男",@"女",nil];
        actionSheet.tag = 3001;
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        [actionSheet showInView:self.view];
        
    }
    if (indexPath.row == 4) {
        //身份证
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"相机",@"相册",nil];
        actionSheet.tag = 3002;
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        [actionSheet showInView:self.view];
    }
    if (indexPath.row == 8) {

        My_AddEducationVC * my_education = [[My_AddEducationVC alloc]init];
        my_education.title = @"学历";
        my_education.my_AddemployeeModel = my_AddemployeeModel;
        [self.naviGationController pushViewController:my_education animated:YES];
        
    }
    if (indexPath.row == 0) {
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
    
    if (indexPath.row == 7) {
        CustomDatePicker* customDatePicker=[[CustomDatePicker alloc]initWithTitle:@"选择起始日期" delegate:self];
        [customDatePicker setTag:6003];
        [customDatePicker setDatePickerMode:UIDatePickerModeDate];
        
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *currentTime = [formatter stringFromDate:[NSDate date]];
        NSDate * date = [formatter dateFromString:currentTime];
        customDatePicker.datePicker.maximumDate = date;
        
        [customDatePicker showInView:self.view];
        
    }

    
}

#pragma mark - UIActionSheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag==6003){
        CustomDatePicker *datepicker = (CustomDatePicker *)actionSheet;
        NSDateFormatter* dateformatter=[[NSDateFormatter alloc]init];
        
        if (buttonIndex==1) {
            [dateformatter setDateFormat:@"yyyy-MM-dd"];
            my_AddemployeeModel.userBirthday = [dateformatter stringFromDate:datepicker.dateNow.date];
            [_tableView reloadData];
        }
    }
    if (actionSheet.tag == 3001) {
        if (buttonIndex == 0) {
            my_AddemployeeModel.userSex = @"0";
            [_tableView reloadData];
        }else if (buttonIndex == 1){
            my_AddemployeeModel.userSex = @"1";

            [_tableView reloadData];
        }else{
            
        }
    }
    if (actionSheet.tag == 3002) {
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
            picker.view.tag = 40001;
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
            pickerImage.view.tag = 40001;
            
            [self presentModalViewController:pickerImage animated:YES];
        }
        
    }
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
    
}
#pragma mark - UIImagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    
    if (picker.view.tag == 40001) {
        
//        UIImage *image = info[UIImagePickerControllerOriginalImage];
//        PECropViewController *controller = [[PECropViewController alloc] init];
//        controller.delegate = self;
//        controller.image = image;
//        [self.navigationController pushViewController:controller animated:YES];
        
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        my_AddemployeeModel.detailIdcardElectronic = image;
        my_AddemployeeModel.smallDetailIdcardElectronic = image;
//
        [_tableView reloadData];
        
        //身份证照片处理
    }
    
    if (picker.view.tag == 3000) {
        
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        my_AddemployeeModel.userPhoto = image;
        my_AddemployeeModel.userSmallPhoto = image;
        
        [_tableView reloadData];
        
    }
    
    
}

#pragma mark - UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    ResignFirstResponder;
    return YES;
}

//将要完成编辑时
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1001:{
     
            if (!ISNULLSTR(textField.text)) {
                my_AddemployeeModel.userRealName = textField.text;
            }
        
            break;
        }
        case 1002:
        {
    
            if (!ISNULLSTR(textField.text)) {
                my_AddemployeeModel.detailIntermediaryUserNumber = textField.text;
            }
            break;
        }
            
        case 1003:{
            
            if (!ISNULLSTR(textField.text)) {
                my_AddemployeeModel.detailIdcard = textField.text;
            }
            
            break;
        }
        case 1004:{
 
            if (!ISNULLSTR(textField.text)) {
                my_AddemployeeModel.detailPhone = textField.text;
            }
            
            break;
        }
        case 1005:{
            
            if (!ISNULLSTR(textField.text)) {
                my_AddemployeeModel.detailCensus = textField.text;
            }
            
            break;
        }
        case 1006:{
            if (!ISNULLSTR(textField.text)) {
                my_AddemployeeModel.userAddressDetail = textField.text;
            }
            
            break;
        }
        default:
            break;
    }
    [_tableView reloadData];
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
