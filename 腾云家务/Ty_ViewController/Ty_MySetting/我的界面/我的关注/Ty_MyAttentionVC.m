//
//  Ty_MyAttentionVC.m
//  腾云家务
//
//  Created by liu on 14-7-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MyAttentionVC.h"
#import "Ty_AllWorkView.h"
#import "Ty_Model_ServiceObject.h"
#import "Ty_MyAttentionCell.h"
#import "Ty_Home_UserDetailVC.h"


@implementation Ty_MyAttentionVC

- (id)init
{
    if (self = [super init])
    {
        _isWorkViewShow = NO;
        
        _allContactDic = [[NSMutableDictionary alloc]init];
        _allKeysArr = [[NSMutableArray alloc]init];
        
        _searchArr = [[NSMutableArray alloc]init];
        _searchDic = [[NSMutableDictionary alloc]init];
        _isSearch = NO;
    }
    return self;
}

#pragma mark -- tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger num = 0;
    if (_isSearch)
    {
        num = _searchArr.count;
    }
    else
    {
        num = _allKeysArr.count;
    }
    return num;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 0;
    if (_isSearch)
    {
        NSMutableArray *array = [_searchDic objectForKey:[_searchArr objectAtIndex:section]];
        num = array.count;
    }
    else
    {
        NSMutableArray *array = [_allContactDic objectForKey:[_allKeysArr objectAtIndex:section]];
        num = array.count;
    }
    return num;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    Ty_MyAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[Ty_MyAttentionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    Ty_Model_ServiceObject *object;
    if (_isSearch)
    {
        NSMutableArray *array = [_searchDic objectForKey:[_searchArr objectAtIndex:indexPath.section]];
        object = [array objectAtIndex:indexPath.row];
    }
    else
    {
        NSMutableArray *array = [_allContactDic objectForKey:[_allKeysArr objectAtIndex:indexPath.section]];
        object = [array objectAtIndex:indexPath.row];
    }
    
    
    [cell setContent:object];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_allKeysArr objectAtIndex:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 22)] ;
    view.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:245.0/255 alpha:1.0];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, view.frame.size.width - 20, 16)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = _isSearch ? [_searchArr objectAtIndex:section] : [_allKeysArr objectAtIndex:section];
    [view addSubview:titleLabel];
   
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_isSearch)
    {
        return nil;
    }
    return _allKeysArr;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex: (NSInteger) index
{
    if (_hideView.hidden)
    {
        return index;
    }
    else
    {
        return -1;
    }
    
}

#pragma mark -- tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isSearch)
    {
        [_searchBar resignFirstResponder];
        _hideView.hidden = YES;
        _tableView.scrollEnabled = YES;
        _searchBar.showsCancelButton = YES;
        
        if (IOS7)
        {
            UIView *topView = _searchBar.subviews[0];
            
            for (UIView *subView in topView.subviews) {
                
                if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
                    
                    UIButton *cancelButton = (UIButton*)subView;
                    
                    cancelButton.enabled = YES;
                    
                }
                
            }
        }
        else
        {
            for(id control in [_searchBar subviews])
            {
                if ([control isKindOfClass:[UIButton class]])
                {
                    UIButton *button = (UIButton *)control;
                    [button setBackgroundImage:[UIImage imageNamed:@"Action_Tap"] forState:UIControlStateNormal];
                    button.enabled=YES;
                }
            }
        }
    }
    
    
    
    Ty_Model_ServiceObject *object;
    if (_isSearch)
    {
        NSMutableArray *array = [_searchDic objectForKey:[_searchArr objectAtIndex:indexPath.section]];
        object = [array objectAtIndex:indexPath.row];
    }
    else
    {
        NSMutableArray *array = [_allContactDic objectForKey:[_allKeysArr objectAtIndex:indexPath.section]];
        object = [array objectAtIndex:indexPath.row];
    }
    
    Ty_Home_UserDetailVC *userDetailVC = [[Ty_Home_UserDetailVC alloc] init];
    [userDetailVC Home_UserDetail:Ty_Home_UserDetailTypeOther];
    userDetailVC.userDetailBusine.userService.companiesGuid = object.userGuid;
    [self.naviGationController pushViewController:userDetailVC animated:YES];
    
}

#pragma mark --- keyBoard Notification
- (void)keyboardWillShow:(NSNotification *)notification
{
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if (touch.view.tag == 202)
    {
        _hideView.hidden = YES;
        _tableView.scrollEnabled = YES;
        [_searchBar resignFirstResponder];
        _searchBar.text = @"";
        _searchBar.showsCancelButton = NO;
        _isSearch = NO;
    }
    
}
#pragma mark searchBar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    _isSearch = YES;
    
    _hideView.hidden = NO;
    _tableView.scrollEnabled = NO;
    return YES;
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.view bringSubviewToFront:searchBar];
    searchBar.showsCancelButton = YES;
    for (id object in searchBar.subviews)
    {
        if ([object isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton *)object;
            [button setBackgroundImage:[UIImage imageNamed:@"Action_Tap"] forState:UIControlStateNormal];
        }
    }
    //_isSearch = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
    searchBar.text = @"";
    
    _hideView.hidden = YES;
    _tableView.scrollEnabled = YES;
    _isSearch = NO;
    [_tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view bringSubviewToFront:searchBar];
    [self searchContactByString:searchBar.text];
    [searchBar resignFirstResponder];
   // searchBar.text = @"";
    searchBar.showsCancelButton = YES;
    _hideView.hidden = YES;
    _tableView.scrollEnabled = YES;
    _isSearch = YES;
    
    if (IOS7)
    {
        UIView *topView = _searchBar.subviews[0];
        
        for (UIView *subView in topView.subviews) {
            
            if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
                
                UIButton *cancelButton = (UIButton*)subView;
                
                cancelButton.enabled = YES;
                
            }
            
        }
    }
    else
    {
        for(id control in [_searchBar subviews])
        {
            if ([control isKindOfClass:[UIButton class]])
            {
                UIButton *button = (UIButton *)control;
                [button setBackgroundImage:[UIImage imageNamed:@"Action_Tap"] forState:UIControlStateNormal];
                button.enabled=YES;
            }
        }
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchContactByString:searchBar.text];
    _hideView.hidden = YES;
    _tableView.scrollEnabled = YES;
    _isSearch = YES;
}

#pragma mark ----- searchDisplayController
- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
   // _isSearch = NO;
    
}

#pragma mark - UISearchDisplayController delegate methods
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
   // _isSearch = YES;
    
    
    if (searchString.length != 0)
    {
        
    }
    
    return YES;
}

#pragma mark -- 搜索
- (void)searchContactByString:(NSString *)conditionStr
{
    [_searchDic removeAllObjects];
    [_myAttentionBusine searchContact:_searchDic byCondition:conditionStr];
    
    
    [_searchArr removeAllObjects];
    [_searchArr addObjectsFromArray:_searchDic.allKeys];
    [_searchArr sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    }];
    _tableView.hidden = NO;
    [_tableView reloadData];
}

#pragma mark -- search delegate
- (void)searchContactByCondition:(id)object
{
    Ty_Model_WorkNodeInfo *workNodeInfo = (Ty_Model_WorkNodeInfo *)object;
    if ([workNodeInfo.workNodeName isEqualToString:@"全部"])
    {
        [self refreshContactData];
    }
    else
    {
        [_allContactDic removeAllObjects];
        [_myAttentionBusine getAllContactData:_allContactDic byCondition:workNodeInfo];
        
        
        [_allKeysArr removeAllObjects];
        [_allKeysArr addObjectsFromArray:_allContactDic.allKeys];
        [_allKeysArr sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
        }];
        _tableView.hidden = NO;
        [_tableView reloadData];
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        for (UIView *view in self.view.subviews)
        {
            if (view.tag != 200)
            {
                view.transform = CGAffineTransformMakeTranslation(0,0);
            }
        }
        
    }completion:^(BOOL finished)
     {
         _isWorkViewShow = NO;
         _tableView.userInteractionEnabled = YES;
     }];
    
}
#pragma mark -- refreshData
- (void)refreshContactData
{
    [_allContactDic removeAllObjects];
    [_myAttentionBusine getAllContactData:_allContactDic byCondition:nil];
    
    
    [_allKeysArr removeAllObjects];
    [_allKeysArr addObjectsFromArray:_allContactDic.allKeys];
    [_allKeysArr sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    }];
    _tableView.hidden = NO;
    [_tableView reloadData];
}

#pragma mark -- 切换
- (void)allWorkViewShow
{
    // [self searchDisplayControllerWillEndSearch:_searchController];
  //  _searchController.active = NO;
    [_searchBar resignFirstResponder];
    _hideView.hidden = YES;
    _tableView.scrollEnabled = YES;
    _searchBar.showsCancelButton = NO;
    _searchBar.text = @"";
    _isSearch = NO;
    [_tableView reloadData];
   
    if (!_isWorkViewShow)
    {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
            for (UIView *view in self.view.subviews)
            {
                if (view.tag != 200)
                {
                    view.transform = CGAffineTransformMakeTranslation(200,0);
                }
            }
            
        }completion:^(BOOL finished)
         {
             _isWorkViewShow = YES;
             _tableView.userInteractionEnabled = NO;
             
             
         }];
    }
    else
    {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            for (UIView *view in self.view.subviews)
            {
                if (view.tag != 200)
                {
                    view.transform = CGAffineTransformMakeTranslation(0,0);
                }
            }
            
        }completion:^(BOOL finished)
         {
             _isWorkViewShow = NO;
             _tableView.userInteractionEnabled = YES;
             
             
         }];
    }
    
}


#pragma mark -- view lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    
    self.title = @"我的关注";
    
    [self.naviGationController.leftBarButton setImage:JWImageName(@"Contact_search") forState:UIControlStateNormal];
    [self.naviGationController.leftBarButton addTarget:self action:@selector(allWorkViewShow) forControlEvents:UIControlEventTouchUpInside];
    
    
    Ty_AllWorkView *allWorkView = [[Ty_AllWorkView alloc]initWithFrame:CGRectMake(0, - 44, 320, 480)];
    allWorkView.tag = 200;
    allWorkView.delegate = self;
    [self.view addSubview:allWorkView];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44 - 44 - 20 ) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
   [self.view addSubview:_tableView];
    _tableView.hidden = YES;
    
    if (IOS7 )
    {
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    _myAttentionBusine = [[Ty_NewMyAttention_Busine alloc]init];
    
    
    _hideView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, _tableView.frame.size.width, _tableView.frame.size.height - 44)];
    _hideView.backgroundColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
    _hideView.alpha = 0.8;
    _hideView.tag = 202;
    // [_hideView addGestureRecognizer:gestureRecongnizer];
    [self.view addSubview:_hideView];
    _hideView.hidden = YES;
    
    //searchBar
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _searchBar.delegate = self;
    _searchBar.autocorrectionType = UITextAutocapitalizationTypeNone;
    _searchBar.placeholder = @"搜索";
    _searchBar.keyboardType = UIKeyboardTypeDefault;
   // [_searchBar setInputAccessoryView:_hideView];
    [_searchBar setBackgroundImage:[UIImage imageNamed:@"Contact_searchbar1.png"]];
    _tableView.tableHeaderView = _searchBar;
    
    
   // UIGestureRecognizer *gestureRecongnizer = [[UIGestureRecognizer alloc]initWithTarget:self  action:@selector(hideView)];
    
    
    
    
//    _searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
//    
//    _searchController.delegate = self;
//    _searchController.searchResultsDataSource = self;
//    _searchController.searchResultsDelegate = self;
//    _searchController.active = NO;
    
   [self refreshContactData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshContactData) name:@"RefreshContactData" object:nil];
    
    [_myAttentionBusine getContactDataFromNet];
  //  [self.naviGationController setHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
