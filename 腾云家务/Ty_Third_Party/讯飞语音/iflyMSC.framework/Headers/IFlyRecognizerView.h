//
//  IFlyRecognizerView.h
//  MSC
//
//  Created by admin on 13-4-16.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFlyRecognizerViewDelegate.h"

/** 语音识别控件 
 
 录音时触摸控件结束录音，开始识别（相当于旧版的停止）；触摸其他位置，取消录音，结束会话（取消）
 出错时触摸控件，重新开启会话（相当于旧版的再说一次）；触摸其他位置，取消录音，结束会话（取消）
 */
@interface IFlyRecognizerView : UIView<NSObject>

/** 设置委托对象 */
@property(nonatomic,assign)id<IFlyRecognizerViewDelegate> delegate;

/** 初始化控件
 
 @param origin 控件左上角的坐标
 @param initParam 初始化的参数，详见IFlySpeechRecognizer类初始化参数。
 @return IFlyRecognizerView 对象
 */
- (id)initWithOrigin:(CGPoint)origin;

/** 初始化控件
 
 @param center 控件中心的坐标
 @return IFlyRecognizerView 对象
 */
- (id) initWithCenter:(CGPoint)center;


/** 设置横竖屏自适应
 @param autoRotate 默认值YES，横竖屏自适应
 */
- (void) setAutoRotate:(BOOL)autoRotate;

/** 设置识别引擎的参数
 
 识别的引擎参数(key)取值如下：
 
 | 参数           | 描述
 | ------------- |------------------------------------------------------------------------------
 | domain        |应用的领域； 取值为iat、search、video、poi、music、asr；iat：普通文本听写； search：热词搜索； video：视频音乐搜索； asr：关键词识别;iat
 | vad_bos       |前端点检测；静音超时时间，即用户多长时间不说话则当做超时处理； 单位：ms； engine指定iat识别默认值为5000； 其他情况默认值为 4000，范围 0-10000。
 | vad_eos       |后断点检测；后端点静音检测时间，即用户停止说话多长时间内即认为不再输入， 自动停止录音；单位:ms，sms 识别默认值为 1800，其他默认值为 700，范围 0-10000。
 | sample_rate   |采样率，目前支持的采样率设置有 16000 和 8000。
 | asr_ptt       | 默认为 1，当设置为 0 时，将返回无标点符号文本。
 | result_type   | 返回结果的数据格式，可设置为json，xml，plain，默认为json。
 | grammarID     | 识别的语法 id，只针对 domain 设置为”asr”的应用。
 | asr_audio_path| 音频文件名 设置此参数后，将会自动保存识别的录音文件。路径为Documents/(指定值)。不设置或者设置为nil，则不保存音频。
 | params        |params：扩展参数，对于一些特殊的参数可在此设置，一般用于设置语义。
 @param key 识别引擎参数
 @param value 参数对应的取值
 
 @return 设置的参数和取值正确返回YES，失败返回NO
 */
-(BOOL) setParameter:(NSString *) value forKey:(NSString*)key;

/** 开始识别
 
 @return 成功返回YES；失败返回NO
 */
- (BOOL)start;

/** 取消本次识别  */
- (void)cancel;


@end
