//
//  Ty_OrderVC_SendEmployee_Controller.m
//  腾云家务
//
//  Created by lgs on 14-7-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_SendEmployee_Controller.h"
#import "Ty_OrderVC_EmployeeCell.h"
#import "Ty_OrderVC_NewEmployeeController.h"

@interface Ty_OrderVC_SendEmployee_Controller ()

@end

@implementation Ty_OrderVC_SendEmployee_Controller
@synthesize ifHaveWishPerson;
@synthesize requirementString;
@synthesize masterWisePersonObject;
@synthesize sendEmployeeTableView;
@synthesize _isRefreshing;
@synthesize _workGuid;
@synthesize _workName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addNotificationForName:@"Ty_OrderVC_SendEmployee_Controller"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"派工";
    [self loadNewEmployeeButton];
    
    selectTag= 0;//默认是第一个
    ifNewObject = NO;
    
    self.sendEmployeeTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49) style:UITableViewStylePlain];
    [self.sendEmployeeTableView setBackgroundColor:view_BackGroudColor];
    
    sendEmployeeTableView.showsVerticalScrollIndicator = NO;//不显示滚动条
    sendEmployeeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//无分割线
    sendEmployeeTableView.dataSource = self;
    sendEmployeeTableView.delegate = self;
    
    [self.view addSubview:sendEmployeeTableView];
//    //定义上拉刷新
//    if (_refreshLoadView == nil)
//    {
//        _refreshLoadView = [[RefreshView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 40.0)];
//        _refreshLoadView._messageLabel.text = @"正在加载...";
//    }

    //实例化网络业务层
    sendEmployeeBusine = [[Ty_News_Busine_Network alloc]init];
    sendEmployeeBusine.delegate = self;
    
    [sendEmployeeBusine freshData];

    [sendEmployeeBusine workerLookEmployeesWithWorkGuid:_workGuid];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if (companyNewServiceObject != nil && ![companyNewServiceObject.userGuid isEqualToString:@""])
    {
        ifNewObject = YES;
        Ty_Model_ServiceObject * tempObject = [[Ty_Model_ServiceObject alloc]init];
        tempObject = [companyNewServiceObject copy];
        
        [sendEmployeeBusine.serviceObjectArray insertObject:tempObject atIndex:0];
        tempObject = nil;
        
        [self.sendEmployeeTableView reloadData];
        //默认选中第一个
        if (ifHaveWishPerson)
        {
            selectTag = 1;
            NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:1];
            [sendEmployeeTableView selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        }
        else
        {
            selectTag = 0;
            NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [sendEmployeeTableView selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        }
    }
    if ([sendEmployeeBusine.serviceObjectArray count] > 0 || ifHaveWishPerson)
    {
        [self loadFootView];
    }
}
#pragma mark ----tableview数据源代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (ifHaveWishPerson == YES)
    {
        return 1 + [sendEmployeeBusine.serviceObjectArray count];
    }
    else
    {
        return [sendEmployeeBusine.serviceObjectArray count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];
    
    Ty_OrderVC_EmployeeCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[Ty_OrderVC_EmployeeCell alloc]init];
        
        [cell setSelectedBackgroundView:[[UIImageView alloc]initWithImage:JWImageName(@"orderSendPerson_selectCellbackground")]];
        [cell setBackgroundView:[[UIImageView alloc]initWithImage:JWImageName(@"orderSendPerson_cellBackGround")]];
        
        if (ifHaveWishPerson == YES)
        {
            if (indexPath.section == 0)
            {
                cell.workerNameLabel.text = masterWisePersonObject.userRealName;
                cell.phoneNumberLabel.text = masterWisePersonObject.phoneNumber;
                if ([masterWisePersonObject.sex intValue] == 0)
                {
                    [cell.portraitPhotoImageView setImageWithURL:[NSURL URLWithString:masterWisePersonObject.headPhoto] placeholderImage:JWImageName(@"Contact_image1")];
                }
                else
                {
                    [cell.portraitPhotoImageView setImageWithURL:[NSURL URLWithString:masterWisePersonObject.headPhoto] placeholderImage:JWImageName(@"Contact_image")];
                }
            }
            else
            {
                cell.workerNameLabel.text = [[sendEmployeeBusine.serviceObjectArray objectAtIndex:indexPath.section -1] userRealName];
                cell.phoneNumberLabel.text =[[sendEmployeeBusine.serviceObjectArray objectAtIndex:indexPath.section -1] phoneNumber];
                if ([[[sendEmployeeBusine.serviceObjectArray objectAtIndex:indexPath.section -1] sex] intValue] == 0)
                {//男
                    NSURL * tempURL = [NSURL URLWithString:[[sendEmployeeBusine.serviceObjectArray objectAtIndex:indexPath.section -1] headPhoto]];
                    [cell.portraitPhotoImageView setImageWithURL:tempURL placeholderImage:[UIImage imageNamed:@"Contact_image1"]];
                }
                else
                {
                    NSURL * tempURL = [NSURL URLWithString:[[sendEmployeeBusine.serviceObjectArray objectAtIndex:indexPath.section -1] headPhoto]];
                    [cell.portraitPhotoImageView setImageWithURL:tempURL placeholderImage:[UIImage imageNamed:@"Contact_image"]];
                }
            }
        }
        else
        {
            cell.workerNameLabel.text = [[sendEmployeeBusine.serviceObjectArray objectAtIndex:indexPath.section] userRealName];
            cell.phoneNumberLabel.text =[[sendEmployeeBusine.serviceObjectArray objectAtIndex:indexPath.section] phoneNumber];
            if (indexPath.section == 0)
            {
                if (ifNewObject)
                {
                    NSString * fileString = [[sendEmployeeBusine.serviceObjectArray objectAtIndex:indexPath.section] headPhotoGaoQing];
                    [cell.portraitPhotoImageView setImage:[UIImage imageWithContentsOfFile:fileString]];
                }
                else
                {
                    if ([[[sendEmployeeBusine.serviceObjectArray objectAtIndex:indexPath.section] sex] intValue] == 0)
                    {//男
                        
                        NSURL * tempURL = [NSURL URLWithString:[[sendEmployeeBusine.serviceObjectArray objectAtIndex:indexPath.section] headPhoto]];
                        [cell.portraitPhotoImageView setImageWithURL:tempURL placeholderImage:[UIImage imageNamed:@"Contact_image1"]];
                    }
                    else
                    {
                        NSURL * tempURL = [NSURL URLWithString:[[sendEmployeeBusine.serviceObjectArray objectAtIndex:indexPath.section] headPhoto]];
                        [cell.portraitPhotoImageView setImageWithURL:tempURL placeholderImage:[UIImage imageNamed:@"Contact_image"]];
                    }

                }
            }
            else
            {
                if ([[[sendEmployeeBusine.serviceObjectArray objectAtIndex:indexPath.section] sex] intValue] == 0)
                {//男
                    
                    NSURL * tempURL = [NSURL URLWithString:[[sendEmployeeBusine.serviceObjectArray objectAtIndex:indexPath.section] headPhoto]];
                    [cell.portraitPhotoImageView setImageWithURL:tempURL placeholderImage:[UIImage imageNamed:@"Contact_image1"]];
                }
                else
                {
                    NSURL * tempURL = [NSURL URLWithString:[[sendEmployeeBusine.serviceObjectArray objectAtIndex:indexPath.section] headPhoto]];
                    [cell.portraitPhotoImageView setImageWithURL:tempURL placeholderImage:[UIImage imageNamed:@"Contact_image"]];
                }
            }
        }
        
        [cell.workerNameLabel setHighlightedTextColor:[UIColor redColor]];
        [cell.phoneNumberLabel setHighlightedTextColor:[UIColor redColor]];
        cell.phoneButton.tag = 2000 + indexPath.section;
        [cell.phoneButton addTarget:self action:@selector(phoneCallButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
#pragma mark ----tableView的delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor whiteColor]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (ifHaveWishPerson == YES)
    {
        if (section == 0)
        {
            return 30;
        }
        else if(section == 1)
        {
            return 20;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        if (section == 0)
        {
            return 30;
        }
        else
            return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (ifHaveWishPerson == YES)
    {
        if (section == 0)
        {
            return 20;
        }
        else
            return 0;
    }
    else
        return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * tempView  = [[UIView alloc]init];
    if (ifHaveWishPerson)
    {
        if (section == 0)
        {
            UILabel * tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 11, 150, 14)];
            tempLabel.font = FONT14_BOLDSYSTEM;
            [tempLabel setBackgroundColor:[UIColor clearColor]];
            [tempLabel setTextColor:[UIColor redColor]];
            [tempLabel setTextAlignment:NSTextAlignmentLeft];
            tempLabel.text = @"雇主意向人选:";
            [tempView addSubview:tempLabel];
        }
        else if (section == 1)
        {
            UILabel * tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 1, 100, 14)];
            tempLabel.font = FONT14_BOLDSYSTEM;

            [tempLabel setBackgroundColor:[UIColor clearColor]];
            [tempLabel setTextColor:[UIColor blackColor]];
            [tempLabel setTextAlignment:NSTextAlignmentLeft];
            tempLabel.text = @"所有人选:";
            [tempView addSubview:tempLabel];
        }
        else
        {
        }
    }
    else
    {
        if (section == 0)
        {
            UILabel * tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 14)];
            tempLabel.font = FONT14_BOLDSYSTEM;
            [tempLabel setBackgroundColor:[UIColor clearColor]];
            [tempLabel setTextColor:[UIColor blackColor]];
            [tempLabel setTextAlignment:NSTextAlignmentLeft];
            tempLabel.text = @"无意向人选,所有人选:";
            [tempView addSubview:tempLabel];
        }
    }
    
    [tempView setBackgroundColor:[UIColor clearColor]];
    return tempView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * tempView = [[UIView alloc]init];
    
    if (ifHaveWishPerson == YES)
    {
        if (section == 0)
        {
            [tempView setFrame:CGRectMake(0, 0, 320, 20)];
        }
    }
    else
    {
        [tempView setFrame:CGRectMake(0, 0, 320, 0)];
    }
    [tempView setBackgroundColor:[UIColor clearColor]];
    return tempView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectTag = indexPath.section;
    
}



#pragma mark 加载上面的创建雇工按钮
-(void)loadNewEmployeeButton
{
    [self.naviGationController.rightBarButton setImage:JWImageName(@"i_setupaddsigned") forState:UIControlStateNormal];
//    self.naviGationController.rightBarButton.imageEdgeInsets = UIEdgeInsetsMake(13, 20, 13, 22);
    [self.naviGationController.rightBarButton addTarget:self action:@selector(newEmployeeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.naviGationController.rightBarButton.showsTouchWhenHighlighted = YES;
}
#pragma mark 点击创建触发方法
-(void)newEmployeeButtonPressed
{
    companyNewServiceObject = [[Ty_Model_ServiceObject alloc]init];//商户创建的

    Ty_OrderVC_NewEmployeeController * new_Employee = [[Ty_OrderVC_NewEmployeeController alloc]init];
    new_Employee.companyNewObject = companyNewServiceObject;
    new_Employee.workName = _workName;
    new_Employee.workGuid = _workGuid;
    [self.naviGationController pushViewController:new_Employee animated:YES];
}
#pragma mark 加载底部按钮
-(void)loadFootView
{
    sureSendButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [sureSendButton setFrame:CGRectMake(110, 10, 100, 30)];
    sureSendButton.layer.cornerRadius =10;
    sureSendButton.layer.masksToBounds = YES;
    [sureSendButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutclik"] forState:UIControlStateNormal];
    [sureSendButton addTarget:self action:@selector(sureButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    sureSendButton.exclusiveTouch = YES;
    
    sureSendButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, 100, 15)];
    [sureSendButtonLabel setBackgroundColor:[UIColor clearColor]];
    sureSendButtonLabel.text = @"确定派遣";
    sureSendButtonLabel.textAlignment = NSTextAlignmentCenter;
    [sureSendButtonLabel setFont:FONT14_BOLDSYSTEM];
    sureSendButtonLabel.textColor = [UIColor whiteColor];
    [sureSendButton addSubview:sureSendButtonLabel];
    
    [self.imageView_background addSubview:sureSendButton];
}
#pragma mark 确定派工人选的button点击
-(void)sureButtonPressed
{
    [self showProgressHUD:@"正在派遣"];
    if (ifHaveWishPerson == YES)
    {
        if (selectTag == 0)
        {
            [sendEmployeeBusine workerSendEmployeeWithRequirementGuid:requirementString andEmployeeUserGuid:masterWisePersonObject.userGuid];
        }
        else
        {
            [sendEmployeeBusine workerSendEmployeeWithRequirementGuid:requirementString andEmployeeUserGuid:[[sendEmployeeBusine.serviceObjectArray objectAtIndex:selectTag -1] userGuid]];
        }
    }
    else
    {
        if ([sendEmployeeBusine.serviceObjectArray count] == 0)
        {
            [self alertViewTitle:@"提示" message:@"没有选中的员工"];
        }
        else
        {
            [sendEmployeeBusine workerSendEmployeeWithRequirementGuid:requirementString andEmployeeUserGuid:[[sendEmployeeBusine.serviceObjectArray objectAtIndex:selectTag] userGuid]];
        }
    }
}
#pragma mark 打电话按钮点击方法
-(void)phoneCallButtonPressed:(id)sender
{
    int tag = ((UIButton *)sender).tag -2000;
    
    NSLog(@"%d",ifHaveWishPerson);
    
    
    if (ifHaveWishPerson)
    {
        NSLog(@"wwwwwww");
        if (tag == 0)
        {
            NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",masterWisePersonObject.phoneNumber]];
            
            if ( !phoneCallWebView ) {
                
                phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
            }
            
            [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
        }
        else
        {
            NSString * tempStr =[NSString stringWithFormat:@"tel:%@",[[sendEmployeeBusine.serviceObjectArray objectAtIndex:tag -1] phoneNumber]];
            
            NSURL *phoneURL = [NSURL URLWithString:tempStr];
            
            if ( !phoneCallWebView )
            {
                
                phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
            }
            
            [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
        }
    }
    else
    {
        NSString * tempStr =[NSString stringWithFormat:@"tel:%@",[[sendEmployeeBusine.serviceObjectArray objectAtIndex:tag] phoneNumber]];
        
        NSURL *phoneURL = [NSURL URLWithString:tempStr];
        
        if ( !phoneCallWebView ) {
            
            phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        }
        
        [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    }
     
}
/*
#pragma mark 上拉刷新
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height  && _refreshLoadView != nil)
    {
        NSLog(@" -- 我是上拉刷新");
        if (!_isRefreshing )
        {
            [_refreshLoadView._netMind startAnimating];
            _refreshLoadView._messageLabel.text = @"正在加载...";
            _isRefreshing = YES;

            [sendEmployeeBusine workerLookEmployeesWithWorkGuid:_workGuid];
        }
    }
}
 */
#pragma mark 基类网络回调
-(void)netRequestReceived:(NSNotification *)_notification
{
    int number = [[[_notification object]objectForKey:@"number"]intValue];
    [self hideLoadingView];
    [self hideProgressHUD];

    if (number <= 2)
    {
        if ([sendEmployeeBusine.serviceObjectArray count] > 0 || ifHaveWishPerson)
        {
            [self loadFootView];
        }
        _isRefreshing = NO;
        
        if (number == 0)
        {
            [self.sendEmployeeTableView reloadData];
            if (selectTag == 0)
            {
                NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [sendEmployeeTableView selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            }
        }
        else if(number == 1)
        {
            
            [self showToastMakeToast:@"已加载全部" duration:0.5 position:@"center"];
        }
        else
        {
            [self showToastMakeToast:@"网络加载失败" duration:1 position:@"center"];
        }
    }
    else if(number <= 4)
    {
        if (number == 3)
        {
            [self showToastMakeToast:@"派遣成功" duration:2 position:@"center"];
            
            [self performSelector:@selector(sendPoptoRootViewController) withObject:nil afterDelay:2.0];
        }
        else
        {
            [self showToastMakeToast:@"派遣失败,请稍后再试" duration:1 position:@"center"];

        }
    }
    else if(number == 100)
    {//标明fail
        [self showToastMakeToast:@"网络请求失败，请重试" duration:1 position:@"center"];

    }

}
#pragma mark 返回上一个VC
-(void)sendPoptoRootViewController
{
    [self.naviGationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
