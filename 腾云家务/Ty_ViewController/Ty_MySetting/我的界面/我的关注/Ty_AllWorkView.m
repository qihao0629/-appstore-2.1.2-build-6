//
//  Ty_AllWorkView.m
//  腾云家务
//
//  Created by liu on 14-7-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_AllWorkView.h"

@implementation Ty_AllWorkView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.frame = CGRectMake(0, - 44 - 20, SCREEN_WIDTH, SCREEN_HEIGHT + 22);
        if (IOS7)
        {
            self.backgroundColor = [UIColor colorWithRed:225.0/255 green:28.0/255 blue:32.0/255 alpha:1.0];
        }
        
        
        _allWorkArr = [[NSMutableArray alloc]init];
        _workNodeInfo = [[Ty_Model_WorkNodeInfo alloc]init];
        _newWorkBusine = [[Ty_NewWork_Busine alloc]init];
        [_newWorkBusine getAllWorkList:_workNodeInfo];
        [self dealWithData];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 200 , SCREEN_HEIGHT - 20) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        
    }
    return self;
}

- (void)dealWithData
{
    [_allWorkArr removeAllObjects];
    
    [_allWorkArr addObject:_workNodeInfo];
    
    for (Ty_Model_WorkNodeInfo *nodeInfo1 in _workNodeInfo.childNodeArr)
    {
        [_allWorkArr addObject:nodeInfo1];
        for (Ty_Model_WorkNodeInfo *nodeInfo2 in nodeInfo1.childNodeArr)
        {
            [_allWorkArr addObject:nodeInfo2];
        }
    }
    
}


#pragma mark -- tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _allWorkArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
  //  cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Ty_Model_WorkNodeInfo *nodeInfo = [_allWorkArr objectAtIndex:indexPath.row];
    cell.textLabel.text = nodeInfo.workNodeName;
    //cell.indentationWidth = (nodeInfo.workNodeLevel - 1) * 25;
    cell.indentationLevel = nodeInfo.workNodeLevel - 1;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor blackColor];
    
  
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_delegate respondsToSelector:@selector(searchContactByCondition:)])
    {
        Ty_Model_WorkNodeInfo *nodeInfo = [_allWorkArr objectAtIndex:indexPath.row];
        [_delegate searchContactByCondition:nodeInfo];
    }
    
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
