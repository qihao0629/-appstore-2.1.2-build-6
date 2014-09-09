//
//  TYNavigationTool.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYNavigationTool.h"
#define TYMOVEWIDTH    100
@implementation TYNavigationTool
+ (TYNavigationTool *)shareNav
{
    static dispatch_once_t  onceToken;
    
    dispatch_once(&onceToken, ^{
        
        navTool = [[TYNavigationTool alloc]init];
        
    });
    return navTool;
}

-(id)init{
    
    self = [super init];
    if(self){
        viewControllerArray = [[NSMutableArray alloc] initWithCapacity:10];
        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
        [viewControllerArray addObject:window.rootViewController];
       
    }
    return self;
}
-(NSMutableArray*)viewControllerArray
{
    return viewControllerArray;
}
- (void)removeViewControllersFromWindow:(NSArray* )viewControllers
{
    for (int i = 0; i<viewControllers.count; i++) {
        [[viewControllers[i] view] removeFromSuperview];
        [viewControllerArray removeObject:viewControllers[i]];
    }
}
-(TYBaseView * )topViewController{
    return  [viewControllerArray lastObject];
}

-(UIView *)topView{
    
    return [[self topViewController] view];
    
}
-(TYBaseView*)bottomViewController
{
    if (viewControllerArray.count>=2) {
        
        return [viewControllerArray objectAtIndex:viewControllerArray.count-2];
    }else{
        return nil;
    }
}


-(UIView *)bottomView{
    return [[self bottomViewController] view];
}


-(TYBaseView*)rootViewController
{
    return [viewControllerArray objectAtIndex:0];
}


-(UIView *)rootView{
    return [[viewControllerArray objectAtIndex:0] view];
}



-(void)pushViewController:(UIViewController *)vc withAnimation:(BOOL)isAnimation{
    
    [viewControllerArray addObject:vc];
    
    float duration = 0.0f;
    if (isAnimation) {
        duration = 0.25f;
    }
    
    [self addGesture:[self topView]];
    
    if (IOS7) {
        vc.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }else{
        vc.view.frame = CGRectMake(SCREEN_WIDTH, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20);
    }
    
    UIWindow * iv = [[[UIApplication sharedApplication] delegate] window];
    [iv addSubview:vc.view];
    [self viewPush:duration];
    
}



-(void)popViewControllerWithAnimation:(BOOL)isAnimation{
    
    float duration = 0.0f;
    if (isAnimation) {
        duration = 0.25f;
    }
    
    [self viewPop:duration];
    
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)isAnimation
{
    int index = [viewControllerArray indexOfObject:viewController];
    
    for (int i = viewControllerArray.count-2; i>index; i--) {
        [[viewControllerArray[i] view] removeFromSuperview];
        [viewControllerArray removeObjectAtIndex:i];
    }
    float duration = 0.0f;
    if (isAnimation) {
        duration = 0.25f;
    }
    [self viewPop:duration];
    
}
- (void)popToRootViewControllerAnimated:(BOOL)isAnimation
{
    for (int i = viewControllerArray.count-2; i>0; i--) {
        [[viewControllerArray[i] view] removeFromSuperview];
        [viewControllerArray removeObjectAtIndex:i];
    }
    float duration = 0.0f;
    if (isAnimation) {
        duration = 0.25f;
    }
    [self viewPop:duration];
}

-(void)viewPush:(float)duration{
    
    TYBaseView* bottomVC = [self bottomViewController];
    [UIView animateWithDuration:duration animations:^{
        [[self bottomViewController] viewWillDisappear:YES];
        [[self bottomView] setUserInteractionEnabled:NO];
        [self topView].frame = CGRectMake(0, [[self topView] frame].origin.y, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self bottomView].frame = CGRectMake(-TYMOVEWIDTH,[[self bottomView] frame].origin.y, SCREEN_WIDTH, SCREEN_HEIGHT);
    }completion:^(BOOL finished) {
        [bottomVC viewDidDisappear:YES];
    }];
    
}
-(void)viewPop:(float)duration{
    
    TYBaseView * topVC = [self topViewController];
    TYBaseView * bottomVC = [self bottomViewController];
    if (viewControllerArray.count >= 2){
                
        [UIView animateWithDuration:duration animations:^{
            [[self bottomViewController]viewWillAppear:YES];
            [[self topViewController] viewWillDisappear:YES];
            [self topView].frame = CGRectMake(SCREEN_WIDTH, [[self topView] frame].origin.y, SCREEN_WIDTH, SCREEN_HEIGHT);
            [self bottomView].frame = CGRectMake(0, [[self bottomView] frame].origin.y, SCREEN_WIDTH, SCREEN_HEIGHT);
          //  NSLog(@"22");
            [self bottomView].userInteractionEnabled = YES;
            [viewControllerArray removeLastObject];
        } completion:^(BOOL finished) {
            NSLog(@"viewControllerArray = %@",viewControllerArray);
            [topVC viewDidDisappear:YES];
            [bottomVC viewDidAppear:YES];
            [topVC.view removeFromSuperview];
        }];
    }
    topVC = nil;
    bottomVC = nil;
}

-(void)addGesture:(UIView *)pushView{

    if ([[[self topViewController] superclass] isSubclassOfClass:[TYBaseView class]] )
    {
        NSLog(@"~~~~~~");
        if ([[self topViewController] slidingBackbool])
        {
           UIPanGestureRecognizer *ty_Gescongizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(viewMoving:)];
            ty_Gescongizer.delegate = self;
            ty_Gescongizer.maximumNumberOfTouches = 1;
            [pushView addGestureRecognizer:ty_Gescongizer];
        }
    }
    
   /*
    if ([[[self topViewController] superclass] isMemberOfClass:[TYBaseView class]]) {
        if ([[self topViewController] slidingBackbool]) {
            [pushView addGestureRecognizer:ges];
        }
    }
    */
}
-(void)setSlidingBack:(BOOL)_isOpen View:(UIView*)_view
{
    if (_isOpen) {
        [self addGesture:_view];
    }else{
        if ([_view gestureRecognizers].count>0) {
            [_view removeGestureRecognizer:[_view gestureRecognizers][0]];
        }
    }
}

-(void)viewMoving:(UIPanGestureRecognizer *)ges{
    
    CGPoint point = [ges translationInView:[self topView]];
    float relativeX = point.x;
    if (relativeX >= 0) {
        [self topView].frame = CGRectMake(relativeX, [[self topView] frame].origin.y, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self bottomView].frame = CGRectMake(TYMOVEWIDTH*(relativeX/SCREEN_WIDTH)-TYMOVEWIDTH, [[self bottomView] frame].origin.y, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self bottomView].userInteractionEnabled = NO;
        if (ges.state == UIGestureRecognizerStateBegan) {
            [[self topViewController] viewWillbackAction];
        }
    }

    if (ges.state == UIGestureRecognizerStateEnded) {
        
        if (TYFRAMEX([self topView])>SCREEN_WIDTH/2.0) {
//            [self bottomView].userInteractionEnabled = YES;
            [self viewPop:0.25f];
            
            
        }else{
//            [self bottomView].userInteractionEnabled = NO;
            [self viewPush:0.25f];
            
        }
        
    }
    if (ges.state == UIGestureRecognizerStateCancelled) {
        if (TYFRAMEX([self topView])>SCREEN_WIDTH/2.0) {
//            [self bottomView].userInteractionEnabled = YES;
            [self viewPop:0.25f];
            
            
        }else{
//            [self bottomView].userInteractionEnabled = NO;
            [self viewPush:0.25f];
            
            
        }
    }
}

#pragma mark --- gestureRecognizer delegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
}


@end
