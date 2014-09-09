//
//  Ty_OrderVC_NewEmployeeController.m
//  腾云家务
//
//  Created by lgs on 14-7-15.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_NewEmployeeController.h"
#import "CustomDatePicker.h"//时间滚轮

#import "MyShopCell.h"
#import "Ty_OrderVC_NewEM_QuoteCell.h"
#import "Ty_News_Busine_HandlePlist.h"
#import "Ty_OrderVC_NewEM_SurveyCell.h"
#import "Ty_OrderVC_NewEm_ServiceCell.h"

#define MAXLENGTH 8
#define phoneNumbers @"1234567890\n"


@interface Ty_OrderVC_NewEmployeeController ()

@end

@implementation Ty_OrderVC_NewEmployeeController

@synthesize workGuid;
@synthesize workName;
@synthesize companyNewObject;
@synthesize tip;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addNotificationForName:@"Ty_OrderVC_NewEmployeeController"];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self setNavigationBarHidden:NO animated:NO];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
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
    
    [self getTip];
    
    my_AddemployeeModel = [[My_AddEmployeeModel alloc]init];
    newEmployeeBusine = [[Ty_News_Busine_Network alloc]init];
    newEmployeeBusine.delegate = self;
    

    postSalary = @"0";
}

#pragma mark - 添加员工
-(void)but_add_ok:(UIButton *)but
{
    if (my_AddemployeeModel.userPhoto==nil)
    {
        [self alertViewTitle:@"提示" message:@"请您上传头像"];
    }
    else if (ISNULLSTR(companyNewObject.userRealName))
    {
        
        [self alertViewTitle:@"提示" message:@"请输入姓名"];
        
    }else if(ISNULLSTR(companyNewObject.idCard)){
        
        [self alertViewTitle:@"提示" message:@"请输身份证号"];
        
    }else if(ISNULLSTR(companyNewObject.phoneNumber)){
        
        [self alertViewTitle:@"提示" message:@"请输入联系电话"];
        
    }else
    {
        [self showProgressHUD:@"正在新建"];
        
        [newEmployeeBusine workerNewEmployeeWithWorkGuid:workGuid andModel:my_AddemployeeModel andServiceModel:companyNewObject andPostSalary:postSalary andWorkName:workName];
    }
}



#pragma mark ----tableview数据源代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
    {
        return 5;
    }
    else
        return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
    {
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
                if (!ISNULLSTR(companyNewObject.userRealName)) {
                    cell.textContent.text = companyNewObject.userRealName;
                }
                break;
            case 2:
                cell.lableName.text = @"雇工性别:";
                cell.textContent.placeholder = @"请选择雇工性别";
                
                cell.selectionStyle =  UITableViewCellSelectionStyleGray;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textContent.enabled = NO;
                if (!ISNULLSTR(companyNewObject.sex)) {
                    if ([companyNewObject.sex isEqualToString:@"0"]) {
                        
                        cell.textContent.text = @"男";
                        
                    }else{
                        
                        cell.textContent.text = @"女";
                        
                    }
                }
                break;
            case 3:
                cell.lableName.text = @"身份证号:";
                cell.textContent.tag = 1003;
                cell.textContent.placeholder = @"请输入雇工身份证号(必填)";
                cell.textContent.keyboardType = UIKeyboardTypeASCIICapable;
                if (!ISNULLSTR(companyNewObject.idCard)) {
                    cell.textContent.text = companyNewObject.idCard;
                }
                break;
            case 4:
                cell.lableName.text = @"服务电话:";
                cell.textContent.tag = 1004;
                cell.textContent.placeholder = @"请输入雇工服务电话(必填)";
                cell.textContent.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                if (!ISNULLSTR(companyNewObject.phoneNumber)) {
                    cell.textContent.text = companyNewObject.phoneNumber;
                }
                break;
            default:
                break;
        }
        return cell;
    }
    else
    {
        if (indexPath.row == 0)
        {
            NSString * strID = [NSString stringWithFormat:@"service%d%d",indexPath.section,indexPath.row];
            Ty_OrderVC_NewEm_ServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
            if (cell == nil) {
                
                cell = [[Ty_OrderVC_NewEm_ServiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
            }
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;
            //界面
            if (IOS7)
            {
                cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"i_setupcellbgtop.png"]];
            }
            cell.lableName.text = @"服务项目:";
            cell.serviceName.text = workName;
            
            return cell;
        }
        else if (indexPath.row == 1)
        {
            NSString * cellidenter = [NSString stringWithFormat:@"quote"];
            Ty_OrderVC_NewEM_QuoteCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidenter];
            if (cell == nil)
            {
                cell = [[Ty_OrderVC_NewEM_QuoteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidenter];
            }
            cell.textContent.delegate = self;
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;
            cell.textContent.returnKeyType = UIReturnKeyDone;
            if (IOS7)
            {
                cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"i_setupcellbgtop.png"]];
            }
            cell.lableName.text = @"报价:";
            cell.textContent.placeholder = @"请输入报价";
            cell.textContent.tag = 1005;
            
            Ty_News_Busine_HandlePlist * tempPlistBusine = [[Ty_News_Busine_HandlePlist alloc]init];
            NSString * unitString = [NSString stringWithFormat:@"元/%@",[tempPlistBusine findWorkUnitAndWorkName:workName]];
            cell.lableMoney.text = unitString;
            cell.lableMoney.textColor = [UIColor colorWithRed:244.0/255.0 green:29.0/255.0 blue:31.0/255.0 alpha:1.0];
            cell.lableMoney.hidden = NO;
            return cell;
        }
        else
        {
            NSString * cellidenter = @"rangeCell";
            Ty_OrderVC_NewEM_SurveyCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidenter];
            if (cell == nil)
            {
                cell = [[Ty_OrderVC_NewEM_SurveyCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellidenter];
            }
            if (IOS7)
            {
                cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"i_setupcellbgtop.png"]];
            }
            cell.lableName.text = tip;
            CGSize lableSize = [cell.lableName.text sizeWithFont:FONT12_BOLDSYSTEM constrainedToSize:CGSizeMake(cell.lableName.frame.size.width, cell.lableName.frame.size.height * 2) lineBreakMode:NSLineBreakByCharWrapping];
            
            if (lableSize.height > cell.lableName.frame.size.height * 1.5)
                [cell.lableName setFrame:CGRectMake(10, cell.lableName.frame.origin.y, 300, lableSize.height)];
            else
                [cell.lableName setFrame:CGRectMake(10, 15, 300, 12)];

            cell.selectionStyle =  UITableViewCellSelectionStyleNone;

            return cell;
        }
    }
}
#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ResignFirstResponder;
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 2) {
            
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
    }
}

#pragma mark - UIActionSheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 3001) {
        if (buttonIndex == 0) {
            companyNewObject.sex = @"0";
            [_tableView reloadData];
        }else if (buttonIndex == 1){
            companyNewObject.sex = @"1";
            
            [_tableView reloadData];
        }else{
            
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
    if (picker.view.tag == 3000) {
        
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        my_AddemployeeModel.userPhoto = image;
        my_AddemployeeModel.userSmallPhoto = image;
        
        [_tableView reloadData];
    }
}

#pragma marik - UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    ResignFirstResponder;
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{//string就是此时输入的那个字符 textField就是此时正在输入的那个输入框 返回YES就是可以改变输入框的值 NO相反
    NSCharacterSet * cs;
    if ([string isEqualToString:@"\n"])//按会车可以改变
    {
        return NO;
    }
    if (textField.tag == 1005)
    {
        if (range.location == 0)
        {
            if ([string isEqualToString:@"0"])
            {
                return NO;
            }
        }
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
        if ([toBeString length] > MAXLENGTH)
        {
            textField.text = [toBeString substringToIndex:MAXLENGTH];
            return NO;
        }
        cs = [[NSCharacterSet characterSetWithCharactersInString:phoneNumbers]invertedSet];
        NSString * filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
        BOOL canChange = [string isEqualToString:filtered];
        if (canChange == YES)
        {
            return YES;;
        }
        else
            return NO;
    }
    else
        return YES;
}
//将要完成编辑时
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1001:{
            
                companyNewObject.userRealName = textField.text;
            break;
        }
        case 1003:{
            
                companyNewObject.idCard = textField.text;
            break;
        }
        case 1004:{
            
                companyNewObject.phoneNumber = textField.text;
            break;
        }
        case 1005:
                postSalary = textField.text;
            break;
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

#pragma mark 显示的应征报价
-(void)getTip
{
    if ([workName isEqualToString:@"日常保洁"])
    {
        tip = @"根据最新市场调研,建议该项目报价范围为15～50元";
    }
    else if ([workName isEqualToString:@"空调清洗"])
    {
        tip = @"根据最新市场调研,建议该项目报价范围为80～200元";
    }
    else if ([workName isEqualToString:@"临时钟点工"])
    {
        tip = @"根据最新市场调研,建议该项目报价范围为10～40元";
    }
    else if ([workName isEqualToString:@"定期钟点工"])
    {
        tip = @"根据最新市场调研,建议该项目报价范围为1000～5000元";
    }
    else if ([workName isEqualToString:@"住家保姆"] ||[workName isEqualToString:@"看护老人"] )
    {
        tip = @"根据最新市场调研,建议该项目报价范围为3000～9000元";
    }
    else if([workName isEqualToString:@"月嫂"])
    {
        tip = @"根据最新市场调研,建议该项目报价范围为5000～15000元";
    }
    else if ([workName isEqualToString:@"育儿嫂"])
    {
        tip = @"根据最新市场调研,建议该项目报价范围为3000～9000元";
    }
    else if ([workName isEqualToString:@"入户早教"])
    {
        tip = @"根据最新市场调研,建议该项目报价范围为150～300元";
    }
}
#pragma mark - 网络_回调
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideProgressHUD];
    int number = [[[_notification object] objectForKey:@"number"] intValue];
    
    if (number == 0)
    {
        companyNewObject.userGuid = @"";
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
    }
    else if (number == 200)
    {
        [self showToastMakeToast:@"新建成功" duration:1.0 position:@"center"];
        [self.naviGationController popViewControllerAnimated:YES];
    }
    else
    {
        companyNewObject.userGuid = @"";

        [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
    }
}
#pragma mark 返回
-(void)backClick
{
    companyNewObject.userGuid = @"";
    [self.naviGationController popViewControllerAnimated:YES];
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
