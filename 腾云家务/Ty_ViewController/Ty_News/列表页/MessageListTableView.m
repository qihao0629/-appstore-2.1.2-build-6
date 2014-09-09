
//
//  MessageListTableView.m
//  腾云家务
//
//  Created by liu on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "MessageListTableView.h"
#import "MessageListCell.h"
#import "Ty_Model_MessageInfo.h"



@implementation MessageListTableView

@synthesize jumpDelegate = _jumpDelegate;

@synthesize allMessageArr = _allMessageArr;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        // Initialization code
        
        self.delegate = self;
        self.dataSource = self;
        
       // _allMessageArr = [[NSMutableArray alloc]init];
        
    }
    return self;
}

#pragma mark --- tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allMessageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (nil == cell)
    {
        cell = [[MessageListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    Ty_Model_MessageInfo *messageInfo = [_allMessageArr objectAtIndex:indexPath.row];
    
    
    
    [cell setCellContent:messageInfo cellRows:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

#pragma mark -- table delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_jumpDelegate respondsToSelector:@selector(jumpToNextPageWithIndexRow:)])
    {
        [_jumpDelegate jumpToNextPageWithIndexRow:indexPath.row];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 3)
    {
        return NO;
    }
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView

           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 )
    {
        return UITableViewCellEditingStyleNone;
    }
    else
    {
        return UITableViewCellEditingStyleDelete;
    }
    
}



- (void) tableView:(UITableView *)tableView  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Ty_Model_MessageInfo *messageInfo = [_allMessageArr objectAtIndex:indexPath.row];
        [_jumpDelegate deleteGroup:messageInfo.messageContactGuid];
        
        [self beginUpdates];
        
        [_allMessageArr removeObjectAtIndex:indexPath.row];
      //  [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
         NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
        
        [self endUpdates];
        
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
