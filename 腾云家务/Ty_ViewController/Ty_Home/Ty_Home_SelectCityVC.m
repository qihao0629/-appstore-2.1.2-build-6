//
//  Ty_Home_SelectCityVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Home_SelectCityVC.h"
#import "ChineseString.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
@interface Ty_Home_SelectCityVC ()
{
    UIButton* locationButton;
    NSMutableArray * locationArray;//定位城市数组
    NSString* locationCity;//定位城市
}
@end

@implementation Ty_Home_SelectCityVC
@synthesize home_selectData,delegate;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        home_selectData = [[TSLocation alloc]init];
        locationArray = [[NSMutableArray alloc]initWithObjects:@"", nil];
        
        cityDic = [[NSMutableDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cityMain" ofType:@"plist"]];
        
        Array = [[NSMutableArray alloc]initWithArray:[cityDic allKeys]];
        ArrayPinYin = [[NSMutableArray alloc]init];
        for (int i = 0; i<Array.count; i++) {
            NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:Array[i]];
            [ArrayPinYin addObject:tempPinYinStr];
        }
        
        tableArray = [ChineseString LetterSortArray:Array];
        
        IndexArray = [[NSMutableArray alloc]init];
        [IndexArray setArray:[ChineseString IndexArray:Array]];
        [IndexArray insertObject:@"热" atIndex:0];
        [IndexArray insertObject:@"定" atIndex:0];
        
        NSMutableArray* array = [[NSMutableArray alloc]initWithObjects:@"上海",@"北京", nil];
        [tableArray insertObject:array atIndex:0];
        
        [tableArray insertObject:locationArray atIndex:0];
        
        // 如果定位服务可用
        self.myGeocoder = [[CLGeocoder alloc] init];
        isNewLocation = YES;
        if([CLLocationManager locationServicesEnabled])
        {
            NSLog( @"开始执行定位服务" );
            // 创建CLLocationManager对象
            self.locationManager = [[CLLocationManager alloc]init];
            // 设置定位精度：最佳精度
            self.locationManager.desiredAccuracy  = kCLLocationAccuracyBest;
            // 设置距离过滤器为50米，表示每移动50米更新一次位置
            self.locationManager.distanceFilter = 5000;
            // 将视图控制器自身设置为CLLocationManager的delegate
            // 因此该视图控制器需要实现CLLocationManagerDelegate协议
            self.locationManager.delegate = self;
            
            // 开始监听定位信息
            [self.locationManager startUpdatingLocation];
        }
        else
        {
            NSLog(@"无法使用定位服务！" );
            locationCity = @"无法使用定位服务！";
            [locationArray replaceObjectAtIndex:0 withObject:@"无法使用定位服务！"];
            //        locationCity
        }
    }
    return self;
}
-(void)leftButtonAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    
    self.title = @"选择城市";
    
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setExclusiveTouch:YES];
    [leftButton setFrame:CGRectMake(0, 0, 50, 44)];
    
//    [leftButton setImage:JWImageName(@"")  forState:UIControlStateNormal];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:FONT13_SYSTEM];
    [leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"搜索列表"];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
    
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.sectionIndexColor = [UIColor blackColor];
    tableview.tableHeaderView = mySearchBar;
    [tableview setBackgroundColor:view_BackGroudColor];
    tableview.separatorColor = text_grayColor;
    
    //定义tableview背景图片
    UIImageView* tableviewBackimage = [[UIImageView alloc]initWithFrame:self.view.frame];
    [tableviewBackimage setBackgroundColor:view_BackGroudColor];
    [tableview setBackgroundView:tableviewBackimage];
    
    locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationButton setImage:JWImageName(@"sr_refreshgray") forState:UIControlStateNormal];
    [locationButton setFrame:CGRectMake(tableview.frame.size.width-80, 80, 20, 20)];
    [locationButton addTarget:self action:@selector(ResetCity:) forControlEvents:UIControlEventTouchUpInside];
    
    [tableview addSubview:locationButton];
    
    _netMind = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _netMind.center = CGPointMake(tableview.frame.size.width - 70, 90);
    
    
//    [_netMind startAnimating];
    
    [tableview addSubview:_netMind];
    [self.view addSubview:tableview];
    
    
	// Do any additional setup after loading the view.
}
-(void)ResetCity:(UIButton*)_button
{
    isNewLocation = YES;
    [self.locationManager startUpdatingLocation];
    locationButton.hidden = YES;
    [_netMind startAnimating];
}
#pragma mark ----- 定位 回调


// 成功获取定位数据后将会激发该方法
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%f",newLocation.coordinate.latitude);
    if (isNewLocation ) {
        [self startedReverseGeoderWithLatitude:newLocation];
        isNewLocation = NO;
    }
}
// 定位失败时激发的方法
- (void)locationManager:(CLLocationManager*)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"定位失败:%@",error);
    locationButton.hidden = NO;
    [_netMind stopAnimating];
}
#pragma mark -----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView  ==  self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
    }
    else {
        return [tableArray count];
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView  ==  self.searchDisplayController.searchResultsTableView) {
        return [[searchResults objectAtIndex:section] count];
    }
    else {
        return [[tableArray objectAtIndex:section] count];
    }

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* Cell = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    if (tableView  ==  self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [[searchResults objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    else {
        cell.textLabel.text = [[tableArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView  ==  tableview) {
        if ([[IndexArray objectAtIndex:section] isEqualToString:@"定"]) {
            return @"定位城市";
        }
        if ([[IndexArray objectAtIndex:section] isEqualToString:@"热"]) {
            return @"热门城市";
        }
        return [IndexArray objectAtIndex:section];
    }
    return nil;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView  ==  tableview) {
        return IndexArray;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ResignFirstResponder
    searchDisplayController.active = NO;
    
    if (tableView  ==  self.searchDisplayController.searchResultsTableView) {
        home_selectData.state = [cityDic objectForKey:[[searchResults objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        home_selectData.city = [[searchResults objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        if (delegate) {
            [delegate Home_SelectCity:home_selectData];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        if (indexPath.section == 0) {
            if ([locationCity isEqualToString:@"定位失败，点击重试"]||[locationCity isEqualToString:@"无法使用定位服务！"]||[locationCity isEqualToString:@""]|| locationCity == nil) {
                
            }else{
                home_selectData.state = [cityDic objectForKey:[[tableArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
                home_selectData.city = [[tableArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                if (delegate) {
                    [delegate Home_SelectCity:home_selectData];
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }else{
            home_selectData.state = [cityDic objectForKey:[[tableArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
            home_selectData.city = [[tableArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            if (delegate) {
                [delegate Home_SelectCity:home_selectData];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSMutableArray* Results = [[NSMutableArray alloc]init];
    if (mySearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:mySearchBar.text]) {
        for (NSString *tempStr in ArrayPinYin) {
            NSRange titleResult = [tempStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [Results addObject:[Array objectAtIndex:[ArrayPinYin indexOfObject:tempStr]]];
            }
        }
    }
    else if (mySearchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:mySearchBar.text]) {
        for (NSString *tempStr in Array) {
            NSRange titleResult = [tempStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [Results addObject:tempStr];
            }
        }
    }
    searchResults = [ChineseString LetterSortArray:Results];
}

#pragma mark ----- 定位反编译 拿到城市

- (void)startedReverseGeoderWithLatitude:(CLLocation *)location{
    
    //    CLLocation * cl = [[CLLocation alloc]initWithLatitude:43.907787 longitude:124.809752];
    
    [self.myGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error  ==  nil &&[placemarks count] > 0){
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            /* We received the results */
//            NSLog(@"Country = %@", placemark.country);
//            NSLog(@"Postal Code = %@", placemark.postalCode);
//            NSLog(@"Locality = %@", placemark.locality);
//            NSLog(@"dic = %@", placemark.addressDictionary );
//            NSLog(@"dic FormattedAddressLines =  %@", [placemark.addressDictionary objectForKey:@"FormattedAddressLines"]);
//            NSLog(@"dic Name = %@", [placemark.addressDictionary objectForKey:@"Name"]);
//            NSLog(@"dic city = %@", [placemark.addressDictionary objectForKey:@"City"]);
//            NSLog(@"dic State = %@", [placemark.addressDictionary objectForKey:@"State"]);
//            NSLog(@"dic Street = %@", [placemark.addressDictionary objectForKey:@"Street"]);
//            NSLog(@"dic SubLocality =  %@", [placemark.addressDictionary objectForKey:@"SubLocality"]);
//            NSLog(@"dic SubThoroughfare =  %@", [placemark.addressDictionary objectForKey:@"SubThoroughfare"]);
//            NSLog(@"dic Thoroughfare = %@", [placemark.addressDictionary objectForKey:@"Thoroughfare"]);
            isNewLocation = NO;
            [self.locationManager stopUpdatingLocation];
            
            if ([placemark.addressDictionary objectForKey:@"City"]  ==  NULL) {

//                [placemark.addressDictionary objectForKey:@"State"]
                NSLog(@"%@",[placemark.addressDictionary objectForKey:@"State"]);
                locationCity = [placemark.addressDictionary objectForKey:@"State"];
                [self locationCity];
                
            }else{
                
                NSLog(@"%@",[placemark.addressDictionary objectForKey:@"City"]);
                locationCity = [placemark.addressDictionary objectForKey:@"City"];
                [self locationCity];
           
            }
        }
        else if (error  ==  nil &&
                 [placemarks count]  ==  0){
            NSLog(@"No results were returned.");
        }
        else if (error !=  nil){
            NSLog(@"An error occurred = %@", error);
            locationCity = @"定位失败，点击重试";
            [locationArray replaceObjectAtIndex:0 withObject:@"定位失败，点击重试"];
            [self locationCity];

        }
        locationButton.hidden = NO;
        [_netMind stopAnimating];
    }];
    
}

-(void)locationCity
{
    if (locationCity.length>2) {
        NSString* city = [locationCity substringToIndex:2];
        for (int i = 0; i<[Array count]; i++) {
            if ([city hasPrefix:Array[i]]) {
                NSLog(@"city===%@",Array[i]);
                [locationArray replaceObjectAtIndex:0 withObject:Array[i]];
                if (locationArray.count>0) {
                    home_selectData.state = [cityDic objectForKey:locationArray[0]];
                    home_selectData.city = locationArray[0];
                    NSLog(@"home_selectData.state,city===%@,%@",home_selectData.state,home_selectData.city);
                    [delegate Home_SelectCity:home_selectData];
                }
                NSLog(@"locationArray = %@",locationArray);
            }
        }
    }
    if (tableview != nil) {
        [tableview reloadData];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
