//
//  Ty_MyFansView.m
//  腾云家务
//
//  Created by Xu Zhao on 14-7-2.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MyFansView.h"
#import "Ty_MyFans_Busine.h"
#import "My_FansModel.h"

@interface Ty_MyFansView ()
@end

@implementation Ty_MyFansView
@synthesize superVC;
@synthesize tableview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self addNotificationForName:@"Ty_MyFansView"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //获取关注数据
    self.title = @"我的粉丝";
    
    //搜索框
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    search.delegate = self;
    [search setPlaceholder:@"搜索"];
    [search setKeyboardType:UIKeyboardTypeDefault];
    search.layer.borderColor = (__bridge CGColorRef)([UIColor grayColor]);
    search.layer.borderWidth = 1;
    [search setBackgroundImage:[UIImage imageNamed:@"Contact_searchbar.png"]];
    [self.view addSubview:search];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    /*searchController=[[UISearchDisplayController alloc]initWithSearchBar:search contentsController:self];
    searchController.searchResultsDataSource=self;
    searchController.searchResultsDelegate=self;
    searchController.delegate=self;*/
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(15, 44, SCREEN_WIDTH - 15, SCREEN_HEIGHT-20-44-44-49) style:UITableViewStylePlain];
    [tableview setBackgroundColor:view_BackGroudColor];
    tableview.backgroundView = nil;
    tableview.dataSource=self;
    tableview.delegate=self;
    //[tableview setTableHeaderView:search];
    [self.view addSubview:tableview];
    
    [[Ty_MyFans_Busine share_Busine_DataBase]freshData];//刷新单例里面的数组
    [[Ty_MyFans_Busine share_Busine_DataBase] getMyFansFromSqlWithSearch:@""];
    [[Ty_MyFans_Busine share_Busine_DataBase] getMyFansFromNetwork];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [search resignFirstResponder];
    self.imageView_background.hidden = NO;
}


#pragma mark - tableview的数据代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [[Ty_MyFans_Busine share_Busine_DataBase] arrSection].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section+1 != [Ty_MyFans_Busine share_Busine_DataBase].arrSectionNum.count)
        return [[[Ty_MyFans_Busine share_Busine_DataBase].arrSectionNum objectAtIndex:section+1]intValue]-[[[Ty_MyFans_Busine share_Busine_DataBase].arrSectionNum objectAtIndex:section]intValue];
    else
        return [Ty_MyFans_Busine share_Busine_DataBase].arrFans.count-[[[Ty_MyFans_Busine share_Busine_DataBase].arrSectionNum objectAtIndex:section]intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"cell";
    Ty_MyFunsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[Ty_MyFunsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellone"];
    }
    
    int position = [[[Ty_MyFans_Busine share_Busine_DataBase].arrSectionNum objectAtIndex:indexPath.section]intValue]+indexPath.row;
    
    NSString *strUserPhoto = [[NSString alloc]init];
    NSString *strUserShowName = [[NSString alloc]init];
    NSString *strUserType = [[NSString alloc]init];
    
    My_FansModel * tempFansModel = [[My_FansModel alloc]init];
    tempFansModel = [[Ty_MyFans_Busine share_Busine_DataBase].arrFans objectAtIndex:position];
    
    if([[tempFansModel strUserType] isEqualToString:@"0"])//中介
    {
        strUserPhoto = @"Contact_image2.png";
        strUserShowName = [tempFansModel strIntermediaryName];
        strUserType = @"商户";
    }
    else
    {
        if([[tempFansModel strUserType] isEqualToString:@"1"])//中介下短工
        {
            strUserShowName = [tempFansModel strUserRealName];
            strUserType = [tempFansModel strUserCompany];
        }
        else
        {
            strUserShowName = [tempFansModel strUserRealName];
            strUserType = @"个人";
        }
        
        if([[tempFansModel strUserSex] isEqualToString:@"0"])//男
        {
            strUserPhoto = @"Contact_image1.png";
        }
        else
            strUserPhoto = @"Contact_image.png";
    }
    
    cell.strUserPhoto = strUserPhoto;
    if([[tempFansModel strUserPhoto] isEqualToString:@""])
    {
        cell.strUserPhoto = strUserPhoto;
        [cell.imageHView setImage:[UIImage imageNamed:strUserPhoto]];
    }
    else
    {
        cell.strUserPhoto = strUserPhoto;
        [cell.imageHView setImageWithURL:[NSURL URLWithString:[tempFansModel strUserPhoto]] placeholderImage:cell.imageH];
    }
    
    CGSize labelSize = [strUserShowName sizeWithFont:FONT15_BOLDSYSTEM constrainedToSize:CGSizeMake(185, 400) lineBreakMode:NSLineBreakByCharWrapping];
    [cell.labName setFrame:CGRectMake(65, 15, labelSize.width, 20)];
    [cell.labName setText:strUserShowName];
    
    CGSize labelTypeSize = [strUserType sizeWithFont:FONT12_BOLDSYSTEM constrainedToSize:CGSizeMake(185, 400) lineBreakMode:NSLineBreakByCharWrapping];
    [cell.labType setFrame:CGRectMake(65+6+labelSize.width, 8, labelTypeSize.width+2, 16)];
    [cell.labType setText:strUserType];
    
    [cell.labWork setText:@""];
    NSArray *arrUserPost = [[NSArray alloc]initWithArray:[[tempFansModel strUserPost] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]]];
    for(int i=0;i<arrUserPost.count;i++)
    {
        [cell.labWork setText:[NSString stringWithFormat:@"%@ %@",cell.labWork.text,[arrUserPost objectAtIndex:i]]];
    }
    
    [cell.btnMessage setTag:position];
    NSLog(@"btnMessageTag=%d",position);
    [cell.btnMessage addTarget:self action:@selector(message:) forControlEvents:UIControlEventTouchDown];
    
    tempFansModel = nil;

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
#pragma mark---tableview的delegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:view_BackGroudColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [Ty_MyFans_Busine share_Busine_DataBase].arrSection;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc]init];
    
    //imageH = [UIImage imageNamed:@"Contact_personHeader@2x.png"];
    UIImageView *imageHView=[[UIImageView alloc] init];
    [imageHView setBackgroundColor:[UIColor colorWithRed:199.0/255 green:199.0/255 blue:199.0/255 alpha:1.0]];
    [imageHView setFrame:CGRectMake(0, 0, SCREEN_WIDTH - 20, 25)];
    [viewHeader addSubview:imageHView];
    
    UILabel *labTitle = [[UILabel alloc]initWithFrame:CGRectMake(12.5, 0, 100, 25)];
    [labTitle setBackgroundColor:[UIColor clearColor]];
    [labTitle setText:[[Ty_MyFans_Busine share_Busine_DataBase].arrSection objectAtIndex:section]];
    [labTitle setTextColor:[UIColor whiteColor]];
    [labTitle setFont:FONT15_SYSTEM];
    [labTitle setShadowColor:[UIColor blackColor]];
    [labTitle setShadowOffset:CGSizeMake(0.3, 0.5)];
    [viewHeader addSubview:labTitle];
    
    return viewHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableview deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)message:(UIButton *)_sender
{
    MessageVC *message = [[MessageVC alloc]init];
    
    My_FansModel * tempFansModel = [[My_FansModel alloc]init];
    tempFansModel = [[Ty_MyFans_Busine share_Busine_DataBase].arrFans objectAtIndex:_sender.tag];

    
    if([[tempFansModel strUserType] isEqualToString:@"0"])//中介
    {
        message.contactGuid = [tempFansModel strFansGuid];
        message.contactName = [tempFansModel strUserName];
        message.contactRealName = [tempFansModel strIntermediaryName];
        message.contactAnnear = [tempFansModel strUserAnnear];
        message.contactType = 0;
    }
    else
    {
        message.contactGuid = [tempFansModel strFansGuid];
        message.contactName = [tempFansModel strUserName];
        message.contactRealName = [tempFansModel strUserRealName];
        message.contactAnnear = [tempFansModel strUserAnnear];
        message.contactType = 1;
        message.contactSex = [[tempFansModel strUserSex] intValue];
    }
    [self.naviGationController pushViewController:message animated:YES];
}

#pragma mark 搜索框
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.imageView_background setHidden:YES];
    
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)hsearchBar
{
    [self.view bringSubviewToFront:search];
    search.showsCancelButton = YES;
    for(id cc in [search subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
    
    search.hidden = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    searchBar.showsCancelButton=NO;

    [searchBar resignFirstResponder];
    [self.imageView_background setHidden:NO];
    
    searchBar.text = @"";
    [[Ty_MyFans_Busine share_Busine_DataBase] getMyFansFromSqlWithSearch:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton=YES;
    
    [self.imageView_background setHidden:NO];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([[Ty_MyFans_Busine share_Busine_DataBase] getMyFansFromSqlWithSearch:[NSString stringWithFormat:@"and (CONTACTDATA_USER_REALNAME like '%%%@' or CONTACTDATA_USER_REALNAME like '%@%%' or CONTACTDATA_USER_REALNAME like '%%%@%%' or CONTACTDATA_USER_SPELL like '%%%@' or CONTACTDATA_USER_SPELL like '%@%%' or CONTACTDATA_USER_SPELL like '%%%@%%' or CONTACTDATA_INTERMEDIARY_NAME like '%%%@' or CONTACTDATA_INTERMEDIARY_NAME like '%@%%' or CONTACTDATA_INTERMEDIARY_NAME like '%%%@%%')",searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText]])
    {
        [self.tableview reloadData];
    }
}
#pragma mark 网络回调
-(void)netRequestReceived:(NSNotification *)_notification
{
    int number = [[[_notification object] objectForKey:@"number"] intValue];
    
    if (number == 0)
    {
        [self showToastMakeToast:@"网络请求失败" duration:1.0 position:@"center"];
    }
    else if (number == 200)
    {
        [self showToastMakeToast:@"粉丝已经更新" duration:1.0 position:@"top"];
        [self.tableview reloadData];
    }
    else
    {
        
    }
}
/*- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    //searchBool = YES;
    
    //搜索本地数据
    [myFans getMyFansFromSqlWithSearch:@""];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    //searchBool = YES;
    
    [myFans getMyFansFromSqlWithSearch:[NSString stringWithFormat:@"and (CONTACTDATA_USER_REALNAME like '%%%@' or CONTACTDATA_USER_REALNAME like '%@%%' or CONTACTDATA_USER_REALNAME like '%%%@%%' or CONTACTDATA_USER_SPELL like '%%%@' or CONTACTDATA_USER_SPELL like '%@%%' or CONTACTDATA_USER_SPELL like '%%%@%%' or CONTACTDATA_INTERMEDIARY_NAME like '%%%@' or CONTACTDATA_INTERMEDIARY_NAME like '%@%%' or CONTACTDATA_INTERMEDIARY_NAME like '%%%@%%')",searchString,searchString,searchString,searchString,searchString,searchString,searchString,searchString,searchString]];
    
    return YES;
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
