//
//  My_LoginNoView.m
//  腾云家务
//
//  Created by 艾飞 on 14-5-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_LoginNoView.h"
#import "My_LoginNoTableViewCell.h"
#import "My_LoginViewController.h"
#import "My_SetUpViewController.h"
@implementation My_LoginNoView
@synthesize ty_mySetting;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = view_BackGroudColor;
        _tableView.backgroundView = nil;
        [self addSubview:_tableView];
        
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * tableViewCell = @"LoginNocell";
    My_LoginNoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    if (cell == Nil) {
        cell = [[My_LoginNoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell];
        
    }
    if (indexPath.section == 0) {
        
        cell.imageViewHead.image = [UIImage imageNamed:@"setup_head.png"];
        cell.lableViewLogin.text = @"未登录";
        
    }else{
        
        cell.textLabel.font = FONT15_BOLDSYSTEM;
        cell.textLabel.text = @"关于软件";
        
    }
    
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 88;
        
    }else{
        return 44;
    }}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        My_LoginViewController * my_login = [[My_LoginViewController alloc]init];
        [ty_mySetting.naviGationController pushViewController:my_login animated:YES];
        
    }else{
        
        My_SetUpViewController * my_setup = [[My_SetUpViewController alloc]init];
        [ty_mySetting.naviGationController pushViewController:my_setup animated:YES];
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
