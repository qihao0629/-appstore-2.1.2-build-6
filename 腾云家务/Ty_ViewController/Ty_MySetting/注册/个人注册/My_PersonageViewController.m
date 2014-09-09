//
//  My_PersonageViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_PersonageViewController.h"
#import "My_personageTableViewCell.h"
#import "My_Registered_busine.h"
#import "My_RegSucceedViewController.h"

@interface My_PersonageViewController ()

@end

@implementation My_PersonageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.button_ok.hidden = NO;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49 -20 -44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    
    [self addNotificationForName:@"MyRegistered"];

}

#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) {
//        return 1;
//    }
    if (section == 0) {
        return 2;
    }
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * strID = [NSString stringWithFormat:@"my_persongerCell%d%d",indexPath.section,indexPath.row];
    My_personageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[My_personageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
        
    }
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.text_right.delegate = self;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;

    switch (indexPath.section) {
//        case 0:
//            cell.textLabel.text = @"邀请码";
//            cell.text_right.placeholder = @"请输入邀请码";
//            cell.text_right.tag = 2400;
//            break;
            
        case 0:

            if (indexPath.row == 0){
                
                cell.textLabel.text = @"姓名";
                cell.text_right.placeholder = @"请输入姓名";
                cell.text_right.tag = 2401;

            }
            else{
                cell.textLabel.text = @"性别";
                cell.text_right.placeholder = @"请选择性别";
                [cell.text_right setEnabled: NO];
                cell.text_right.tag = 2402;
                if (!ISNULLSTR(userSex_action)) {
                    cell.text_right.text = userSex_action;
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            }
            break;
        case 1:
            if (indexPath.row == 0){
                cell.textLabel.text = @"用户名";
                cell.text_right.text = _userRealName;
                cell.text_right.enabled = NO;
                cell.selectionStyle =  UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.text_right.tag = 2403;

            }
            else if(indexPath.row == 1){
                cell.textLabel.text = @"密码";
                cell.text_right.secureTextEntry = YES;
                cell.text_right.placeholder = @"请输入密码";
                cell.text_right.tag = 2404;

            }
            else{
                cell.textLabel.text = @"确认密码";
                cell.text_right.secureTextEntry = YES;
                cell.text_right.placeholder = @"请输入确认密码";
                cell.text_right.tag = 2405;

            }
            break;
        default:
            break;
    }
    
    return cell;
    
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
    
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    if (section == 0) {
//        return @"通过邀请码注册即可获赠20元优惠券！推荐好友注册也可获得丰厚奖励！推荐越多，礼品越多！";
//    }
//    return @"";
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0 && indexPath.row == 1 ) {
        ResignFirstResponder;

        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"性别选择"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"男",@"女",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        [actionSheet showInView:self.view];
        
    }
}

#pragma mark - 完成
-(void)button_okClick{

    ResignFirstResponder;
    NSLog(@"完成");
//    UITextField * textYaoqing = (UITextField *)[self.view viewWithTag:2400];
    UITextField * textUserRealName = (UITextField *)[self.view viewWithTag:2401];
    UITextField * textSex = (UITextField *)[self.view viewWithTag:2402];
    UITextField * textName = (UITextField *)[self.view viewWithTag:2403];
    UITextField * textPwd = (UITextField *)[self.view viewWithTag:2404];
    UITextField * textPwds = (UITextField *)[self.view viewWithTag:2405];

    if (ISNULLSTR(textUserRealName.text)) {
        [self alertViewTitle:@"注册失败" message:@"请输入名字"];
        return;
    }
    if (textUserRealName.text.length > 5) {
        [self alertViewTitle:@"注册失败" message:@"请输入正确的名字"];
        return;
    }
    if (ISNULLSTR(textPwd.text) || ISNULLSTR(textPwds.text)) {
        [self alertViewTitle:@"注册失败" message:@"请输入密码"];
        return;
    }
    if (ISNULLSTR(textSex.text)) {
        [self alertViewTitle:@"注册失败" message:@"请选择性别"];
        return;
    }
    if ([textPwd.text length] < 6 || [textPwd.text length] > 16) {
        [self alertViewTitle:@"注册失败" message:@"密码不可少于6位或大于16位"];
        return;
    }
    if (![textPwd.text isEqualToString:textPwds.text]) {
        [self alertViewTitle:@"注册失败" message:@"两次密码不一致"];
        return;
    }
    NSMutableDictionary * dic_persinage = [[NSMutableDictionary alloc]init];
    [dic_persinage setObject:[[Guid share]getGuid] forKey:@"userGuid"];
    [dic_persinage setObject:@"2" forKey:@"userType"];
    [dic_persinage setObject:_userPhone forKey:@"userPhone"];
    [dic_persinage setObject:textSex.text forKey:@"userSex"];
    [dic_persinage setObject:textName.text forKey:@"userName"];
    [dic_persinage setObject:textUserRealName.text forKey:@"userRealName"];
    [dic_persinage setObject:textPwd.text forKey:@"userPassword"];
    [dic_persinage setObject:textPwds.text forKey:@"userPasswords"];
//    [dic_persinage setObject:textYaoqing.text forKey:@"userInvitationCodeReg"];

    My_Registered_busine  * my_regBusine = [[My_Registered_busine alloc]init];
    my_regBusine.delegate = self;
    [my_regBusine my_Registered_busine:dic_persinage];
    [self showLoadingInView:self.view];
}

#pragma mark - 通知回调_注册
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            UITextField * textPwd = (UITextField *)[self.view viewWithTag:2404];

            //注册成功
            My_RegSucceedViewController * my_regSucceed = [[My_RegSucceedViewController alloc]init];
            my_regSucceed.title = @"注册成功";
            my_regSucceed.userName = _userPhone;
            my_regSucceed.userPwd = textPwd.text;
            [self.naviGationController pushViewController:my_regSucceed animated:YES];
            
        }else{
            
            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];

        }
        
    }
    
    
}

#pragma mark - UIActionSheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 ) {
        userSex_action = @"男";
        [_tableView reloadData];
        
    } else if (buttonIndex == 1) {
        userSex_action = @"女";
        [_tableView reloadData];
    }
    
}

#pragma mark - UITextField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    ResignFirstResponder;
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField.tag == 2404 || textField.tag == 2405) {
        if (range.location >= 16) {
            
            return NO;
        }
    }
    return YES;
}

#pragma mark - 键盘高度通知回调

- (void)keyboardWillShow:(NSNotification *)notification{
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    _tableView.frame =CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 20 - 44 - keyboardRect.size.height);
    [UIView commitAnimations];

}

-(void)keyboardWillHide:(NSNotification *)notification{
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.2];
    _tableView.frame =CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 20- 44 - 49);
//    [UIView commitAnimations];

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
