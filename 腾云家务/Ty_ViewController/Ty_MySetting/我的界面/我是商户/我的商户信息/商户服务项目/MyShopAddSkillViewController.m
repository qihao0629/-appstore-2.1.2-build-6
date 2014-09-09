//
//  MyShopAddSkillViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14-4-11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "MyShopAddSkillViewController.h"
#import "AddSkillCell.h"
#import "MyShopAddServicesViewController.h"
#import "MyShopAddJobViewController.h"//选择服务项目

@interface MyShopAddSkillViewController ()
{
    NSUInteger indxteger;
    NSIndexPath  * indexPathDelete;
}
@end

@implementation MyShopAddSkillViewController

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
    
    [self setSlidingBack:NO];
    
    array_skill = [[NSMutableArray alloc]init];
    
	// Do any additional setup after loading the view.
    self.title = @"商户服务项目编辑";
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 20- 44- 49 -20 )style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.separatorStyle = NO;
    //     _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];

    [self loadDataGetSkill];
    
}
#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return array_skill.count+1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * strID = @"myCell";
    AddSkillCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[AddSkillCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == array_skill.count ) {
        //最后一行
        cell.textLabel.text = @"+增加服务";
        cell.textLabel.textColor = [UIColor colorWithRed:3.0/255.0 green:70.0/255.0 blue:141.0/255.0 alpha:1.0];
        cell.detailTextLabel.text = @"";
        cell.lableMoney.hidden = YES;
        cell.selectionStyle =  UITableViewCellSelectionStyleGray;

        
    }else{
        
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [[array_skill objectAtIndex:indexPath.row] objectForKey:@"workName"];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.lableMoney.hidden = NO;
        cell.lableMoney.text = [NSString stringWithFormat:@"%@元/%@",[[array_skill objectAtIndex:indexPath.row] objectForKey:@"postSalary"],[WorkUnitDic objectForKey:[[array_skill objectAtIndex:indexPath.row] objectForKey:@"workName"]]];
        
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == array_skill.count) {
        //最后一行选择服务项目
        MyShopAddJobViewController * myShopjob = [[MyShopAddJobViewController alloc]init];
        myShopjob.myShopAddSkill = self;
        [self.naviGationController pushViewController:myShopjob animated:YES];
    
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [NSString stringWithFormat:@"所有服务(%d)",array_skill.count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 35;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == array_skill.count) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        indexPathDelete = indexPath;

        indxteger = indexPath.row;
        [self loadDataDeleteSkill:[[array_skill objectAtIndex:indexPath.row] objectForKey:@"workGuid"]];
        // Delete the row from the data source.
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - 删除服务项目
-(void)loadDataDeleteSkill:(NSString *)workGuid{
    
    NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
    [_dic setValue:MyLoginUserGuid forKey:@"userGuid"];
    [_dic setValue:workGuid forKey:@"workGuid"];
    [[Ty_NetRequestService shareNetWork]formRequest:My_USERSKILLDELETE andParameterDic:_dic andTarget:self andSeletor:@selector(deleteSkill:reqDic:)];
    [self showLoadingInView:self.view];
    
}

#pragma mark - 请求回调方法删除

-(void)deleteSkill:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    [self hideLoadingView];
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            [array_skill removeObjectAtIndex:indxteger];
            [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPathDelete] withRowAnimation:UITableViewRowAnimationFade];

            [_tableView reloadData];
            [self alertViewTitle:@"提示" message:@"删除成功!"];
            
        }else{
            
            [self alertViewTitle:@"提示" message:[_dic objectForKey:@"msg"]];
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        [self alertViewTitle:@"提示" message:@"网络异常，请稍后再试"];
        
    }
    
}

#pragma mark - 加载数据获取服务项目信息
-(void)loadDataGetSkill{
    
    NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
    [_dic setValue:MyLoginUserGuid forKey:@"userGuid"];
    [[Ty_NetRequestService shareNetWork]formRequest:My_USERSETSKILL andParameterDic:_dic andTarget:self andSeletor:@selector(GetSkill:reqDic:)];
    [self showLoadingInView:self.view];
}

-(void)GetSkill:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    [self hideLoadingView];

    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            [array_skill removeAllObjects];
            [array_skill addObjectsFromArray:[_dic objectForKey:@"rows"]];
            [_tableView reloadData];
            
        }else if ( [[_dic objectForKey:@"code"]intValue] == 203){
        
        
        }else{
            
            [self alertViewTitle:@"提示" message:[_dic objectForKey:@"msg"]];
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        [self alertViewTitle:@"提示" message:@"网络异常，请稍后再试"];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
