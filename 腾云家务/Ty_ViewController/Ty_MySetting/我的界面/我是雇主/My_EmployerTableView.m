//
//  My_EmployerTableView.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_EmployerTableView.h"
#import "My_EmployerTableViewCell.h"
#import "My_EmployerCouponViewController.h"//我是雇主优惠券
#import "My_SetUpViewController.h"//设置
#import "My_SetUpViewController.h"
#import "Ty_OrderVC_MySetting_Master.h"
#import "Share_MainVC.h"
#import "Ty_MyAttentionVC.h"
@implementation My_EmployerTableView

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
    if (section == 1) {
        return 3;
    }
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * tableViewCell = [NSString stringWithFormat:@"EmployerCell%d%d",indexPath.section,indexPath.row];
    My_EmployerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    if (cell == Nil) {
        cell = [[My_EmployerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;//点击无效果
            cell.button_have.hidden = NO;
            cell.button_wait.hidden = NO;
            cell.viewxian.hidden = NO;
            
            [cell.button_wait setTitle:@"已发抢单" forState:UIControlStateNormal];
            [cell.button_wait addTarget:self action:@selector(hadPublishRequirement) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.button_have setTitle:@"已发预约" forState:UIControlStateNormal];
            [cell.button_have addTarget:self action:@selector(hadOrderRequirement) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryType = UITableViewCellAccessoryNone;

        }else{
            
            cell.imageView.image = JWImageName(@"i_setupxuqiuhefuwu");
            cell.textLabel.text = @"所有的需求和预约订单";
            
        }
    }else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = JWImageName(@"i_setupshoucang");
                cell.textLabel.text = @"我的关注";
                break;
            case 1:
                cell.imageView.image = JWImageName(@"i_setup_coupon");
                cell.textLabel.text = @"我的优惠券";
                break;
                
            case 2:
                cell.imageView.image = JWImageName(@"i_setupshare");
                cell.textLabel.text = @"邀请与分享";
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.backgroundColor = [UIColor whiteColor];
    
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
        Ty_OrderVC_MySetting_Master * mySetting_MasterVC = [[Ty_OrderVC_MySetting_Master alloc]init];
        mySetting_MasterVC.buttonNumber = 4;
        
        [self.ty_mySetting.naviGationController pushViewController:mySetting_MasterVC animated:YES];
    }
    else if(indexPath.section == 1)//收藏
    {
        switch (indexPath.row) {
                
            case 0:
            {
                Ty_MyAttentionVC *myAttentionVC = [[Ty_MyAttentionVC alloc]init];
                //Ty_MyFansView *myAttentionWork = [[Ty_MyFansView alloc]init];
                [self.ty_mySetting.naviGationController pushViewController:myAttentionVC animated:YES];
                break;
            }
            case 1:
            {
                //优惠券
                My_EmployerCouponViewController * my_employercoupon = [[My_EmployerCouponViewController alloc]init];
                [self.ty_mySetting.naviGationController pushViewController:my_employercoupon animated:YES];
                break;
            }
            case 2:
            {
                //分享
                Share_MainVC* share=[[Share_MainVC alloc]init];
                share.title=@"分享与邀请";
                [self.ty_mySetting.naviGationController pushViewController:share animated:YES];
                
                break;
            }
            default:
                break;
        }
        
    }
    else if(indexPath.section == 2)
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

#pragma mark “已发抢单”“已发预约”的按钮点击方法
-(void)hadPublishRequirement
{
    Ty_OrderVC_MySetting_Master * mySetting_MasterVC = [[Ty_OrderVC_MySetting_Master alloc]init];
    mySetting_MasterVC.buttonNumber = 0;
    
    [self.ty_mySetting.naviGationController pushViewController:mySetting_MasterVC animated:YES];
}
-(void)hadOrderRequirement
{
    Ty_OrderVC_MySetting_Master * mySetting_MasterVC = [[Ty_OrderVC_MySetting_Master alloc]init];
    mySetting_MasterVC.buttonNumber = 1;
    
    [self.ty_mySetting.naviGationController pushViewController:mySetting_MasterVC animated:YES];
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
