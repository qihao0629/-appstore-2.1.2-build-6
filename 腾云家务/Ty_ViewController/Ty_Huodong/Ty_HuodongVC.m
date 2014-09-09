//
//  Ty_HuodongVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HuodongVC.h"
#import "My_LoginViewController.h"
#import "Ty_WebViewVC.h"
@interface Ty_HuodongVC ()
@end

@implementation Ty_HuodongVC
@synthesize tableview;

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
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.view setBackgroundColor:view_BackGroudColor];
    self.title=@"活动";
    
	arrHuodong = [[NSMutableArray alloc]init];
    
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(10, 0, 300, SCREEN_HEIGHT-20-44-49) style:UITableViewStylePlain];
    [tableview setBackgroundColor:view_BackGroudColor];
    tableview.backgroundView = nil;
    [tableview setSeparatorColor:[UIColor clearColor]];
    [tableview setShowsVerticalScrollIndicator:NO];
    tableview.dataSource=self;
    tableview.delegate=self;
    [self.view addSubview:tableview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableview:) name:@"Huodong_updateTableview" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableview_fail) name:@"Huodong_updateTableview_fail" object:nil];
    
    //获取活动数据
    huodong_Busine = [[Ty_Huodong_Busine alloc]init];
    [huodong_Busine getHuodongInfo];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)updateTableview:(NSNotification*)_notification
{
    [arrHuodong setArray:[_notification object]];
    
    [tableview reloadData];
}

-(void)updateTableview_fail
{
    [huodong_Busine getHuodongInfo];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return arrHuodong.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"cell";
    Ty_HuodongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[Ty_HuodongTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellone"];
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    }
    
    [cell.imageHV setImageWithURL:[NSURL URLWithString:[[arrHuodong objectAtIndex:indexPath.section] acPhoto]] placeholderImage:cell.imageH];
    [cell.labTitle setText:[[arrHuodong objectAtIndex:indexPath.section] acTitle]];
    [cell.labTime setText:[[arrHuodong objectAtIndex:indexPath.section] acStartTime]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:view_BackGroudColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

/*- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *arrSection = [[NSMutableArray alloc]init];
    for(int i=0;i<arrHuodong.count;i++)
        [arrSection addObject:@""];
    
    return arrSection;
}*/

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc]init];
    
    return viewHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableview deselectRowAtIndexPath:indexPath animated:YES];
    
    if(IFLOGINYES)
    {
//        Ty_HuodongMoreVC *huodongMore = [[Ty_HuodongMoreVC alloc]init];
//        huodongMore.strURL = [[arrHuodong objectAtIndex:indexPath.section] acHttpUrl];
//        [self.naviGationController pushViewController:huodongMore animated:YES];
        
        Ty_WebViewVC* webVC = [[Ty_WebViewVC alloc]init];
        webVC.url = [NSString stringWithFormat:@"%@?userGuid=%@",[[arrHuodong objectAtIndex:indexPath.section] acHttpUrl],MyLoginUserGuid];
        webVC.title = @"活动";
        [self.naviGationController pushViewController:webVC animated:YES];

    }
    else
    {
        [self loginWhenNotLogin];
    }
}

#pragma mark -- 登录跳转
- (void)loginWhenNotLogin
{
    My_LoginViewController *loginViewController = [[My_LoginViewController alloc]init];
    [self.naviGationController pushViewController:loginViewController animated:YES];
    
    loginViewController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
