//
//  AddUserView.m
//  appspring
//
//  Created by 齐 浩 on 13-12-16.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "AddUserView.h"


#define WIDTH  50
#define HIGHT  90

#define TAGH  3

#define BTNWIDTH  WIDTH - TAGH
#define BTNHIGHT  HIGHT - TAGH

@implementation AddUserView
@synthesize delegate,datasource;
@synthesize editing;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    
    if (delegate) {
        number = [delegate NumberOfView:self];
        maxnumber = [delegate MaxNumberOfView:self];
        numberOfrows = [delegate NumberOfRows:self];
    
        // Do any additional setup after loading the view, typically from a nib.
        int width = self.frame.size.width/numberOfrows;
        for (int i = 0; i<= number; i++)
        {
            int t = i/numberOfrows;
            int d = fmod(i, numberOfrows);
            UIView *nView = [[UIView alloc] initWithFrame:CGRectMake(width * d + 5, HIGHT * t +10, WIDTH, HIGHT)];
            UIView* tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, nView.frame.size.width, nView.frame.size.height)];
            CAppButton *appBtn = [CAppButton BtnWithType:UIButtonTypeCustom];
            [appBtn setFrame:CGRectMake(TAGH, TAGH, BTNWIDTH, BTNHIGHT)];
            [appBtn addTarget:self action:@selector(btnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
            appBtn.tag = i;
            [tView addSubview:appBtn];
            
            if (i == number && number != maxnumber) {
                [appBtn setImage:[UIImage imageNamed:@"addUser"] forState:UIControlStateNormal];
                [appBtn setTitle:@"添加雇工" forState:UIControlStateNormal];
                [nView addSubview:tView];
                [self addSubview:nView];
            }else{
                if (i == number&&number == maxnumber) {
                    
                }else{
                    UIImageView *tagImgView = [[UIImageView alloc] initWithFrame:CGRectMake(appBtn.frame.origin.x, appBtn.frame.origin.y, appBtn.frame.size.width, appBtn.frame.size.height/5*3)];
                    [tagImgView setImage:[UIImage imageNamed:@"deleteTag.png"]];
                    [tagImgView setHidden:YES];
                    [tView addSubview:tagImgView];
                    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
                    [button setFrame:tagImgView.frame];
                    [button setHidden:YES];
                    [button setTag:i];
                    [button addTarget:self action:@selector(btnClicked2:event:) forControlEvents:UIControlEventTouchUpInside];
                    [tView addSubview:button];
                    if (datasource) {
                        [datasource AddUserView:self getCAppButton:appBtn numberOftag:i];
                    }
                    [nView addSubview:tView];
                    [self addSubview:nView];
                }
            }
            //        nView.userInteractionEnabled = NO;
        }
        
        
        if (editing) {
            lpgr =  [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressGestureRecognizer:)];
            [self addGestureRecognizer:lpgr];
            
            tapGestureTel2 =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TwoPressGestureRecognizer:)];
            [tapGestureTel2 setNumberOfTapsRequired:2];
            [tapGestureTel2 setNumberOfTouchesRequired:1];
            [self addGestureRecognizer:tapGestureTel2];
        }
    }
}
-(void)reloadData
{

    NSArray *views = self.subviews;
    for (int i = 0; i <=  number; i++)
    {
        if (i<[views count]) {
            UIView *obj = [views objectAtIndex:i];
            [obj removeFromSuperview];
        }
    }

    if (delegate) {
        number = [delegate NumberOfView:self];
        maxnumber = [delegate MaxNumberOfView:self];
        numberOfrows = [delegate NumberOfRows:self];
    }
    // Do any additional setup after loading the view, typically from a nib.
    int width = self.frame.size.width/numberOfrows;
    for (int i = 0; i <=  number; i++)
    {
        int t = i/numberOfrows;
        int d = fmod(i, numberOfrows);
        UIView *nView = [[UIView alloc] initWithFrame:CGRectMake(width * d + 5, HIGHT * t +10, WIDTH, HIGHT)];
        UIView* tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, nView.frame.size.width, nView.frame.size.height)];
        CAppButton *appBtn = [CAppButton BtnWithType:UIButtonTypeCustom];
        [appBtn setFrame:CGRectMake(TAGH, TAGH, BTNWIDTH, BTNHIGHT)];
        [appBtn addTarget:self action:@selector(btnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
        appBtn.tag = i;
        [tView addSubview:appBtn];
        
        if (i == number && number != maxnumber) {
            [appBtn setImage:[UIImage imageNamed:@"addUser"] forState:UIControlStateNormal];
            [appBtn setTitle:@"添加雇工" forState:UIControlStateNormal];
            [nView addSubview:tView];
            [self addSubview:nView];
        }else{
            if (i == number&&number == maxnumber) {
                
            }else{
                UIImageView *tagImgView = [[UIImageView alloc] initWithFrame:CGRectMake(appBtn.frame.origin.x, appBtn.frame.origin.y, appBtn.frame.size.width, appBtn.frame.size.height/5*3)];
                [tagImgView setImage:[UIImage imageNamed:@"deleteTag.png"]];
                [tagImgView setHidden:YES];
                [tView addSubview:tagImgView];
                UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setFrame:tagImgView.frame];
                [button setHidden:YES];
                [button setTag:i];
                [button addTarget:self action:@selector(btnClicked2:event:) forControlEvents:UIControlEventTouchUpInside];
                [tView addSubview:button];
                if (datasource) {
                    [datasource AddUserView:self getCAppButton:appBtn numberOftag:i];
                }
                [nView addSubview:tView];
                [self addSubview:nView];
            }
        }
        
    }
   
    if (editing) {
        if (!lpgr) {
            lpgr =  [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressGestureRecognizer:)];
            [self addGestureRecognizer:lpgr];
        }
        if (!tapGestureTel2) {
            tapGestureTel2 =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TwoPressGestureRecognizer:)];
            [tapGestureTel2 setNumberOfTapsRequired:2];
            [tapGestureTel2 setNumberOfTouchesRequired:1];
            [self addGestureRecognizer:tapGestureTel2];
        }
    }
}
- (void)btnClicked:(id)sender event:(id)event
{
    UIButton *btn = (UIButton *)sender;
    if (delegate) {
        [delegate AddUserView:self selectViewOfTag:btn.tag];
    }
}
- (void)btnClicked2:(id)sender event:(id)event
{
    UIButton *btn = (UIButton *)sender;
    [self deleteAppBtn:btn.tag];
}
- (void)deleteAppBtn:(int)index
{
    NSArray *views = self.subviews;
     CGRect newframe;
    int _num;
    if (number != maxnumber) {
        _num = number;
    }else{
        _num = number-1;
    }
    for (int i = index; i <=  _num; i++)
    {
        UIView *obj = [views objectAtIndex:i];
         CGRect nextframe = obj.frame;
        if (i  ==  index)
        {
            [obj removeFromSuperview];
            if (delegate) {
                [delegate AddUserView:self moveViewOfTag:i];
            }
            if (i == _num) {
                if (maxnumber == number) {
                    UIView *nView = [[UIView alloc] initWithFrame:nextframe];
                    UIView* tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, nView.frame.size.width, nView.frame.size.height)];
                    CAppButton *appBtn = [CAppButton BtnWithType:UIButtonTypeCustom];
                    [appBtn setFrame:CGRectMake(TAGH, TAGH, BTNWIDTH, BTNHIGHT)];
                    [appBtn addTarget:self action:@selector(btnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
                    appBtn.tag = i+1;
                    [tView addSubview:appBtn];
                    [appBtn setUserInteractionEnabled:NO];
                    [appBtn setImage:[UIImage imageNamed:@"addUser"] forState:UIControlStateNormal];
                    [appBtn setTitle:@"添加雇工" forState:UIControlStateNormal];
                    [nView addSubview:tView];
                    [self addSubview:nView];
                }
            }
        }
        else
        {
            for (UIView *v in obj.subviews)
            {
                if ([v isMemberOfClass:[UIView class]])
                {
                    for (UIView* v2 in v.subviews){
                        if ([v2 isMemberOfClass:[CAppButton class]]) {
                            v2.tag = i-1;
                        }
                        if ([v2 isMemberOfClass:[UIButton class]]) {
                            v2.tag = i-1;
                        }
                    }
                }
                break;
                
            }
            [UIView animateWithDuration:0.3 animations:^
             {
                 obj.frame = newframe;
                 
             } completion:^(BOOL finished)
             {
             }];
            if (i == _num) {
                if (maxnumber == number) {
                    UIView *nView = [[UIView alloc] initWithFrame:nextframe];
                    UIView* tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, nView.frame.size.width, nView.frame.size.height)];
                    CAppButton *appBtn = [CAppButton BtnWithType:UIButtonTypeCustom];
                    [appBtn setFrame:CGRectMake(TAGH, TAGH, BTNWIDTH, BTNHIGHT)];
                    [appBtn addTarget:self action:@selector(btnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
                    appBtn.tag = i+1;
                    [tView addSubview:appBtn];
                    [appBtn setUserInteractionEnabled:NO];
                    [appBtn setImage:[UIImage imageNamed:@"addUser"] forState:UIControlStateNormal];
                    [appBtn setTitle:@"添加雇工" forState:UIControlStateNormal];
                    [nView addSubview:tView];
                    [self addSubview:nView];
                }
            }
        }
        newframe = nextframe;
        NSLog(@"%f",newframe.origin.x);
        NSLog(@"%f",newframe.origin.y);
    }
    number--;
    if (number == 0) {
        [self TwoPressGestureRecognizer:tapGestureTel2];
    }
}

- (void)LongPressGestureRecognizer:(UIGestureRecognizer *)gr
{
    if (gr.state  ==  UIGestureRecognizerStateBegan)
    {
        if (m_bTransform)
            return;
        
        for (UIView *view in self.subviews)
        {
//            view.userInteractionEnabled = YES;
            for (UIView *v in view.subviews)
            {
                for (UIView*v2 in v.subviews) {
                    if ([v2 isMemberOfClass:[UIImageView class]]){
                        [v2 setHidden:NO];
                    }
                    if ([v2 isMemberOfClass:[UIButton class]]) {
                        [v2 setHidden:NO];
                    }
                    if ([v2 isMemberOfClass:[CAppButton class]]) {
                        [v2 setUserInteractionEnabled:NO];
                    }
                }
            }
        }
        m_bTransform = YES;
        [self BeginWobble];
    }
}

-(void)TwoPressGestureRecognizer:(UIGestureRecognizer *)gr
{
    if(m_bTransform == NO)
        return;
    
    for (UIView *view in self.subviews)
    {
//        view.userInteractionEnabled = NO;
        for (UIView *v in view.subviews)
        {
            for (UIView*v2 in v.subviews) {
                if ([v2 isMemberOfClass:[UIImageView class]]){
                    [v2 setHidden:YES];
                }
                if ([v2 isMemberOfClass:[UIButton class]]) {
                    [v2 setHidden:YES];
                }
                if ([v2 isMemberOfClass:[CAppButton class]]) {
                    [v2 setUserInteractionEnabled:YES];
                }
            }
        }
    }
    m_bTransform = NO;
    [self EndWobble];
}

-(void)BeginWobble
{
    for (UIView *view in self.subviews)
    {
        srand([[NSDate date] timeIntervalSince1970]);
        float rand = (float)random();
        CFTimeInterval t = rand*0.0000000001;
        [UIView animateWithDuration:0.1 delay:t options:0  animations:^
         {
             view.transform = CGAffineTransformMakeRotation(-0.05);
         } completion:^(BOOL finished)
         {
             [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
              {
                  view.transform = CGAffineTransformMakeRotation(0.05);
                  
              } completion:^(BOOL finished) {}];
         }];
    }
}

-(void)EndWobble
{
    for (UIView *view in self.subviews)
    {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
         {
             view.transform = CGAffineTransformIdentity;
             for (UIView *v in view.subviews)
             {
                 if ([v isMemberOfClass:[UIImageView class]])
                     [v setHidden:YES];
             }
         } completion:^(BOOL finished) {}];
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
