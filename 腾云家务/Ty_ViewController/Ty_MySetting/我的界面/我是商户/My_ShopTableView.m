//
//  My_ShopTableView.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/30.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_ShopTableView.h"
#import "MyShopSettingCell.h"
#import "My_SetUpViewController.h"//设置
#import "Ty_OrderVC_MySetting_Master.h"
#import "My_ShopInformationViewController.h"//商户信息
#import "My_AccountVC.h"//账户金额
#import "My_ShopManageViewController.h"
#import "MyShopAddSkillViewController.h"//商户服务项目
#import "Ty_MyFansView.h"//我的粉丝
#import "Ty_OrderVC_MySetting_Worker.h"
#import "My_ShopCouponVC.h"//商户优惠券
@implementation My_ShopTableView
@synthesize my_setUpadteModel;
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];

    if (self) {
        // Initialization code
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = view_BackGroudColor;
        self.backgroundView = nil;
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    if (section == 2) {
        return 5;
    }
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * tableViewCell = [NSString stringWithFormat:@"EmployerCell%d%d",indexPath.section,indexPath.row];
    MyShopSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    if (cell == Nil) {
        cell = [[MyShopSettingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tableViewCell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
    cell.button_have.hidden = YES;
    cell.button_wait.hidden = YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;//点击无效果
            cell.button_have.hidden = NO;
            cell.button_wait.hidden = NO;
            cell.viewxian.hidden = NO;
            
            [cell.button_wait setTitle:@"收到抢单" forState:UIControlStateNormal];
            [cell.button_wait addTarget:self action:@selector(hadReceivedPublishRequirement) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.button_have setTitle:@"收到预约" forState:UIControlStateNormal];
            [cell.button_have addTarget:self action:@selector(hadReceivedOrderRequirement) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryType = UITableViewCellAccessoryNone;

        }else{
            
            cell.imageView.image = JWImageName(@"i_setupxuqiuhefuwu");
            cell.textLabel.text = @"所有的需求和预约订单";
            
        }
        
    }else if(indexPath.section == 1)
    {
    
        cell.imageView.image = JWImageName(@"my_money");
        cell.textLabel.text = @"账户金额";
        cell.labelMoney.hidden = NO;
        if (!ISNULL(my_setUpadteModel.accountMoney)) {
            
            cell.labelMoney.text = my_setUpadteModel.accountMoney;
        }
        
    }else if(indexPath.section == 2){
        
        switch (indexPath.row) {
            
            case 0:
                
                cell.imageView.image = JWImageName(@"i_setupfuwuxinxi");
                cell.textLabel.text = @"我的商户信息";
                cell.checkState.hidden = NO;
                switch ([my_setUpadteModel.checkState intValue]) {
                    case 1:
                        [cell.checkState setTitle:@"未审核" forState:UIControlStateNormal];
                        [cell.checkState setBackgroundImage:JWImageName(@"my_checkState1") forState:UIControlStateNormal];
                        break;
                    case 2:
                        [cell.checkState setTitle:@"审核中" forState:UIControlStateNormal];
                        [cell.checkState setBackgroundImage:JWImageName(@"my_checkState2") forState:UIControlStateNormal];
                        break;
                    case 3:
                        [cell.checkState setTitle:@"已审核" forState:UIControlStateNormal];
                        [cell.checkState setBackgroundImage:JWImageName(@"my_checkState3") forState:UIControlStateNormal];
                        break;
                    case 4:
                        [cell.checkState setTitle:@"未通过" forState:UIControlStateNormal];
                        [cell.checkState setBackgroundImage:JWImageName(@"my_checkState4") forState:UIControlStateNormal];
                        break;
                    case 5:
                        [cell.checkState setTitle:@"可修改" forState:UIControlStateNormal];
                        [cell.checkState setBackgroundImage:JWImageName(@"my_checkState1") forState:UIControlStateNormal];
                        break;
                        
                    default:
                        break;
                }
      
                
                break;
            case 1:
                
                cell.imageView.image = JWImageName(@"i_setupfuwuxiangmu");
                cell.textLabel.text = @"店铺服务项目";
                break;
            case 2:
                
                cell.imageView.image = JWImageName(@"i_setupgugongxinxi");
                cell.textLabel.text = @"签约服务员管理";
                
                break;
            case 3:
 
                cell.imageView.image = JWImageName(@"i_setupshoucang");
                cell.textLabel.text = @"我的粉丝";
                
                break;
            case 4:
                
                cell.imageView.image = JWImageName(@"i_setupgugongxinxi");
                cell.textLabel.text = @"优惠券管理";
                
                break;
            default:
                break;
        }
        
    }else{
        
        cell.imageView.image = JWImageName(@"i_setupshezhi");
        cell.textLabel.text = @"设置";
        
    }
    return  cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.001)];
        
    }
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0.001;
        
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        Ty_OrderVC_MySetting_Worker * mySettingWorkerVC = [[Ty_OrderVC_MySetting_Worker alloc]init];
        mySettingWorkerVC.buttonNumber = 5;
        
        [self.ty_mySetting.naviGationController pushViewController:mySettingWorkerVC animated:YES];
    }
    else if(indexPath.section == 1)
    {
        //账户金额
        My_AccountVC *accountVC = [[My_AccountVC alloc]init];
        if (!ISNULL(my_setUpadteModel.accountMoney)) {
            
            accountVC.accountMoney = my_setUpadteModel.accountMoney;
        }
        [self.ty_mySetting.naviGationController pushViewController:accountVC animated:YES];
        accountVC = nil;
        
    }else if(indexPath.section == 2)
    {
        switch (indexPath.row) {
                
            case 0:
            {
                My_ShopInformationViewController * my_shopInf = [[My_ShopInformationViewController alloc]init];
                my_shopInf.title = @"我的商户信息";
                my_shopInf.checkState = [my_setUpadteModel checkState];
                [self.ty_mySetting.naviGationController  pushViewController:my_shopInf animated:YES];
                
                break;
            }
            case 1:
            {
                
                MyShopAddSkillViewController * myShopaddSkill = [[MyShopAddSkillViewController alloc]init];
                [self.ty_mySetting.naviGationController pushViewController:myShopaddSkill animated:YES];
                
                
                break;
            }
            case 2:
            {
                
                My_ShopManageViewController * my_manage = [[My_ShopManageViewController alloc]init];
                my_manage.title = @"签约服务员管理";
                [self.ty_mySetting.naviGationController pushViewController:my_manage animated:YES];

                break;
            }
                
                
            case 3:
            {
                Ty_MyFansView *my_fans = [[Ty_MyFansView alloc]init];
                [self.ty_mySetting.naviGationController pushViewController:my_fans animated:YES];
                
                break;
            }

            case 4:
            {
                My_ShopCouponVC * shopCoupon = [[My_ShopCouponVC alloc]init];
                shopCoupon.title = @"优惠券管理";
                [self.ty_mySetting.naviGationController pushViewController:shopCoupon animated:YES];
                break;
                
            }
            default:
                break;
        }
        
    }
    else if(indexPath.section == 3)
    {
        My_SetUpViewController * mySetUp = [[My_SetUpViewController alloc]init];
        mySetUp.title = @"设置";
        [self.ty_mySetting.naviGationController pushViewController:mySetUp animated:YES];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 70;
        }
    }
    return 44;
}

#pragma mark “收到抢单”“收到预约”的按钮点击方法
-(void)hadReceivedPublishRequirement
{
    Ty_OrderVC_MySetting_Worker * mySettingWorkerVC = [[Ty_OrderVC_MySetting_Worker alloc]init];
    mySettingWorkerVC.buttonNumber = 0;
    [self.ty_mySetting.naviGationController pushViewController:mySettingWorkerVC animated:YES];

}
-(void)hadReceivedOrderRequirement
{
    Ty_OrderVC_MySetting_Worker * mySettingWorkerVC = [[Ty_OrderVC_MySetting_Worker alloc]init];
    mySettingWorkerVC.buttonNumber = 1;
    [self.ty_mySetting.naviGationController pushViewController:mySettingWorkerVC animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
