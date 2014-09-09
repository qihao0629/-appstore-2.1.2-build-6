//
//  Ty_UPPayView.m
//  腾云家务
//
//  Created by liu on 14-7-1.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_UPPayView.h"

@implementation Ty_UPPayView

@synthesize serviceImageView = _serviceImageView;
@synthesize serviceNameLabel = _serviceNameLabel;
@synthesize servicePhoneLabel = _servicePhoneLabel;
@synthesize payMoneyTextField = _payMoneyTextField;
@synthesize totalMoneyLabel = _totalMoneyLabel;
@synthesize payBtn = _payBtn;
@synthesize payDirectBtn = _payDirectBtn;
@synthesize phoneBtn = _phoneBtn;
@synthesize phoneTitleBtn = _phoneTitleBtn;
@synthesize phoneNumBtn = _phoneNumBtn;
@synthesize totalLabel = _totalLabel;
@synthesize moneyTypeLabel =_moneyTypeLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
        //中介头像
        _serviceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 23, 23)];
        _serviceImageView.image = [UIImage imageNamed:@"UPPay_Service_Img"];
        [self addSubview:_serviceImageView];
    
        //中介名称
        _serviceNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, 200, 20)];
        _serviceNameLabel.backgroundColor = [UIColor clearColor];
        _serviceNameLabel.font = [UIFont boldSystemFontOfSize:16];
        _serviceNameLabel.textColor = [UIColor blackColor];
        _serviceNameLabel.text = @"爱君家政早教部";
        [self addSubview:_serviceNameLabel];
        
        
        UIImageView *phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 52, 24, 24)];
        phoneImageView.image = [UIImage imageNamed:@"UPPay_ServicePhone_Img"];
       // [self addSubview:phoneImageView];
        
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneBtn.frame = CGRectMake(12, 52, 24, 24);
        [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"UPPay_ServicePhone_Img"] forState:UIControlStateNormal];
        [self addSubview:_phoneBtn];
        
        
        //商户电话
        /*
        UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 58, 150, 20)];
        phoneLabel.backgroundColor = [UIColor clearColor];
        phoneLabel.font = [UIFont boldSystemFontOfSize:16];
        phoneLabel.textColor = [UIColor blackColor];
        phoneLabel.text = @"商户电话:";
        //[self addSubview:phoneLabel];
       */
        
        _phoneTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneTitleBtn.frame = CGRectMake(40, 58, 71, 20);
        [_phoneTitleBtn setTitle:@"商户电话:" forState:UIControlStateNormal];
        [_phoneTitleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _phoneTitleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:_phoneTitleBtn];
        
        
        /*
        _servicePhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 58, 200, 20)];
        _servicePhoneLabel.backgroundColor = [UIColor clearColor];
        _servicePhoneLabel.font = [UIFont boldSystemFontOfSize:16];
        _servicePhoneLabel.textColor = [UIColor blackColor];
        _servicePhoneLabel.text = @"18500300641";
        [self addSubview:_servicePhoneLabel];
        */
        _phoneNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _phoneNumBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:_phoneNumBtn];
        
        
        /*
        CGSize size = [_servicePhoneLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:16] forWidth:200 lineBreakMode:NSLineBreakByWordWrapping];
        
        _lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(13, 78, _servicePhoneLabel.frame.origin.x + size.width - 12, 2)];
        _lineImageView.backgroundColor = [UIColor colorWithRed:244.0/255 green:28.0/255 blue:32.0/255 alpha:1.0];
        [self addSubview:_lineImageView];
         */
        
        _lineImageView = [[UIImageView alloc]init];
        _lineImageView.backgroundColor = [UIColor colorWithRed:244.0/255 green:28.0/255 blue:32.0/255 alpha:1.0];
        [self addSubview:_lineImageView];
        
        /******************************商户信息结束*****************************************/
        
        _tmpView = [[UIView alloc]initWithFrame:CGRectMake(0, 98, self.frame.size.width, 260)];
        _tmpView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_tmpView];
        
        
        
        //合计
        _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(7, 10, 90, 20)];
        _totalLabel.backgroundColor = [UIColor clearColor];
        _totalLabel.font = [UIFont boldSystemFontOfSize:14];
        _totalLabel.textColor = [UIColor blackColor];
        _totalLabel.text = @"订单金额 ：";
        [_tmpView addSubview:_totalLabel];
        
        _moneyTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(77, 10, 20, 20)];
        _moneyTypeLabel.backgroundColor = [UIColor clearColor];
        _moneyTypeLabel.font = [UIFont boldSystemFontOfSize:14];
        _moneyTypeLabel.textColor = [UIColor redColor];
        _moneyTypeLabel.text = @"￥";
        [_tmpView addSubview:_moneyTypeLabel];
        
        _totalMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 190, 20)];
        _totalMoneyLabel.backgroundColor = [UIColor clearColor];
        _totalMoneyLabel.font = [UIFont boldSystemFontOfSize:14];
        _totalMoneyLabel.textColor = [UIColor colorWithRed:244.0/255 green:28.0/255 blue:32.0/255 alpha:1.0];
        _totalMoneyLabel.textAlignment = NSTextAlignmentLeft;
        [_tmpView addSubview:_totalMoneyLabel];
        
        _remindLabel0 = [[UILabel alloc]initWithFrame:CGRectMake(7, 35, 90, 20)];
        _remindLabel0.backgroundColor = [UIColor clearColor];
        _remindLabel0.textColor = [UIColor colorWithRed:244.0/255 green:28.0/255 blue:32.0/255 alpha:1.0];
        _remindLabel0.text = @"友情提示 ：";
        _remindLabel0.font = [UIFont boldSystemFontOfSize:14];
        [_tmpView addSubview:_remindLabel0];
        
        _remindLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(77, 35, 200, 20)];
        _remindLabel1.backgroundColor = [UIColor clearColor];
        _remindLabel1.textColor = [UIColor colorWithRed:244.0/255 green:28.0/255 blue:32.0/255 alpha:1.0];
        _remindLabel1.text = @"1)请在服务完成后再进行付款";
        _remindLabel1.font = [UIFont boldSystemFontOfSize:14];
        [_tmpView addSubview:_remindLabel1];
        
        _remindLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(77, 55, 240, 40)];
        _remindLabel2.backgroundColor = [UIColor clearColor];
        _remindLabel2.textColor = [UIColor colorWithRed:244.0/255 green:28.0/255 blue:32.0/255 alpha:1.0];
        _remindLabel2.text = @"2)请按实际情况输入金额到下方输入框再进行支付";
        _remindLabel2.font = [UIFont boldSystemFontOfSize:14];
        _remindLabel2.numberOfLines = 0;
        [_tmpView addSubview:_remindLabel2];
        
  
        //付款金额
        _payTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 105, 100, 20)];
        _payTitleLabel.backgroundColor = [UIColor clearColor];
        _payTitleLabel.font = [UIFont boldSystemFontOfSize:15];
        _payTitleLabel.textColor = [UIColor blackColor];
        _payTitleLabel.text = @"付款金额:";
        [_tmpView addSubview:_payTitleLabel];
        
        _payMoneyTextField = [[UITextField alloc]initWithFrame:CGRectMake(95, 100, 300 - 95, 35)];
        _payMoneyTextField.borderStyle = UITextBorderStyleRoundedRect;
        _payMoneyTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _payMoneyTextField.placeholder = @"请输入实付金额";
        _payMoneyTextField.keyboardType = UIKeyboardTypeNumberPad;
        _payMoneyTextField.textColor = [UIColor blackColor];
        _payMoneyTextField.font = [UIFont systemFontOfSize:15];
        [_tmpView addSubview:_payMoneyTextField];
        
        
        //支付按钮
        _payBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //_payBtn.frame = CGRectMake(40, 140, 240, 38);
        _payBtn.frame = CGRectMake(10, 150, 300, 40);
        [_payBtn setTitle:@"使用网银支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_payBtn setBackgroundImage:[UIImage imageNamed:@"UPPay_PayRedBtn_Image"] forState:UIControlStateNormal];
        //_payBtn.userInteractionEnabled = NO;
        //_payBtn.backgroundColor = [UIColor grayColor];
        
        [_tmpView addSubview:_payBtn];
        
        _payDirectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       // _payDirectBtn.frame = CGRectMake(40, 195, 240, 38);
        _payDirectBtn.frame = CGRectMake(10, 208, 300, 40);
        [_payDirectBtn setBackgroundImage:[UIImage imageNamed:@"UPPay_PayBtn_Image"] forState:UIControlStateNormal];
        [_payDirectBtn setTitle:@"我已现金支付" forState:UIControlStateNormal];
        [_payDirectBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _payDirectBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_tmpView addSubview:_payDirectBtn];
        
        
        _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        _headerImageView.backgroundColor = [UIColor colorWithRed:207.0/255 green:207.0/255 blue:207.0/255 alpha:1.0];
        [_tmpView addSubview:_headerImageView];
        
        _footerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 260, self.frame.size.width, 1)];
        _footerImageView.backgroundColor = [UIColor colorWithRed:207.0/255 green:207.0/255 blue:207.0/255 alpha:1.0];
        [_tmpView addSubview:_footerImageView];
        
        
    }
    return self;
}

- (void)setContent:(Ty_Model_XuQiuInfo *)xuqiuInfo
{
    _serviceNameLabel.text = xuqiuInfo.serverObject.respectiveCompanies;
    
    NSRange range = [xuqiuInfo.priceUnit rangeOfString:@"-"];
    if (xuqiuInfo.priceUnit.length > 0 && xuqiuInfo.priceUnit != NULL && range.length == 0 )
    {
        
        if ([xuqiuInfo.workAmount intValue] != 0)
        {
            int workAmount = xuqiuInfo.workAmount.intValue;
            int price = [xuqiuInfo.priceUnit intValue];
            int totalPrice = workAmount * price;
            int cutPrice = 0;
            if (![xuqiuInfo.usedCouponInfo.couponRequiremnetGuid isEqualToString:@""])
            {
                cutPrice = [xuqiuInfo.usedCouponInfo.couponCutPrice integerValue];
            }
            
            totalPrice = totalPrice - cutPrice;
            if (totalPrice < 0)
            {
                totalPrice = 0;
            }
            
            _totalMoneyLabel.text = [NSString stringWithFormat:@"%d.00元",totalPrice];
        }
        else
        {
           _totalMoneyLabel.text = @"0.00元";
        }
    }
    else
    {
        _totalMoneyLabel.text = @"0.00元";
    }
    
    
    
     [_phoneNumBtn setTitle:xuqiuInfo.serverObject.companyPhoneNumber forState:UIControlStateNormal];
    CGSize size = [_phoneNumBtn.titleLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:16] forWidth:200 lineBreakMode:NSLineBreakByWordWrapping];
    _phoneNumBtn.frame = CGRectMake(110, 58, size.width, 20) ;
    _lineImageView.frame = CGRectMake(13, 78, _phoneNumBtn.frame.origin.x + size.width - 12, 2);
   // _lineImageView.frame = CGRectMake(110, 78,  size.width + 2, 2);
    
    if ([xuqiuInfo.requirement_Type integerValue]== 1)//直接预约
    {
        _totalMoneyLabel.hidden = YES;
        _moneyTypeLabel.hidden = YES;
        _totalLabel.hidden = YES;
        
        _remindLabel0.frame = CGRectMake(_remindLabel0.frame.origin.x, _remindLabel0.frame.origin.y - 25, _remindLabel0.frame.size.width, _remindLabel0.frame.size.height);
        _remindLabel1.frame = CGRectMake(_remindLabel1.frame.origin.x, _remindLabel1.frame.origin.y - 25, _remindLabel1.frame.size.width, _remindLabel1.frame.size.height);
        _remindLabel2.frame = CGRectMake(_remindLabel2.frame.origin.x, _remindLabel2.frame.origin.y - 25, _remindLabel2.frame.size.width, _remindLabel2.frame.size.height);
        _payTitleLabel.frame = CGRectMake(_payTitleLabel.frame.origin.x, _payTitleLabel.frame.origin.y - 25, _payTitleLabel.frame.size.width, _payTitleLabel.frame.size.height);
        _payMoneyTextField.frame = CGRectMake(_payMoneyTextField.frame.origin.x, _payMoneyTextField.frame.origin.y - 25, _payMoneyTextField.frame.size.width, _payMoneyTextField.frame.size.height);
        _payDirectBtn.frame = CGRectMake(_payDirectBtn.frame.origin.x, _payDirectBtn.frame.origin.y - 25, _payDirectBtn.frame.size.width, _payDirectBtn.frame.size.height);
        _payBtn.frame = CGRectMake(_payBtn.frame.origin.x, _payBtn.frame.origin.y - 25, _payBtn.frame.size.width, _payBtn.frame.size.height);
        _footerImageView.frame = CGRectMake(_footerImageView.frame.origin.x, _footerImageView.frame.origin.y - 25, _footerImageView.frame.size.width, _footerImageView.frame.size.height);
        _tmpView.frame = CGRectMake(_tmpView.frame.origin.x, _tmpView.frame.origin.y , _tmpView.frame.size.width, _tmpView.frame.size.height - 25);
    }
    else
    {
        
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
