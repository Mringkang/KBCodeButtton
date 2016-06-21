//
//  KBCodeButton.h
//  封装倒计时按钮
//
//  Created by kangbing on 16/6/21.
//  Copyright © 2016年 kangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KBCodeButton;
typedef NSString* (^CountDownSending)(KBCodeButton *countDownButton,NSUInteger second);
typedef NSString* (^CountDownFinished)(KBCodeButton *countDownButton,NSUInteger second);
typedef void (^TouchedCountDownButtonHandler)(KBCodeButton *sendButton,NSInteger tag);


@interface KBCodeButton : UIButton
{

    NSInteger _second;
    NSUInteger _totalSecond;

    NSTimer *_timer;
    NSDate *_startDate;
    
    CountDownSending _countDownSending;
    CountDownFinished _countDownFinished;
    TouchedCountDownButtonHandler _touchedCountDownButtonHandler;
    

}


@property(nonatomic,strong) id userInfo;

-(void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;
-(void)CountDownSending:(CountDownSending)countDownSending;
-(void)countDownFinished:(CountDownFinished)countDownFinished;


-(void)startWithSecond:(NSUInteger)second;

-(void)stopCountDown;

@end
