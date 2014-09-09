//
//  HomeWorkTypeView.m
//  腾云家务
//
//  Created by 齐 浩 on 14-1-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HomeWorkTypeView.h"
#import "Ty_HomeWorkTypeButton.h"

@implementation Ty_HomeWorkTypeView
@synthesize delegate;
@synthesize numberForRows,size_Wite,size_Juli,heightRows;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1]];
        numberForRows = 3;
        
        size_Wite=318.0/numberForRows;
        size_Juli=0.5;
    }
    return self;
}
-(void)setData:(NSMutableArray *)_arr
{
    heightRows=[_arr count]/numberForRows;
    if ([_arr count]%numberForRows != 0) {
        [self setFrame:CGRectMake(0, 0, 320, (heightRows+1)*44+(heightRows)*size_Juli)];
    }else{
        [self setFrame:CGRectMake(0, 0, 320, heightRows*44+(heightRows-1)*size_Juli)];
    }
    for (int i = 0; i < heightRows; i++) {
        for (int j = 0; j < numberForRows; j++) {
            Ty_HomeWorkTypeButton* homework = [Ty_HomeWorkTypeButton buttonWithType:UIButtonTypeCustom];
            [homework setFrame:CGRectMake(j*(size_Wite+size_Juli), i*(44+size_Juli), size_Wite, 44)];
            homework.kaifangYesOrNO = [[_arr objectAtIndex:(i*numberForRows+j)] objectForKey:@"exists"];

            [homework setTitle:[[_arr objectAtIndex:(i*numberForRows+j)] objectForKey:@"workName"] forState:UIControlStateNormal];
            
            homework.guid = [[_arr objectAtIndex:(i*numberForRows+j)] objectForKey:@"workGuid"];
            [homework addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [homework addTarget:self action:@selector(HomeButtonActionTouchCancel:) forControlEvents:UIControlEventTouchDragExit];
            [homework addTarget:self action:@selector(HomeButtonActionTouchDown:) forControlEvents:UIControlEventTouchDown];
            [homework addTarget:self action:@selector(HomeButtonActionTouchCancel:) forControlEvents:UIControlEventTouchDragOutside];
            [homework addTarget:self action:@selector(HomeButtonActionTouchCancel:) forControlEvents:UIControlEventTouchCancel];
            
            [self addSubview:homework];
            homework=nil;
        }
    }
    if ([_arr count] % numberForRows != 0) {
        for (int j = 0; j<[_arr count] % numberForRows; j++) {
            Ty_HomeWorkTypeButton* homework = [Ty_HomeWorkTypeButton buttonWithType:UIButtonTypeCustom];
            [homework setFrame:CGRectMake(j*(size_Wite+size_Juli), (heightRows)*(44+size_Juli), size_Wite, 44)];
            [homework setTitle:[[_arr objectAtIndex:((heightRows)*numberForRows+j)] objectForKey:@"workName"] forState:UIControlStateNormal];
            homework.guid = [[_arr objectAtIndex:((heightRows)*numberForRows+j)] objectForKey:@"workGuid"];
            homework.kaifangYesOrNO=[[_arr objectAtIndex:((heightRows)*numberForRows+j)] objectForKey:@"exists"];
            [homework addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [homework addTarget:self action:@selector(HomeButtonActionTouchCancel:) forControlEvents:UIControlEventTouchDragExit];
            [homework addTarget:self action:@selector(HomeButtonActionTouchDown:) forControlEvents:UIControlEventTouchDown];
            [homework addTarget:self action:@selector(HomeButtonActionTouchCancel:) forControlEvents:UIControlEventTouchDragOutside];
            [homework addTarget:self action:@selector(HomeButtonActionTouchCancel:) forControlEvents:UIControlEventTouchCancel];
//            [homework addTarget:self action:@selector(HomeButtonActionTouchDown:) forControlEvents:UIControlEventTouchUpOutside];
            [self addSubview:homework];
            homework=nil;
        }
        for (int j = [_arr count] % numberForRows; j<numberForRows; j++) {
            Ty_HomeWorkTypeButton* homework = [Ty_HomeWorkTypeButton buttonWithType:UIButtonTypeCustom];
            [homework setFrame:CGRectMake(j*(size_Wite+size_Juli), (heightRows)*(44+size_Juli), size_Wite, 44)];
            [self addSubview:homework];
            homework=nil;
        }
    }
}
-(void)click:(id)sender
{
    [self HomeButtonActionTouchCancel:sender];
    if (delegate) {
        [delegate HomeWorkTypeViewButtonClick:sender];
    }
}
-(void)HomeButtonActionTouchCancel:(id)sender
{
    Ty_HomeWorkTypeButton* home=(Ty_HomeWorkTypeButton*)sender;
    [home setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
-(void)HomeButtonActionTouchDown:(id)sender
{
    Ty_HomeWorkTypeButton* home=(Ty_HomeWorkTypeButton*)sender;
    [home setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

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
