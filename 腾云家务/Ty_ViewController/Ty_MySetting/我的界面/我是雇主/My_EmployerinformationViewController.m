//
//  My_EmployerinformationViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_EmployerinformationViewController.h"
#import "PersonageCell.h"
#import "PersonageNextViewController.h"
#import "ModifyPwdViewController.h"
#import "MyImageHandle.h"
#import "My_Employerinformation_Busine.h"
@interface My_EmployerinformationViewController ()

@end

@implementation My_EmployerinformationViewController

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
    if (IOS7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的信息";
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 20- 44 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = view_BackGroudColor;
    _tableView.backgroundView = nil;
    //    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    [self addNotificationForName:@"MyEmployerInform"];
    
}
#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 2;
            
            break;
        default:
            break;
    }
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * strCell = @"personageCell";
    PersonageCell * cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[PersonageCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strCell];
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    
    cell.imageViewHead.image = nil;
    if (indexPath.section== 0 && indexPath.row == 1) {
        cell.textLabel.text = @"头像";
        cell.detailTextLabel.text = nil;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        if (ISNULL([[NSUserDefaults standardUserDefaults]objectForKey:@"MyEmployeeHead"])) {
            
             [cell.imageViewHead setImageWithURL:[NSURL URLWithString:[MyLoginInformation objectForKey:@"smallUserPhoto"]] placeholderImage:[UIImage imageNamed:@"setup_head.png"]];
            
        }else{
        
            cell.imageViewHead.image = [UIImage imageWithContentsOfFile:[[NSUserDefaults standardUserDefaults]objectForKey:@"MyEmployeeHead"]];
            
        }
            
       
        [cell.imageViewHead setUserInteractionEnabled:YES];
        cell.imageViewHead.tag = 3100;
        [cell.imageViewHead addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageViewHeadClick:)] ];
        
    }else{
        switch (indexPath.section) {
            case 0:
                switch (indexPath.row) {
                    case 0:
                   
                        cell.textLabel.text = @"用户名";
                        
                        cell.detailTextLabel.text = [MyLoginInformation objectForKey:@"userName"];
                        
                        
                        break;
                    case 2:
                        cell.textLabel.text = @"姓名";
                        
                        cell.detailTextLabel.text = [MyLoginInformation objectForKey:@"userRealName"];
                        
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        
                        break;
                    case 3:
                        cell.textLabel.text = @"性别";
                        if ([[MyLoginInformation objectForKey:@"userSex"] isEqualToString:@"1"]) {
                            
                            cell.detailTextLabel.text = @"女";
                            
                        }else{
                            
                            cell.detailTextLabel.text = @"男";
                            
                        }
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        
                        break;
                    default:
                        break;
                }
                break;
                
            case 1:
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"家务号";
                    
                    cell.detailTextLabel.text = [MyLoginInformation objectForKey:@"userAnnear"];
                    
                    
                }else{
                    cell.textLabel.text = @"账户类型";
                    
                    
                    if ([[MyLoginInformation objectForKey:@"userType"] isEqualToString:@"0"]) {
                        cell.detailTextLabel.text = @"服务商";
                        
                    }else{
                        cell.detailTextLabel.text = @"个人用户";
                        
                    }
                    
                }
                
                break;
                
            case 2:
                
                cell.textLabel.text = @"修改密码";
                cell.detailTextLabel.text = nil;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

                break;

            default:
                break;
        }
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 1  ) {
        return 88;
    }
    return 44;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.backgroundColor = [UIColor whiteColor];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
     
                case 1:
                {
                    
                    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                                  initWithTitle:nil
                                                  delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  destructiveButtonTitle:nil
                                                  otherButtonTitles:@"相机",@"相册",nil];
                    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
                    actionSheet.tag = 2401;
                    [actionSheet showInView:self.view];
                    
                    break;
                    
                }
                case 2:
                {
                    PersonageNextViewController * next = [[PersonageNextViewController alloc]init];
                    next.strName = [MyLoginInformation objectForKey:@"userRealName"];
                    [self.naviGationController pushViewController:next animated:YES];
                    
                    break;
                }
                case 3:
                {
                    
                    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                                  initWithTitle:@"性别选择"
                                                  delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  destructiveButtonTitle:nil
                                                  otherButtonTitles:@"男",@"女",nil];
                    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
                    [actionSheet showInView:self.view];
                    break;
                }
                default:
                    break;
            }
            break;
    
        case 2:
        {
            ModifyPwdViewController * modifyPwd = [[ModifyPwdViewController alloc]init];
            [self.naviGationController pushViewController:modifyPwd animated:YES];
            break;
        }
        default:
            break;
    }

    
}

#pragma mark - UIActionSheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 2401) {
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
            [self presentModalViewController:pickerImage animated:YES];
        }
        
    }else{
        
        if (buttonIndex == 0 ) {
            
            //男
            NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
            [_dic setObject:@"0" forKey:@"userSex"];
            My_Employerinformation_Busine * my_infor_busine = [[My_Employerinformation_Busine alloc]init];
            my_infor_busine.delegate = self;
            [my_infor_busine My_EmployerinformationUserSex_Req:_dic];
            [self showLoadingInView:self.view];
        }else if(buttonIndex == 1){
            
            NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
            [_dic setObject:@"1" forKey:@"userSex"];
            My_Employerinformation_Busine * my_infor_busine = [[My_Employerinformation_Busine alloc]init];
            my_infor_busine.delegate = self;
            [my_infor_busine My_EmployerinformationUserSex_Req:_dic];
            [self showLoadingInView:self.view];
            //女
        }
    }
}

#pragma mark - UIImagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    UIImage * imageNew=[info objectForKey:UIImagePickerControllerEditedImage];
    [self setNavigationBarHidden:NO animated:NO];

    [self performSelector:@selector(selectPic:) withObject:imageNew afterDelay:0.1];
    
}
- (void)selectPic:(UIImage *)image
{

    NSString * strGuid = [[Guid share]getGuid];
   imageHView = [[UIImageView alloc] initWithImage:image];
    
    //大图片
    savePath = [MyImageHandle saveImage:[MyImageHandle imageWithImageSimple:image scaledToSize:CGSizeMake(320, 320)] WithName:@".png" type:@"Head" userGuid:strGuid];
    //小图片

    NSString * saveSmallPath = [MyImageHandle saveSmallImage:[MyImageHandle imageWithImageSimple:image scaledToSize:CGSizeMake(65, 65)] WithName:@".png" type:@"Head" userGuid:strGuid];

    NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
    [_dic setObject:savePath forKey:@"userPhoto"];
    [_dic setObject:saveSmallPath forKey:@"userSmallPhoto"];

    My_Employerinformation_Busine * my_infor_busine = [[My_Employerinformation_Busine alloc]init];
    my_infor_busine.delegate = self;
    [my_infor_busine My_EmployerImageHead_Req:_dic];
    [self showLoadingInView:self.view];
}

#pragma mark - 点击头像显示大图
-(void)ImageViewHeadClick:(UITapGestureRecognizer *)imageTap
{
    NSLog(@"imageTag==%d", imageTap.view.tag );
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    //    for (int i = 0; i < [photos count]; i++) {
    // 替换为中等尺寸图片
    
    NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [MyLoginInformation objectForKey:@"userPhoto"]];
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
    
    UIImageView * imageView = (UIImageView *)[self.view viewWithTag:imageTap.view.tag ];
    photo.srcImageView = imageView;
    [photos addObject:photo];
    //    }
    
    // 2.显示相册s
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}
#pragma mark - 修改_回调
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            [_tableView reloadData];
            [self alertViewTitle:nil message:@"修改成功！"];

        }else if ([[[_notification object] objectForKey:@"code"] isEqualToString:@"Head"]){
        
            [[NSUserDefaults standardUserDefaults]setObject:savePath forKey:@"MyEmployeeHead"];

            [_tableView reloadData];
            
        }else {
            
            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
            
        }
        
    }
    
}


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
