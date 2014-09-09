//
//  CityPopView.m
//  腾云家务
//
//  Created by 齐 浩 on 14-3-17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_CityPopView.h"

@implementation Ty_CityPopView

@synthesize delegate,quanshiStates,quanshiString;
static Ty_CityPopView * cityPopview;

+(id)shareCityPopView:(CGRect)frame States:(NSString*)_states City:(NSString* )_city
{
    if (cityPopview == nil) {
        cityPopview = [[Ty_CityPopView alloc]initWithFrame:frame States:_states City:_city];
        
    }else{
        cityPopview = [cityPopview initWithFrame:frame States:_states City:_city];
    }
    
    return cityPopview;
}

- (id)initWithFrame:(CGRect)frame States:(NSString*)_states City:(NSString* )_city
{
    if (cityPopview == nil) {
        cityPopview = [super initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];
        
//        popStyle = cityPopViewStyleOne;
        regions = [[NSMutableArray alloc]init];
        quyus = [[NSMutableArray alloc]init];

        provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
        cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
        [quyus setArray:[[cities objectAtIndex:0] objectForKey:@"areas"]];
        [regions setArray:[[quyus objectAtIndex:0] objectForKey:@"regions"]];
        //初始化默认数据
        self.locate = [[TSLocation alloc] init];
        self.locate.state = [[provinces objectAtIndex:0] objectForKey:@"state"];
        self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
        self.locate.quyu = [[quyus objectAtIndex:0] objectForKey:@"area"];
        self.locate.region = [regions objectAtIndex:0];
        
        tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 0) style:UITableViewStylePlain];
        [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(frame.size.width/3, 0, frame.size.width/3*2, 0) style:UITableViewStylePlain];
        [tableview2 setSeparatorStyle:UITableViewCellSeparatorStyleNone];

        
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        secondBackView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.origin.y, SCREEN_WIDTH, frame.size.height)];
        
        tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard)];
        
        [backView addGestureRecognizer:tapGesture];
        
        quanshiStates = _states;
        quanshiString = _city;
        
        for (int i = 0; i<[provinces count]; i++) {
            if([quanshiStates isEqualToString:[[provinces objectAtIndex:i] objectForKey:@"state"]])
            {
                cities = [[provinces objectAtIndex:i] objectForKey:@"cities"];
            }
        }
        
        //        cities = [[provinces objectAtIndex:[provinces indexOfObject:quanshiStates]] objectForKey:@"cities"];
        for (int j = 0; j<[cities count]; j++) {
            if([quanshiString isEqualToString:[[cities objectAtIndex:j] objectForKey:@"city"]])
            {
                [quyus setArray:[[cities objectAtIndex:j] objectForKey:@"areas"]];
                //            [regions setArray:[[quyus objectAtIndex:0] objectForKey:@"regions"]];
                [quyus insertObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"附近",@"area", nil] atIndex:0];
                [quyus insertObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"全部区域",@"area", nil] atIndex:0];
                //            [regions insertObject:@"全部区域" atIndex:0];
                
            }
        }
        self.locate.quyu = [[quyus objectAtIndex:0] objectForKey:@"area"];
//        [regions setArray:[[NSArray alloc] initWithObjects:@"附近",@"500m",@"1000m",@"2000m",@"5000m", nil]];
        [regions setArray:[[NSArray alloc] initWithObjects:@"全部区域",nil]];
        
        [tableview setDelegate:self];
        [tableview setDataSource:self];
        [tableview setBackgroundColor:[UIColor whiteColor]];
        
        [tableview2 setDelegate:self];
        [tableview2 setDataSource:self];
        [tableview2 setBackgroundColor:[UIColor whiteColor]];
        
        backView.alpha = 0.3;
        [backView setBackgroundColor:[UIColor grayColor]];
        
        [secondBackView setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:tableview];
        [self addSubview:tableview2];
        
        NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [tableview selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        [tableview2 selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];

    }else{
        
        [cityPopview setFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];
        
        [tableview setFrame:CGRectMake(0, 0, frame.size.width, 0)];
        
        [tableview2 setFrame:CGRectMake(frame.size.width/3, 0, frame.size.width/3*2, 0)];
        
        [backView setFrame:CGRectMake(0, frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        [secondBackView setFrame:CGRectMake(0, frame.origin.y, SCREEN_WIDTH, frame.size.height)];

        [tableview setDelegate:self];
        [tableview setDataSource:self];
        [tableview setBackgroundColor:[UIColor whiteColor]];
        
        [tableview2 setDelegate:self];
        [tableview2 setDataSource:self];
        [tableview2 setBackgroundColor:[UIColor whiteColor]];
        
        backView.alpha = 0.3;
        [backView setBackgroundColor:[UIColor grayColor]];
        
        [secondBackView setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:tableview];
        [self addSubview:tableview2];
    }
//    if (cityPopview) {
//        // Initialization code
//        //加载数据
//
//        [tableview setDelegate:self];
//        [tableview setDataSource:self];
//        [tableview setBackgroundColor:[UIColor whiteColor]];
//        
//        [tableview2 setDelegate:self];
//        [tableview2 setDataSource:self];
//        [tableview2 setBackgroundColor:[UIColor whiteColor]];
//        
//        backView.alpha = 0.3;
//        [backView setBackgroundColor:[UIColor grayColor]];
//        
//        [secondBackView setBackgroundColor:[UIColor clearColor]];
//
//        [self addSubview:tableview];
//        [self addSubview:tableview2];
//        NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [tableview selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
//        [tableview2 selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
//    }
    return cityPopview;
}
-(void)dismissKeyBoard
{
    [UIView animateWithDuration:0.45f animations:^{
        [tableview setFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [tableview2 setFrame:CGRectMake(tableview2.frame.origin.x, 0, self.frame.size.width/3*2, 0)];
        [self setFrame:CGRectMake(self.frame.origin.x,0, self.frame.size.width, 0)];
    } completion:^(BOOL finished) {
        [backView removeFromSuperview];
        [self removeFromSuperview];
        [secondBackView removeFromSuperview];
    }];

}
-(void)dismiss
{
    [backView removeFromSuperview];
    [self removeFromSuperview];
    [secondBackView removeFromSuperview];
}
-(void)disAppear
{
    cityPopview = nil;
}
-(void)showInView:(UIView *)view
{
    [self dismiss];

//    [regions setArray:[[NSArray alloc] initWithObjects:@"全部区域", nil]];

//    [backView addSubview:self];
    [view addSubview:backView];
    [secondBackView addSubview:self];
    [view addSubview:secondBackView];
    
    
    [UIView animateWithDuration:0.45f animations:^{
        [self setFrame:CGRectMake(self.frame.origin.x,0, self.frame.size.width, self.frame.size.height)];
        [tableview setFrame:CGRectMake(tableview.frame.origin.x, tableview.frame.origin.y, tableview.frame.size.width, self.frame.size.height)];
        [tableview2 setFrame:CGRectMake(tableview2.frame.origin.x, tableview2.frame.origin.y, tableview2.frame.size.width, self.frame.size.height)];
    } completion:^(BOOL finished) {
  
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tableview) {
        return [quyus count];
    }else{
        self.locate.region = [regions objectAtIndex:0];
        return [regions count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableview) {
        static NSString* Cell = @"Cell";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:Cell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cell];
        }
        cell.textLabel.text = [[quyus objectAtIndex:indexPath.row] objectForKey:@"area"];
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        UIImageView* selectedBack = [[UIImageView alloc]init];
        [selectedBack setBackgroundColor:[UIColor whiteColor]];
        [cell setSelectedBackgroundView:selectedBack];
        [cell setSelectedTextColor:text_blackColor];
        selectedBack = nil;
        UIImageView* back = [[UIImageView alloc]init];
        [back setBackgroundColor:Color_217];
        [cell setBackgroundView:back];
        back = nil;
        return cell;
    }else{
        static NSString* Cell2 = @"Cell2";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:Cell2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cell2];
        }
        cell.textLabel.text = [regions objectAtIndex:indexPath.row];
        [cell setSelectedTextColor:Color_orange];
        [cell setSelectedBackgroundView:[[UIImageView alloc]initWithImage:JWImageName(@"home_selectCellbackground")]];
        [cell setBackgroundView:[[UIImageView alloc]initWithImage:JWImageName(@"home_cellbackground")]];
        return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableview == tableView) {
        self.locate.quyu = [[quyus objectAtIndex:indexPath.row] objectForKey:@"area"];
        if ([self.locate.quyu isEqualToString:@"附近"]) {
            [regions setArray:[[NSArray alloc] initWithObjects:@"附近",@"500m",@"1000m",@"2000m",@"5000m", nil]];
        }else{
            [regions setArray:[[quyus objectAtIndex:indexPath.row] objectForKey:@"regions"]];
            [regions insertObject:@"全部区域" atIndex:0];
            NSLog(@"%@",self.locate.quyu);
            if (regions.count>0) {
                self.locate.region = [regions objectAtIndex:0];
            }
        }
        [tableview2 reloadData];
    }else if(tableView == tableview2){
        self.locate.region = [regions objectAtIndex:indexPath.row];
        if (delegate) {
            [delegate CityPopView:self clickedButtonAtIndex:indexPath.row];
        }
        [self dismissKeyBoard];
    }
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
