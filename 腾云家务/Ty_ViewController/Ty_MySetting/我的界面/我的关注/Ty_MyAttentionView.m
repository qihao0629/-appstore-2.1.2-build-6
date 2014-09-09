//
//  Ty_MyAttentionView.m
//  腾云家务
//
//  Created by Xu Zhao on 14-6-17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MyAttentionView.h"

@implementation Ty_MyAttentionView
@synthesize superVC;
@synthesize tableview;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self viewDidLoad];
    }
    return self;
}

-(void)viewDidLoad
{
    workBool = NO;
    searchBool = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableview) name:@"MyAttention_updateTableview" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableview_fail) name:@"MyAttention_updateTableview_fail" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchWithWork:) name:@"searchWithWork" object:nil];
    
    //获取关注数据
    myAttention = [[Ty_MyAttention_Busine alloc]init];
    
    //navigation
    UILabel *labNavigation;
    UIColor *colorNavigation;
    if (IOS7) {
        labNavigation = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        colorNavigation = [UIColor colorWithPatternImage:[UIImage imageNamed:@"titleBar.png"]];
    }else{
        labNavigation = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        colorNavigation = [UIColor colorWithPatternImage:[UIImage imageNamed:@"titleBar1.png"]];
    }
    [labNavigation setBackgroundColor:colorNavigation];
    [labNavigation setText:@"我的关注"];
    [labNavigation setTextColor:[UIColor whiteColor]];
    [labNavigation setFont:FONT20_BOLDSYSTEM];
    [labNavigation setUserInteractionEnabled:YES];
    [labNavigation setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:labNavigation];
    
    btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft setFrame:CGRectMake(15, 7, 27, 30)];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"Contact_search.png"] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(allWork) forControlEvents:UIControlEventTouchDown];
    [labNavigation addSubview:btnLeft];
    
    //搜索框
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 44, 320, 44)];
    search.delegate = self;
    [search setPlaceholder:@"搜索"];
    [search setKeyboardType:UIKeyboardTypeDefault];
    search.layer.borderColor = (__bridge CGColorRef)([UIColor grayColor]);
    search.layer.borderWidth = 1;
    [search setBackgroundImage:[UIImage imageNamed:@"Contact_searchbar.png"]];
    [self addSubview:search];
    
    /*searchController=[[UISearchDisplayController alloc]initWithSearchBar:search contentsController:superVC];
    searchController.searchResultsDataSource=self;
    searchController.searchResultsDelegate=self;
    searchController.delegate=self;*/
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 44+44, SCREEN_WIDTH, SCREEN_HEIGHT-20-44-44-49) style:UITableViewStylePlain];
    [tableview setBackgroundColor:view_BackGroudColor];
    tableview.backgroundView = nil;
    tableview.dataSource=self;
    tableview.delegate=self;
    //[tableview setTableHeaderView:search];
    [self addSubview:tableview];
    
    //tableBar
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-20-49, SCREEN_WIDTH, 49)];
    imageV.image = [UIImage imageNamed:@"footViewImage"];
    [imageV setUserInteractionEnabled:YES];
    [self addSubview:imageV];
    
    //返回
    UIButton *button_back = [UIButton buttonWithType:UIButtonTypeCustom];
    button_back.frame = CGRectMake(0, 0, 49, 49);
    [button_back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button_back addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [imageV addSubview:button_back];
    
    [myAttention getMyAttentionFromSqlWithSearch:@""];
    [myAttention getMyAttentionFromNetwork];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [superVC viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)goback
{
    [TYNAVIGATION popViewControllerWithAnimation:YES];
}

-(void)updateTableview//:(NSNotification*)_notification
{
    [tableview reloadData];
}

-(void)updateTableview_fail
{
    [myAttention getMyAttentionFromNetwork];
}

-(void)searchWithWork:(NSNotification*)_notification
{
    [myAttention getMyAttentionFromSqlWithSearch:[_notification object]];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return myAttention.arrSection.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section+1 != myAttention.arrSectionNum.count)
        return [[myAttention.arrSectionNum objectAtIndex:section+1]intValue]-[[myAttention.arrSectionNum objectAtIndex:section]intValue];
    else
        return myAttention.arrAttention.count-[[myAttention.arrSectionNum objectAtIndex:section]intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"cell";
    Ty_MyAttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[Ty_MyAttentionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellone"];
    }
    
    int position = [[myAttention.arrSectionNum objectAtIndex:indexPath.section]intValue]+indexPath.row;
    
    NSString *strUserPhoto = [[NSString alloc]init];
    NSString *strUserShowName = [[NSString alloc]init];
    NSString *strUserType = [[NSString alloc]init];
    
    if([[[myAttention.arrAttention objectAtIndex:position] strUserType] isEqualToString:@"0"])//中介
    {
        strUserPhoto = @"Contact_image2.png";
        strUserShowName = [[myAttention.arrAttention objectAtIndex:position] strIntermediaryName];
        strUserType = @"商户";
    }
    else
    {
        if([[[myAttention.arrAttention objectAtIndex:position] strUserType] isEqualToString:@"1"])//中介下短工
        {
            strUserShowName = [[myAttention.arrAttention objectAtIndex:position] strUserRealName];
            strUserType = [[myAttention.arrAttention objectAtIndex:position] strUserCompany];
        }
        else
        {
            strUserShowName = [[myAttention.arrAttention objectAtIndex:position] strUserRealName];
            strUserType = @"个人";
        }
        
        if([[[myAttention.arrAttention objectAtIndex:position] strUserSex] isEqualToString:@"0"])//男
        {
            strUserPhoto = @"Contact_image1.png";
        }
        else
            strUserPhoto = @"Contact_image.png";
    }
    
    cell.strUserPhoto = strUserPhoto;
    if([[[myAttention.arrAttention objectAtIndex:position] strUserPhoto] isEqualToString:@""])
    {
        cell.strUserPhoto = strUserPhoto;
        [cell.imageHView setImage:[UIImage imageNamed:strUserPhoto]];
    }
    else
    {
        cell.strUserPhoto = strUserPhoto;
        [cell.imageHView setImageWithURL:[NSURL URLWithString:[[myAttention.arrAttention objectAtIndex:position] strUserPhoto]] placeholderImage:cell.imageH];
    }
    
    CGSize labelSize = [strUserShowName sizeWithFont:FONT15_BOLDSYSTEM constrainedToSize:CGSizeMake(185, 400) lineBreakMode:NSLineBreakByCharWrapping];
    [cell.labName setFrame:CGRectMake(65, 5, labelSize.width, 20)];
    [cell.labName setText:strUserShowName];
    
    CGSize labelTypeSize = [strUserType sizeWithFont:FONT12_BOLDSYSTEM constrainedToSize:CGSizeMake(185, 400) lineBreakMode:NSLineBreakByCharWrapping];
    [cell.labType setFrame:CGRectMake(65+6+labelSize.width, 8, labelTypeSize.width+2, 16)];
    [cell.labType setText:strUserType];
    
    [cell.labWork setText:@""];
    NSArray *arrUserPost = [[NSArray alloc]initWithArray:[[[myAttention.arrAttention objectAtIndex:position] strUserPost] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]]];
    for(int i=0;i<arrUserPost.count;i++)
    {
        [cell.labWork setText:[NSString stringWithFormat:@"%@ %@",cell.labWork.text,[arrUserPost objectAtIndex:i]]];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    return cell;
}

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
    return myAttention.arrSection;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc]init];
    
    //imageH = [UIImage imageNamed:@"Contact_personHeader@2x.png"];
    UIImageView *imageHView=[[UIImageView alloc] init];
    [imageHView setBackgroundColor:[UIColor colorWithRed:199.0/255 green:199.0/255 blue:199.0/255 alpha:1.0]];
    [imageHView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
    [viewHeader addSubview:imageHView];
    
    UILabel *labTitle = [[UILabel alloc]initWithFrame:CGRectMake(12.5, 0, 100, 25)];
    [labTitle setBackgroundColor:[UIColor clearColor]];
    [labTitle setText:[myAttention.arrSection objectAtIndex:section]];
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
    [search resignFirstResponder];
    
    int position = [[myAttention.arrSectionNum objectAtIndex:indexPath.section]intValue]+indexPath.row;
    
    Ty_Home_UserDetailVC *userDetail = [[Ty_Home_UserDetailVC alloc] init];
    [userDetail Home_UserDetail:Ty_Home_UserDetailTypeOther];
    userDetail.userDetailBusine.userService.userType = [[myAttention.arrAttention objectAtIndex:position]strUserType];
    if([[[myAttention.arrAttention objectAtIndex:position]strUserType] isEqualToString:@"0"])
    {
        userDetail.userDetailBusine.userService.companiesGuid = [[myAttention.arrAttention objectAtIndex:position]strAttentionGuid];
    }
    else if([[[myAttention.arrAttention objectAtIndex:position]strUserType] isEqualToString:@"1"])
    {
        userDetail.userDetailBusine.userService.companiesGuid = [[myAttention.arrAttention objectAtIndex:position]strAttentionGuid];
    }
    else
    {
        userDetail.userDetailBusine.userService.userGuid = [[myAttention.arrAttention objectAtIndex:position]strAttentionGuid];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushUserDetail" object:userDetail];
    //[superVC.naviGationController pushViewController:userDetail animated:YES];
}

#pragma mark 侧滑栏
-(void)allWork
{
    [search resignFirstResponder];
    
    if (!workBool)//打开
    {
        [UIView beginAnimations:nil context:nil];
        [UIView animateWithDuration:0.4 animations:^{
            [self setFrame:CGRectMake(SCREEN_WIDTH*0.75, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }];
        [UIView commitAnimations];
        
        //屏蔽
        [tableview setUserInteractionEnabled:NO];
        //[button_back setUserInteractionEnabled:NO];
    }
    else//关闭
    {
        [UIView beginAnimations:nil context:nil];
        [UIView animateWithDuration:0.4 animations:^{
            [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }];
        [UIView commitAnimations];
        
        //取消屏蔽
        [tableview setUserInteractionEnabled:YES];
        //[button_back setUserInteractionEnabled:YES];
    }
    
    workBool = !workBool;
}

-(void)allWorkBack:(NSNotification*)_notification
{
    /*[UIView beginAnimations:nil context:nil];
     [UIView animateWithDuration:0.4 animations:^{
     self.leveyTabBarController.view.frame=CGRectMake(0, self.leveyTabBarController.view.frame.origin.y, self.leveyTabBarController.view.frame.size.width, self.leveyTabBarController.view.frame.size.height);
     }];
     [UIView commitAnimations];
     
     levey = [LeveyTabBar alloc];
     levey.contactTagBool = 1;
     
     //取消屏蔽
     [tableview setUserInteractionEnabled:YES];
     [viewUserInteractionEnabled setFrame:CGRectMake(0, 0, 0, MainFram.size.height-44)];
     chage=NO;
     
     if([[_notification object] count] > 0)
     {
     arrContactData = [_notification object];
     [self updateList];
     }
     else
     {
     [arrContactData removeAllObjects];
     [arrSection removeAllObjects];
     [arrSectionNum removeAllObjects];
     
     [tableview reloadData];
     }*/
}

#pragma mark 搜索框
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //[self.imageView_background setHidden:YES];
    
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)hsearchBar
{
    [self.superVC.view bringSubviewToFront:search];
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
    //[self.imageView_background setHidden:NO];
    
    searchBar.text = @"";
    [myAttention getMyAttentionFromSqlWithSearch:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [myAttention getMyAttentionFromSqlWithSearch:[NSString stringWithFormat:@"and (CONTACTDATA_USER_REALNAME like '%%%@' or CONTACTDATA_USER_REALNAME like '%@%%' or CONTACTDATA_USER_REALNAME like '%%%@%%' or CONTACTDATA_USER_SPELL like '%%%@' or CONTACTDATA_USER_SPELL like '%@%%' or CONTACTDATA_USER_SPELL like '%%%@%%' or CONTACTDATA_INTERMEDIARY_NAME like '%%%@' or CONTACTDATA_INTERMEDIARY_NAME like '%@%%' or CONTACTDATA_INTERMEDIARY_NAME like '%%%@%%')",searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText]];
}

/*- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    //searchBool = YES;
    
    //搜索本地数据
    [myAttention getMyAttentionFromSqlWithSearch:@""];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    //searchBool = YES;
    
    [myAttention getMyAttentionFromSqlWithSearch:[NSString stringWithFormat:@"and (CONTACTDATA_USER_REALNAME like '%%%@' or CONTACTDATA_USER_REALNAME like '%@%%' or CONTACTDATA_USER_REALNAME like '%%%@%%' or CONTACTDATA_USER_SPELL like '%%%@' or CONTACTDATA_USER_SPELL like '%@%%' or CONTACTDATA_USER_SPELL like '%%%@%%' or CONTACTDATA_INTERMEDIARY_NAME like '%%%@' or CONTACTDATA_INTERMEDIARY_NAME like '%@%%' or CONTACTDATA_INTERMEDIARY_NAME like '%%%@%%')",searchString,searchString,searchString,searchString,searchString,searchString,searchString,searchString,searchString]];
    
    return YES;
}*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
