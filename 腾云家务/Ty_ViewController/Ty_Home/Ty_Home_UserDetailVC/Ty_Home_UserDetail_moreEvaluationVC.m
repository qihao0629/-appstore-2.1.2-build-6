//
//  Ty_Home_UserDetail_moreEvaluationVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Home_UserDetail_moreEvaluationVC.h"
#import "RefreshView.h"
#import "Ty_UserDetail_evaluationCell.h"
@interface Ty_Home_UserDetail_moreEvaluationVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* tableview;
    RefreshView *_refreshLoadView;
}
@end

@implementation Ty_Home_UserDetail_moreEvaluationVC
@synthesize moreEvaluationBusine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        moreEvaluationBusine = [[Ty_Home_UserDetail_moreEvaluationBusine alloc] init];
        moreEvaluationBusine.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"评价";
    [moreEvaluationBusine.userService.evaluationArray removeAllObjects];
    
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
    
    [self loadEvaluations];
    
    // Do any additional setup after loading the view.
}
-(void)loadEvaluations
{
    if (moreEvaluationBusine.currentPage == 1) {
        [self showLoadingInView:self.view];
    }
    [moreEvaluationBusine loadEvaluationData];
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
        moreEvaluationBusine._isRefreshing = NO;
    }else if([codeStr isEqualToString:@"203"]){
        if (moreEvaluationBusine.currentPage == 1) {
            [self showMessageInView:tableview message:@"无查询结果"];
            tableview.tableFooterView = nil;
        }
        [tableview reloadData];
        if (tableview.contentSize.height>tableview.frame.size.height) {
            tableview.tableFooterView = _refreshLoadView;
        }
        moreEvaluationBusine._isRefreshing = YES;
        _refreshLoadView._messageLabel.text = @"已加载全部";
    }else if ([codeStr isEqualToString:@"202"]){
        
    }else if ([codeStr isEqualToString:@"404"]){
        
    }else if([codeStr isEqualToString:REQUESTFAIL]){
        [self showNetMessageInView:self.view];
        moreEvaluationBusine._isRefreshing = NO;
    }else{
        
    }
    [_refreshLoadView._netMind stopAnimating];
}
-(void)loading{
    [self showLoadingInView:self.view];
    [moreEvaluationBusine loadEvaluationData];
}
#pragma mark ----上拉刷新
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Ani -- %d",_refreshLoadView._netMind.isAnimating);
    NSLog(@"ref --%d",moreEvaluationBusine._isRefreshing);
    if (scrollView.contentOffset.y >=  scrollView.contentSize.height - scrollView.bounds.size.height  && _refreshLoadView !=  nil)
    {
        NSLog(@" -- 我是上拉刷新");
        if (!moreEvaluationBusine._isRefreshing )
        {
            [_refreshLoadView._netMind startAnimating];
            _refreshLoadView._messageLabel.text = @"正在加载...";
            moreEvaluationBusine._isRefreshing = YES;
            [moreEvaluationBusine loadEvaluationData];
        }
    }
}

#pragma mark ----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return moreEvaluationBusine.userService.evaluationArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *evaluationCell = @"evaluationCell";
    Ty_UserDetail_evaluationCell* cell = [tableView dequeueReusableCellWithIdentifier:evaluationCell];
    if (cell == nil) {
        cell = [[Ty_UserDetail_evaluationCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:evaluationCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userInteractionEnabled = NO;
    cell.typeLabel.hidden = YES;
    [cell.headImage setImageWithURL:[NSURL URLWithString:[[moreEvaluationBusine.userService.evaluationArray objectAtIndex:indexPath.row] headPhoto]] placeholderImage:JWImageName(@"Contact_image")];
    [cell.customstar setCustomStarNumber:[[[moreEvaluationBusine.userService.evaluationArray objectAtIndex:indexPath.row] evaluate] floatValue]];
    if ([[[moreEvaluationBusine.userService.evaluationArray objectAtIndex:indexPath.row] quality] isEqualToString:@"null"]) {
        cell.zhiliangLabel.text = [NSString stringWithFormat:@"质量：5"];
        
    }else {
        cell.zhiliangLabel.text = [NSString stringWithFormat:@"质量：%@",[[moreEvaluationBusine.userService.evaluationArray objectAtIndex:indexPath.row] quality]];
    }
    if ([[[moreEvaluationBusine.userService.evaluationArray objectAtIndex:indexPath.row] attitude] isEqualToString:@"null"]) {
        cell.taiduLabel.text = [NSString stringWithFormat:@"态度：5"];
    }else {
        cell.taiduLabel.text = [NSString stringWithFormat:@"态度：%@",[[moreEvaluationBusine.userService.evaluationArray objectAtIndex:indexPath.row] attitude]];
    }
    if ([[[moreEvaluationBusine.userService.evaluationArray objectAtIndex:indexPath.row] speedStr] isEqualToString:@"null"]) {
        cell.suduLabel.text = [NSString stringWithFormat:@"速度：5"];
    }else {
        cell.suduLabel.text = [NSString stringWithFormat:@"速度：%@",[[moreEvaluationBusine.userService.evaluationArray objectAtIndex:indexPath.row] speedStr]];
    }
    cell.pingjiaLabel.text = [NSString stringWithFormat:@"%@",[[moreEvaluationBusine.userService.evaluationArray objectAtIndex:indexPath.row] pingjiaString]];
    [cell setHight];
    return cell;
  
}
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
    if (indexPath.row == moreEvaluationBusine.userService.evaluationArray.count-1) {
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    }else{
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
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
