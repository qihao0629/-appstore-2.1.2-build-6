//
//  My_ShopManageViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14/7/9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_ShopManageViewController.h"
#import "SignedCell.h"
#import "My_ShopManage_busine.h"
#import "My_AddEmployeeViewController.h"//添加员工

@interface My_ShopManageViewController ()

@end

@implementation My_ShopManageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{

    [self My_ShopManageReq];
    reqint = 1;
    [super viewWillAppear:animated];
  
}
#pragma mark - 第一次网络请求
-(void)My_ShopManageReq{
    
    
    My_ShopManage_busine * my_shopManage =  [[My_ShopManage_busine alloc]init];
    my_shopManage.delegate = self;
    [my_shopManage My_ShopManage_Req:@"1"];
    [self showLoadingInView:self.view];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSlidingBack:NO];//关闭滑动返回
    
    array_singend = [[NSMutableArray alloc]init];
    
    //初始化导航右侧按钮
    [self.naviGationController.rightBarButton setImage:JWImageName(@"i_setupaddsigned") forState:UIControlStateNormal];
    [self.naviGationController.rightBarButton.titleLabel setFont:FONT15_BOLDSYSTEM];
    [self.naviGationController.rightBarButton setExclusiveTouch:YES];
    [self.naviGationController.rightBarButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    self.naviGationController.rightBarButton.imageEdgeInsets = UIEdgeInsetsMake(13, 25, 13, 22);

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH ,SCREEN_HEIGHT - 20- 44- 49 )style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.backgroundView = nil;
    _tableView.hidden = YES;
    [self.view addSubview:_tableView];

    [self addNotificationForName:@"MyShopManageReq"];
    
//    [self My_ShopManageReq];
    
    if (_refreshView == nil)
    {
        reqint = 1;
        isSingend = NO;
        _refreshView = [[RefreshView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 40.0)];
        _refreshView._messageLabel.text = @"正在加载...";
        
    }

}

#pragma mark - 添加新员工
-(void)rightButtonAction{

    My_AddEmployeeViewController * my_addemplore = [[My_AddEmployeeViewController alloc]init];
    [self.naviGationController pushViewController:my_addemplore animated:YES];
    
}

#pragma mark - 上拉加载显示
-(void)loadTableViewFootView
{
    if (_tableView.contentSize.height >= _tableView.bounds.size.height)
    {
        _tableView.tableFooterView = _refreshView;
    }
}


#pragma mark - 网络_回调
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        if (reqint == 1) {
            [self showNetMessageInView:self.view];
        }
        [self alertViewTitle:nil message:@"网络连接暂时不可用，请稍后再试"];
        _isRefreshing = NO;
        [_refreshView._netMind stopAnimating];
        
    }else {
        
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            [self hideMessageView];
            _tableView.hidden = NO;
            if (reqint == 1) {
                [array_singend removeAllObjects];
            }
            [array_singend  addObjectsFromArray: [[_notification object] objectForKey:@"arrayManage"]];
            
            [_tableView reloadData];
            
            if ([[[_notification object] objectForKey:@"arrayManage"] count] == 10) {
                
                [self loadTableViewFootView];
                
            }

        }else if ([[[_notification object] objectForKey:@"code"]intValue] == 203){
            [self hideMessageView];

            //没有数据处理
            isSingend = YES;
        
            _refreshView._messageLabel.text = @"已加载全部";
            _isRefreshing = NO;
            [self loadTableViewFootView];
            [_tableView reloadData];
            [_refreshView._netMind stopAnimating];

            
        }else{
            if (reqint == 1) {
                [self showNetMessageInView:self.view];
            }
            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
            _isRefreshing = NO;
            [_refreshView._netMind stopAnimating];
        }
        
    }
    
}
#pragma mark - 重新加载
-(void)loading{
    
    [self My_ShopManageReq];


}
#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [array_singend count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * strID = @"emoloyCell";
    SignedCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[SignedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = @"";
    
    cell.labelName.text = [[array_singend objectAtIndex:indexPath.row] objectForKey:@"userRealName"];
    
    cell.labelPhone.text = [NSString stringWithFormat:@"电话:%@",[[array_singend objectAtIndex:indexPath.row] objectForKey:@"detailPhone"]];
    [cell.imageHead setImageWithURL:[NSURL URLWithString:[[array_singend objectAtIndex:indexPath.row] objectForKey:@"userPhoto"]] placeholderImage:[UIImage imageNamed:@"i_setupmrheadnv.png"]];
    [cell.imageHead setUserInteractionEnabled:YES];
    cell.imageHead.tag = 1000 + indexPath.row;
    [cell.imageHead addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageViewHeadClick:)] ];
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    EmployeeDetailedViewController * serviceDetailed = [[EmployeeDetailedViewController alloc]init];
//    serviceDetailed.dic_user = [array_singend objectAtIndex:indexPath.row];
//    serviceDetailed.signedView = self;
//    [self.navigationController pushViewController:serviceDetailed animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source.
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.bounds.size.height)  && _refreshView != nil)
    {
        NSLog(@"lgs -- 我是上拉刷新");
        if (isSingend == NO) {
            
            if (!_refreshView._netMind.isAnimating && !_isRefreshing)
            {
                _refreshView._messageLabel.text = @"正在加载...";
                reqint = reqint + 1;
                NSString * strRow = [NSString stringWithFormat:@"%d",reqint ];
                My_ShopManage_busine * my_shopManage =  [[My_ShopManage_busine alloc]init];
                my_shopManage.delegate = self;
                [my_shopManage My_ShopManage_Req:strRow];

            }
            
        }
        
    }
}

#pragma mark - 点击图片
-(void)ImageViewHeadClick:(UITapGestureRecognizer *)imageTap{

    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    //    for (int i = 0; i < [photos count]; i++) {
    // 替换为中等尺寸图片
    
    NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [[array_singend objectAtIndex:imageTap.view.tag -1000] objectForKey:@"bigUserPhoto"]];
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
