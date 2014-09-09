//
//  PopView.m
//  腾云家务
//
//  Created by 齐 浩 on 14-3-16.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_PopView.h"

@implementation Ty_PopView
@synthesize array,delegate,popData;
- (id)initWithFrame:(CGRect)frame dataArray:(NSArray*)_array
{
    self  = [super initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];
    
    if (self) {
        // Initialization code
        array = [[NSArray alloc]init];
        popData = [[Ty_PopViewData alloc]init];
        popStyle = PopViewStyleOne;
        array = [_array copy];
//        [self setBackgroundColor:[UIColor whiteColor]];
        tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0) style:UITableViewStylePlain];
        [tableview setDelegate:self];
        [tableview setDataSource:self];
        [tableview setBackgroundColor:[UIColor whiteColor]];
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT)];
        backView.alpha = 0.3;
        
        secondBackView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.origin.y, SCREEN_WIDTH, frame.size.height)];
        
        tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard)];
        
        [backView setBackgroundColor:[UIColor grayColor]];
        
        [backView addGestureRecognizer:tapGesture];
        [self addSubview:tableview];
        
        [secondBackView addSubview:self];
        
        if (tableview.contentOffset.y>0) {
            NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [tableview selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        }
        
    }
    return self;
}
-(void)dismissKeyBoard
{
    float a = self.frame.size.height;
    [UIView animateWithDuration:0.45f animations:^{
        [tableview setFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [self setFrame:CGRectMake(self.frame.origin.x,0, self.frame.size.width, 0)];
    } completion:^(BOOL finished) {
        [backView removeFromSuperview];
        [self removeFromSuperview];
        [secondBackView removeFromSuperview];
        [self setFrame:CGRectMake(self.frame.origin.x, 0, self.frame.size.width,a)];
    }];
}
-(void)dismiss
{
    [backView removeFromSuperview];
    [self removeFromSuperview];
    [secondBackView removeFromSuperview];
    [tableview setFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
}
-(void)showInView:(UIView *)view
{
    [self dismiss];
    [view addSubview:backView];
    [secondBackView addSubview:self];
    [view addSubview:secondBackView];
    
    [UIView animateWithDuration:0.45f animations:^{
        [self setFrame:CGRectMake(self.frame.origin.x,0, self.frame.size.width, self.frame.size.height)];
        [tableview setFrame:CGRectMake(tableview.frame.origin.x, tableview.frame.origin.y, tableview.frame.size.width, self.frame.size.height)];
    } completion:^(BOOL finished) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* Cell = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cell];
    }
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    [cell setSelectedTextColor:Color_orange];
    [cell setSelectedBackgroundView:[[UIImageView alloc]initWithImage:JWImageName(@"home_selectCellbackground")]];
    [cell setBackgroundView:[[UIImageView alloc]initWithImage:JWImageName(@"home_cellbackground")]];

    return cell;
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableview == tableView) {
        popData.data = [array objectAtIndex:indexPath.row];
        if (popStyle == PopViewStyleOne) {
            if (delegate) {
                [delegate PopView:self clickedButtonAtIndex:indexPath.row];
            }
        }
        [self dismissKeyBoard];
    }
}
-(void)setPopViewStyle:(enum Ty_PopViewStyle)_popViewStyle
{
    popStyle = _popViewStyle;
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
