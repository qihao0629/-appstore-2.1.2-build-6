//
//  CustomLabel.m
//  腾云家务
//
//  Created by 齐 浩 on 13-9-23.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel
@synthesize startLabel;
@synthesize centerLabel;
@synthesize endLabel;
@synthesize text;
-(NSString* )text
{
    return [NSString stringWithFormat:@"%@%@%@",startLabel.text,centerLabel.text,endLabel.text];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        
        startLabel = [[UILabel alloc]init];
        startLabel.backgroundColor = [UIColor clearColor];
        startLabel.lineBreakMode = NSLineBreakByCharWrapping;
        startLabel.numberOfLines = 0;
        startLabel.highlightedTextColor = [UIColor whiteColor];
        //startLabel.font = font;
        [self addSubview:startLabel];
        
        
        centerLabel = [[UILabel alloc]init];
        centerLabel.backgroundColor = [UIColor clearColor];
        centerLabel.numberOfLines = 0;
        centerLabel.highlightedTextColor = [UIColor whiteColor];
        centerLabel.lineBreakMode = NSLineBreakByCharWrapping;
        //    redLabel.font = [UIFont boldSystemFontOfSize:FontSize];
        [self addSubview:centerLabel];
        
        endLabel = [[UILabel alloc]init];
        endLabel.backgroundColor = [UIColor clearColor];
        endLabel.numberOfLines = 0;
        endLabel.highlightedTextColor = [UIColor whiteColor];
        endLabel.lineBreakMode = NSLineBreakByCharWrapping;
        //  endLabel.font = [UIFont boldSystemFontOfSize:FontSize];
        [self addSubview:endLabel];
    }
    return self;
}

- (void)initWithStratString:(NSString *)_startSting startColor:(UIColor*)_startColor startFont:(UIFont*)_startFont centerString:(NSString *)_centerString centerColor:(UIColor*)_centerColor centerFont:(UIFont*)_centerFont endString:(NSString *)_endString endColor:(UIColor*)_endColor endFont:(UIFont* )_endFont;
{
//    NSLog(@"c = %f,x = %f,l = %f,p = %f",_startFont.capHeight,_startFont.xHeight,_startFont.lineHeight,_startFont.pointSize);
    
    CGSize startSize = [_startSting sizeWithFont:_startFont constrainedToSize:CGSizeMake(self.frame.size.width, _startFont.pointSize) lineBreakMode:NSLineBreakByCharWrapping];
    
    CGSize cenSize = [_centerString sizeWithFont:_centerFont constrainedToSize:CGSizeMake(self.frame.size.width, _centerFont.pointSize) lineBreakMode:NSLineBreakByCharWrapping];
    
    CGSize endSize = [_endString sizeWithFont:_endFont constrainedToSize:CGSizeMake(self.frame.size.width, _endFont.pointSize) lineBreakMode:NSLineBreakByCharWrapping];
    
    startLabel.frame = CGRectMake(0, (self.frame.size.height-startSize.height)/2, startSize.width , startSize.height);
    centerLabel.frame = CGRectMake( startLabel.frame.size.width, (self.frame.size.height-startSize.height)/2, cenSize.width, cenSize.height);
    endLabel.frame = CGRectMake(startLabel.frame.size.width + centerLabel.frame.size.width, (self.frame.size.height-startSize.height)/2, endSize.width + 2, endSize.height);

//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, startSize.width+cenSize.width+endSize.width, self.frame.size.height);
    
    
    
    startLabel.font = _startFont;
    centerLabel.font = _centerFont;
    endLabel.font = _endFont;
    
    startLabel.textColor = _startColor;
    centerLabel.textColor = _centerColor;
    endLabel.textColor = _endColor;

    startLabel.text = _startSting;
    centerLabel.text = _centerString;
    endLabel.text = _endString;
    

    startLabel.highlightedTextColor = [UIColor whiteColor];
    centerLabel.highlightedTextColor = [UIColor whiteColor];
    endLabel.highlightedTextColor = [UIColor whiteColor];
    
    
    

}
-(void)setstartLabelFrame:(int)_i
{
    startLabel.frame = CGRectMake(_i, self.startLabel.frame.origin.y, startLabel.frame.size.width , startLabel.frame.size.height);
    centerLabel.frame = CGRectMake( startLabel.frame.size.width+startLabel.frame.origin.x, self.centerLabel.frame.origin.y, centerLabel.frame.size.width, centerLabel.frame.size.height);
    endLabel.frame = CGRectMake(startLabel.frame.origin.x+startLabel.frame.size.width + centerLabel.frame.size.width, self.endLabel.frame.origin.y, endLabel.frame.size.width , endLabel.frame.size.height);
}
-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    if (textAlignment == NSTextAlignmentLeft) {
        
    }else if(textAlignment == NSTextAlignmentCenter){
        int _i = (self.frame.size.width-startLabel.frame.size.width-centerLabel.frame.size.width-endLabel.frame.size.width)/2;
        startLabel.frame = CGRectMake(_i, self.startLabel.frame.origin.y, startLabel.frame.size.width , startLabel.frame.size.height);
        centerLabel.frame = CGRectMake( startLabel.frame.size.width+startLabel.frame.origin.x, self.centerLabel.frame.origin.y, centerLabel.frame.size.width, centerLabel.frame.size.height);
        endLabel.frame = CGRectMake(startLabel.frame.origin.x+startLabel.frame.size.width + centerLabel.frame.size.width, self.endLabel.frame.origin.y, endLabel.frame.size.width , endLabel.frame.size.height);
        
    }else if(textAlignment == NSTextAlignmentRight){
        int _i = (self.frame.size.width-startLabel.frame.size.width-centerLabel.frame.size.width-endLabel.frame.size.width);
        startLabel.frame = CGRectMake(_i, self.startLabel.frame.origin.y, startLabel.frame.size.width , startLabel.frame.size.height);
        centerLabel.frame = CGRectMake( startLabel.frame.size.width+startLabel.frame.origin.x, self.centerLabel.frame.origin.y, centerLabel.frame.size.width, centerLabel.frame.size.height);
        endLabel.frame = CGRectMake(startLabel.frame.origin.x+startLabel.frame.size.width + centerLabel.frame.size.width, self.endLabel.frame.origin.y, endLabel.frame.size.width , endLabel.frame.size.height);
    }
}
-(void)setVerticalAlignment:(UIControlContentVerticalAlignment)textVerticalAlignment
{
    if (textVerticalAlignment == UIControlContentVerticalAlignmentCenter) {
        
    }else if(textVerticalAlignment == UIControlContentVerticalAlignmentTop){
        
    }else if(textVerticalAlignment == UIControlContentVerticalAlignmentBottom){
        int _i = self.frame.size.height;
        startLabel.frame = CGRectMake(self.startLabel.frame.origin.x, _i-self.startLabel.frame.size.height, startLabel.frame.size.width , startLabel.frame.size.height);
        centerLabel.frame = CGRectMake( startLabel.frame.size.width+startLabel.frame.origin.x+2, _i-self.centerLabel.frame.size.height, centerLabel.frame.size.width, centerLabel.frame.size.height);
        endLabel.frame = CGRectMake(startLabel.frame.origin.x+startLabel.frame.size.width + centerLabel.frame.size.width+2+2, _i-self.endLabel.frame.size.height, endLabel.frame.size.width , endLabel.frame.size.height);
    }else if(textVerticalAlignment == UIControlContentVerticalAlignmentFill){
    
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
