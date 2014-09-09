//
//  Ty_Home_UserDetail_selectUsersVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-19.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Home_UserDetail_selectUsersVC.h"
#import "Ty_UserDetail_userCell.h"
#import "RefreshView.h"
#import "Ty_Model_WorkListInfo.h"

@interface Ty_Home_UserDetail_selectUsersVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* tableview;
    RefreshView *_refreshLoadView;
    Ty_Home_UserDetailType home_UserDetailType;
}

@end

@implementation Ty_Home_UserDetail_selectUsersVC
@synthesize selectUsersBusine;

Ty_Home_UserDetailType home_UserDetailTypeMain;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        selectUsersBusine = [[Ty_Home_UserDetail_selectUsersBusine alloc] init];
        selectUsersBusine.delegate = self;
    }
    return self;
}
#pragma mark ----初始化方法
-(void)Home_UserDetail:(enum Ty_Home_UserDetailType)_Ty_Home_UserDetailType
{
    home_UserDetailType = _Ty_Home_UserDetailType;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [selectUsersBusine.userService.UserArray removeAllObjects];
    
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, self.view.frame.size.height-64-49) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.delegate = self;
    tableview.dataSource = self;
    
    tableview.hidden = YES;
    
    
    UIImageView* back = [[UIImageView alloc]initWithFrame:tableview.frame];
    [back setBackgroundColor:view_BackGroudColor];
    tableview.backgroundView = back;
    
    back = nil;
    tableview.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:tableview];

    [self loadUsers];
    // Do any additional setup after loading the view.
}
-(void)loadUsers{
    if (selectUsersBusine.currentPage == 1) {
        [self showLoadingInView:self.view];
    }
    [selectUsersBusine loadUsers];
}
-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideLoadingView];
    [self hideMessageView];
    [self hideNetMessageView];
    tableview.hidden = NO;
    NSString* codeStr = [[_notification object] objectForKey:@"code"];
    if ([codeStr isEqualToString:@"200"]) {
        [tableview reloadData];
        if (tableview.contentSize.height>tableview.frame.size.height) {
            if (_refreshLoadView  ==  nil)
            {
                _refreshLoadView = [[RefreshView alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 20, 40.0)];
                _refreshLoadView._messageLabel.text = @"正在加载...";
                _refreshLoadView.backgroundColor = [UIColor clearColor];
            }
            tableview.tableFooterView = _refreshLoadView;
        }else{
            tableview.tableFooterView = nil;
            _refreshLoadView = nil;
        }
        selectUsersBusine._isRefreshing = NO;
    }else if([codeStr isEqualToString:@"203"]){
        if (selectUsersBusine.currentPage == 1) {
            [self showMessageInView:tableview message:@"无查询结果"];
            tableview.tableFooterView = nil;
        }
        [tableview reloadData];
        if (tableview.contentSize.height>tableview.frame.size.height) {
            tableview.tableFooterView = _refreshLoadView;
        }
        selectUsersBusine._isRefreshing = YES;
        _refreshLoadView._messageLabel.text = @"已加载全部";
    }else if ([codeStr isEqualToString:@"202"]){
    
    }else if ([codeStr isEqualToString:@"404"]){
    
    }else if([codeStr isEqualToString:REQUESTFAIL]){
        [self showNetMessageInView:self.view];
        selectUsersBusine._isRefreshing = NO;
    }else{
        
    }
    [_refreshLoadView._netMind stopAnimating];
}
-(void)loading{
    [self showLoadingInView:self.view];
    [selectUsersBusine loadUsers];
}
#pragma mark ----上拉刷新
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Ani -- %d",_refreshLoadView._netMind.isAnimating);
    NSLog(@"ref --%d",selectUsersBusine._isRefreshing);
    if (scrollView.contentOffset.y >=  scrollView.contentSize.height - scrollView.bounds.size.height  && _refreshLoadView !=  nil)
    {
        NSLog(@" -- 我是上拉刷新");
        if (!selectUsersBusine._isRefreshing )
        {
            [_refreshLoadView._netMind startAnimating];
            _refreshLoadView._messageLabel.text = @"正在加载...";
            selectUsersBusine._isRefreshing = YES;
            [selectUsersBusine loadUsers];
        }
    }
}

#pragma mark ----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return selectUsersBusine.userService.UserArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* Cell = @"Cell";
    Ty_UserDetail_userCell* cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if(cell == nil){
        cell = [[Ty_UserDetail_userCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ([[[selectUsersBusine.userService.UserArray objectAtIndex:indexPath.row] sex] isEqualToString:@"0"]) {
        [cell.headImage setImageWithURL:[NSURL URLWithString:[[selectUsersBusine.userService.UserArray objectAtIndex:indexPath.row] headPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image1"]];
    }else{
        [cell.headImage setImageWithURL:[NSURL URLWithString:[[selectUsersBusine.userService.UserArray objectAtIndex:indexPath.row] headPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image"]];
    }
    [cell.customStar setCustomStarNumber:[[[selectUsersBusine.userService.UserArray objectAtIndex:indexPath.row] evaluate]floatValue]];
    if (![selectUsersBusine._selectWorkName isEqualToString:@""]&&[[[selectUsersBusine.userService.UserArray objectAtIndex:indexPath.row] workTypeArray] count]>0) {
        cell.priceLabel.text = [NSString stringWithFormat:@"%@元/%@",[[[[selectUsersBusine.userService.UserArray objectAtIndex:indexPath.row] workTypeArray] objectAtIndex:0] postSalary],[WorkUnitDic objectForKey:selectUsersBusine._selectWorkName]];
    }
    cell.nameLabel.text = [[selectUsersBusine.userService.UserArray objectAtIndex:indexPath.row] userRealName];
    if (home_UserDetailType == Ty_Home_UserDetailTypeRequirement||home_UserDetailType == Ty_Home_UserDetailTypeNone) {
        cell.yuyueButton.hidden = YES;
    }else{
        cell.yuyueButton.hidden = NO;
    }
    [cell.yuyueButton setTag:indexPath.row];
    if (home_UserDetailType == Ty_Home_UserDetailTypeSelect) {
        [cell.yuyueButton setTitle:@"选定" forState:UIControlStateNormal];
    }else{
        [cell.yuyueButton setTitle:@"预约此人" forState:UIControlStateNormal];
    }
    [cell.yuyueButton addTarget:self action:@selector(userAppointment:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark ----UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    return view;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == selectUsersBusine.userService.UserArray.count-1) {
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    }else{
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.naviGationController pushViewController:[selectUsersBusine usersDetail:indexPath.row home_DetailType:home_UserDetailType] animated:YES];
}

-(void)userAppointment:(UIButton*)sender
{
    if (home_UserDetailType == Ty_Home_UserDetailTypeSelect) {
        [selectUsersBusine selectUser:sender.tag];
        [self.naviGationController popViewControllerAnimated:YES];
    }else{
        [self.naviGationController pushViewController:[selectUsersBusine appointMentUsersAction:sender.tag] animated:YES];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark ----- Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
