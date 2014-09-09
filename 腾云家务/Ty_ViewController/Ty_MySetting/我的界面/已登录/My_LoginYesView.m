//
//  My_LoginYesView.m
//  腾云家务
//
//  Created by 艾飞 on 14-5-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_LoginYesView.h"
#import "My_EmployerinformationViewController.h"//个人，账户信息
#import "My_ShopinformationVC.h"//商户，账户信息
@implementation My_LoginYesView
@synthesize my_employer;
@synthesize my_shop;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
        viewHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 135)];
        viewHead.backgroundColor = [UIColor clearColor];
        
        UIView * viewHeadTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        viewHeadTop.backgroundColor = [UIColor colorWithPatternImage:JWImageName(@"my_settingHead")];
        [viewHead addSubview:viewHeadTop];
        //我的订单
        button_employer = [UIButton buttonWithType:UIButtonTypeCustom];
        button_employer.frame = CGRectMake(0, 100, 160, 35);
        [button_employer setUserInteractionEnabled:NO];
//        [button_employer setBackgroundImage:JWImageName(@"i_setupbut_2") forState:UIControlStateNormal];
        [button_employer setBackgroundColor:ColorRedText];
//        [button_employer setTitleColor:[UIColor colorWithRed:220.0/255.0 green:0.0/255 blue:17.0/255 alpha:1.0f] forState:UIControlStateNormal];
        button_employer.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [viewHead addSubview:button_employer];
        
        //用户头像
        imageViewHead = [[UIImageView alloc]initWithFrame:CGRectMake(22, 18, 62, 62)];
        [viewHeadTop addSubview:imageViewHead];
        
        //用户昵称
        labelName = [[UILabel alloc]initWithFrame:CGRectMake(98, 20, 200, 20)];
        labelName.backgroundColor =  [UIColor clearColor];
        labelName.font = [UIFont boldSystemFontOfSize:16.0];
        [viewHeadTop addSubview:labelName];
        
        //家务号
        labelAnnear = [[UILabel alloc]initWithFrame:CGRectMake(98, 50, 200, 20)];
        labelAnnear.backgroundColor = [UIColor clearColor];
        labelAnnear.font = [UIFont boldSystemFontOfSize:15.0];
        [viewHeadTop addSubview:labelAnnear];
        

        UIButton * buttonPersonage= [UIButton buttonWithType:UIButtonTypeCustom];
        buttonPersonage.frame = CGRectMake(0, 0, 320, 85);
        [buttonPersonage addTarget:self action:@selector(buttonPersonage:) forControlEvents:UIControlEventTouchUpInside];
        [viewHeadTop addSubview:buttonPersonage];
        
        
        my_employer = [[My_EmployerTableView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, SCREEN_HEIGHT  -49 -20 - 44 ) style:UITableViewStylePlain];
        my_employer.hidden = YES;
        [self addSubview:my_employer];
        
        my_shop = [[My_ShopTableView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, SCREEN_HEIGHT -49 -20 - 44 ) style:UITableViewStylePlain];
        my_shop.hidden = YES;
        [self addSubview:my_shop];
        
    }
    return self;
}


-(void)buttonPersonage:(UIButton *)but{
    if ([MyLoginUserType isEqualToString:@"0"]) {
        
        My_ShopinformationVC * myShopInfrom = [[My_ShopinformationVC alloc]init];
        [_ty_mySetting.naviGationController pushViewController:myShopInfrom animated:YES];
        
    }else{
        My_EmployerinformationViewController * myEmployerinform = [[My_EmployerinformationViewController alloc]init];
        [_ty_mySetting.naviGationController pushViewController:myEmployerinform animated:YES];
    }
    
}
#pragma mark - 更新信息

-(void)updateLogin{

    my_employer.ty_mySetting = self.ty_mySetting;
    my_shop.ty_mySetting = self.ty_mySetting;
    
    
    if (ISNULL([[NSUserDefaults standardUserDefaults]objectForKey:@"MyEmployeeHead"])) {
        
        [imageViewHead setImageWithURL:[NSURL URLWithString:[MyLoginInformation objectForKey:@"smallUserPhoto"]] placeholderImage:[UIImage imageNamed:@"i_setupmrheadnv.png"]];
        
    }else{
        
        imageViewHead.image = [UIImage imageWithContentsOfFile:[[NSUserDefaults standardUserDefaults]objectForKey:@"MyEmployeeHead"]];
        
    }
    
    labelAnnear.text = [NSString stringWithFormat:@"登录账号: %@",[MyLoginInformation objectForKey:@"userPhone"]];
    
    if ([[MyLoginInformation objectForKey:@"userType"]isEqualToString:@"0"]) {
    
        my_shop.hidden = NO;
        my_employer.hidden = YES;
        [button_employer setTitle:@"我的待办订单" forState:UIControlStateNormal];
//        my_employer.tableHeaderView = nil;
        my_shop.tableHeaderView = viewHead;
        if ([[MyLoginInformation objectForKey:@"detailIntermediaryName"] length] == 0) {
            
            labelName.text = @"个人信息设置";

        }else{
            
            labelName.text = [NSString stringWithFormat:@"%@",[MyLoginInformation objectForKey:@"detailIntermediaryName"]];

        }
        
        [my_shop reloadData];

    }else{
    
        my_employer.hidden = NO;
        my_shop.hidden = YES;
        [button_employer setTitle:@"我的订单" forState:UIControlStateNormal];
//        my_shop.tableHeaderView = nil;
        my_employer.tableHeaderView = viewHead;
        if ([[MyLoginInformation objectForKey:@"userRealName"] length] == 0) {
            
            labelName.text = @"个人信息设置";

        }else{
            labelName.text = [NSString stringWithFormat:@"%@",[MyLoginInformation objectForKey:@"userRealName"]];
        }
        [my_employer reloadData];
    }
    
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
