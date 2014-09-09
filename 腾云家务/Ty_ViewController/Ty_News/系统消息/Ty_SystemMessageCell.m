//
//  Ty_SystemMessageCell.m
//  腾云家务
//
//  Created by liu on 14-7-12.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_SystemMessageCell.h"
#import "Ty_Model_SystemMsgInfo.h"
#import "Ty_Model_RedNumInfo.h"

@implementation Ty_SystemMessageCell

@synthesize timeLabel = _timeLabel;
@synthesize headerImageView = _headerImageView;
@synthesize contentLabel = _contentLabel;
@synthesize contentBgImageView = _contentBgImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 5, 90, 20)];
        _timeLabel.backgroundColor = [UIColor colorWithRed:212.0/255 green:212.0/255 blue:212.0/255 alpha:1.0];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_timeLabel];
        
        _headerImageView = [[UIImageView alloc]init];
        [self addSubview:_headerImageView];
        
        _contentBgImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_contentBgImageView];
        _contentBgImageView.userInteractionEnabled = YES;
        [self addSubview:_contentBgImageView];
        
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.userInteractionEnabled = YES;
        _contentLabel.tag = 200;
        [_contentBgImageView addSubview:_contentLabel];
        
    }
    
    return self;
}

- (void)setContent:(Ty_Model_SystemMsgInfo *)messageInfo
{
  //  _colorfulTextView.originalString = [self anaosyStr:messageInfo.systemMsgContent];
    
   CGSize size = [messageInfo.systemMsgContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.frame.size.width - 150, 500) lineBreakMode:NSLineBreakByWordWrapping];
    
    _contentBgImageView.image = [ [UIImage imageNamed:@"Message_ReceiverTextNodeBkg_ios7"]  stretchableImageWithLeftCapWidth:40 topCapHeight:30];
    _contentBgImageView.frame = CGRectMake(60, 35, size.width + 50, size.height < 20 ? size.height + 30 : size.height + 20);
    
     [_headerImageView setFrame:CGRectMake(5, 35, 40, 40)];
    _headerImageView.image = [UIImage imageNamed:@"Message_System"];
    
    _contentLabel.frame = CGRectMake(25, 5, self.frame.size.width - 150, _contentBgImageView.frame.size.height - 15);
  //  _colorfulTextView.frame = CGRectMake(0, 5, self.frame.size.width - 150, _contentLabel.frame.size.height - 15);
    
  //  _contentLabel.text = messageInfo.systemMsgContent;
    
    if (messageInfo.systemMsg_Time.length > 0)
    {
        _timeLabel.text = [messageInfo.systemMsg_Time substringWithRange:NSMakeRange(5, 11)];
    }
    
    
    if (size.height < 40)
    {
        
        self.frame = CGRectMake(0, 0, 320, size.height + 70);
    }
    else
    {
        self.frame = CGRectMake(0, 0, 320, size.height + 55);
    }
    
    [self anaosyStr:messageInfo];
    
   // NSLog(@"%@",messageInfo.systemRedNumArr);
    
   
    
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc]initWithString:messageInfo.systemMsgContent];
    
    for (Ty_Model_RedNumInfo *redNumInfo in messageInfo.systemRedNumArr)
    {
        if (redNumInfo.redNumLocation + redNumInfo.redNumStr.length < messageInfo.systemMsgContent.length)
        {
           // NSLog(    @"%d-- %@",redNumInfo.redNumLocation,redNumInfo.redNumStr);
//           [contentStr addAttribute:NSForegroundColorAttributeName
//                              value:[UIColor redColor]
//                              range:NSMakeRange(redNumInfo.redNumLocation,redNumInfo.redNumStr.length)];
//           [contentStr addAttribute:NSUnderlineStyleAttributeName
//                              value:[NSNumber numberWithInt:NSUnderlineStyleSingle] // 添加下划线
//                              range:NSMakeRange(redNumInfo.redNumLocation,redNumInfo.redNumStr.length)];
            
            if (redNumInfo.redNumStr.length == 11)
            {
               // NSLog(@"我是手机号码:%@",redNumInfo.redNumStr);
                [contentStr addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor redColor]
                                   range:NSMakeRange(redNumInfo.redNumLocation,redNumInfo.redNumStr.length)];
                [contentStr addAttribute:NSUnderlineStyleAttributeName
                                   value:[NSNumber numberWithInt:NSUnderlineStyleSingle] // 添加下划线
                                   range:NSMakeRange(redNumInfo.redNumLocation,redNumInfo.redNumStr.length)];
              //  [self addAttribute:(NSString*)kCTParagraphStyleAttributeName value:(id)aStyle range:textRange];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:redNumInfo.redNumStr,@"phoneNum", nil];
                [contentStr addAttributes:dic range:NSMakeRange(redNumInfo.redNumLocation, redNumInfo.redNumStr.length)];
                
                
               
            }
            else if ([redNumInfo.redNumStr isEqualToString:@"4000049121"])
            {
                [contentStr addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor redColor]
                                   range:NSMakeRange(redNumInfo.redNumLocation,redNumInfo.redNumStr.length)];
                [contentStr addAttribute:NSUnderlineStyleAttributeName
                                   value:[NSNumber numberWithInt:NSUnderlineStyleSingle] // 添加下划线
                                   range:NSMakeRange(redNumInfo.redNumLocation,redNumInfo.redNumStr.length)];
                //  [self addAttribute:(NSString*)kCTParagraphStyleAttributeName value:(id)aStyle range:textRange];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:redNumInfo.redNumStr,@"serviceNum", nil];
                [contentStr addAttributes:dic range:NSMakeRange(redNumInfo.redNumLocation, redNumInfo.redNumStr.length)];
            }
            /*
            else if ([redNumInfo.redNumStr isEqualToString:@"-"])
            {
                NSString *str1 = [messageInfo.systemMsgContent substringWithRange:NSMakeRange(redNumInfo.redNumLocation - 3, 3)];
                NSString *str2 = [messageInfo.systemMsgContent substringWithRange:NSMakeRange(redNumInfo.redNumLocation + 1, 8)];
                
                NSString *test = @"^\\d+$";
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", test];
                if ([pred evaluateWithObject:str1] && [pred evaluateWithObject:str2])
                {
                    NSLog(@"我是手机号码:%@",redNumInfo.redNumStr);

                }
                
            }
             */
        }
        
    }
    

    
    _contentLabel.attributedText = contentStr;
    
    
}



-(NSString *)anaosyStr:(Ty_Model_SystemMsgInfo *)messageInfo
{
    [messageInfo.systemRedNumArr removeAllObjects];
    
    NSMutableString *retStr = [NSMutableString string];
    
    NSScanner *scanner = [NSScanner scannerWithString:messageInfo.systemMsgContent];
    while (![scanner isAtEnd])
    {
        NSString *otherStr;
        [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:&otherStr];
    
        if (otherStr != nil && otherStr.length > 0)
        {
            if ([otherStr isEqualToString:@":"] || [otherStr isEqualToString:@"-"])
            {

             //   [retStr appendString:[NSString stringWithFormat:@"{<color=#FF7775,clicktype=%@>%@}",otherStr,otherStr]];
                Ty_Model_RedNumInfo *redNumInfo = [[Ty_Model_RedNumInfo alloc]init];
                redNumInfo.redNumLocation = scanner.scanLocation -1 ;
                redNumInfo.redNumStr = otherStr;
                [messageInfo.systemRedNumArr addObject:redNumInfo];
                redNumInfo = nil;
                
               // NSLog(@"")
            }
            else
       
            {
                // [retStr appendString:otherStr];
            }
            

        }
        else
        {
           // [retStr appendString:@" "];
            Ty_Model_RedNumInfo *redNumInfo = [[Ty_Model_RedNumInfo alloc]init];
            redNumInfo.redNumLocation = scanner.scanLocation;
            redNumInfo.redNumStr = otherStr;
            [messageInfo.systemRedNumArr addObject:redNumInfo];
            redNumInfo = nil;
        }
        
               //        NSInteger index = scanner.scanLocation;
        NSString *tempStr;
        
        [scanner scanCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:&tempStr];
     
        
        if (!ISNULLSTR(tempStr))
        {
            
          //  NSLog(@"content : %@", tempStr);
           // [retStr appendString:[NSString stringWithFormat:@"{<color=#FF7775,clicktype=%@>%@}",tempStr,tempStr]];
            
            Ty_Model_RedNumInfo *redNumInfo = [[Ty_Model_RedNumInfo alloc]init];
            redNumInfo.redNumLocation = scanner.scanLocation - tempStr.length;
            redNumInfo.redNumStr = tempStr;
            [messageInfo.systemRedNumArr addObject:redNumInfo];
            redNumInfo = nil;
        }
        else
        {
            //[retStr appendString:@" "];
            Ty_Model_RedNumInfo *redNumInfo = [[Ty_Model_RedNumInfo alloc]init];
            redNumInfo.redNumStr = @" ";
            redNumInfo.redNumLocation = scanner.scanLocation - tempStr.length;
            [messageInfo.systemRedNumArr addObject:redNumInfo];
            redNumInfo = nil;
        }
        
       
    }
    
    return retStr;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view.tag == 200)
    {
       // NSLog(@"我是label");
        CGPoint touchPoint = [touch locationInView:_contentLabel];
        NSInteger index = [self getAttributedStringLineWithString:_contentLabel.attributedText touchPoint:touchPoint];
       // NSLog(@"%f---%f",touchPoint.x,touchPoint.y);
        if ( index > -1 && index < _contentLabel.attributedText.length )
        {
            NSDictionary *dic = [_contentLabel.attributedText attributesAtIndex:index effectiveRange:NSPointerFunctionsStrongMemory];
         //   NSLog(@"%@",dic);
            if ([dic.allKeys containsObject:@"phoneNum"])
            {
                UIWebView * callWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
                [self addSubview:callWebView];
                NSURL *callUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[dic objectForKey:@"phoneNum"]]];
                [callWebView loadRequest:[NSURLRequest requestWithURL:callUrl]];
            }
            else if ([dic.allKeys containsObject:@"serviceNum"])
            {
                UIWebView * callWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
                [self addSubview:callWebView];
                NSURL *callUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[dic objectForKey:@"serviceNum"]]];
                [callWebView loadRequest:[NSURLRequest requestWithURL:callUrl]];
            }
           
        }
    }
    else
    {
       // NSLog(@"我不是label");
    }
    
}

- (int)getAttributedStringLineWithString:(NSMutableAttributedString *)string touchPoint:(CGPoint)touchPoint
{
    int total_height = 0;
    
    [string addAttribute:(NSString *)kCTFontAttributeName
                   value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont boldSystemFontOfSize:14].fontName,14,NULL))
                        range:NSMakeRange(0, string.length)];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, _contentLabel.frame.size.width, _contentLabel.frame.size.height);  //这里的高要设置足够大
    
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)[UIFont systemFontOfSize:14].fontName,14,NULL);
                                             
     
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);

    int lineIndex = -1;
    for (int i = 0; i < linesArray.count ; i ++)
    {
        
        float line_y = (float) origins[linesArray.count - 1 - i ].y;
      //  NSLog(@"%f-- %f",touchPoint.y,line_y);
        if (touchPoint.y <= line_y && touchPoint.y > line_y - 15 )
        {
            lineIndex = i;
            
            break;
        }
        
        
        
    }
    
    NSLog(@"%d",lineIndex);
    
    NSInteger index = -1;
    
    if (lineIndex > -1)
    {
        CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:(lineIndex) ];
        
        index =  CTLineGetStringIndexForPosition(line, touchPoint);
        
    }
    
    
    return index;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
