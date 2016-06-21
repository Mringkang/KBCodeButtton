//
//  KBCodeButton.m
//  封装倒计时按钮
//
//  Created by kangbing on 16/6/21.
//  Copyright © 2016年 kangbing. All rights reserved.
//

#import "KBCodeButton.h"

@implementation KBCodeButton


-(void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler{
    _touchedCountDownButtonHandler = [touchedCountDownButtonHandler copy];

    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touched:(KBCodeButton *)sender{
    
    if (_touchedCountDownButtonHandler) {
        _touchedCountDownButtonHandler(sender,sender.tag);
    }
}

#pragma -mark count down method
- (void)startWithSecond:(NSUInteger)second
{
    
    
    _totalSecond = second;
    _second = second;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}


-(void)timerStart:(NSTimer *)theTimer {
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    
    _second = _totalSecond - (NSInteger)(deltaTime+0.5) ;
    
    
    if (_second< 0.0)
    {
        [self stopCountDown];
    }
    else
    {
        if (_countDownSending)
        {
            [self setTitle:_countDownSending(self,_second) forState:UIControlStateNormal];
            [self setTitle:_countDownSending(self,_second) forState:UIControlStateDisabled];
            
        }
        else
        {
            NSString *title = [NSString stringWithFormat:@"%zd秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
            
        }
        

        
    }
}

- (void)stopCountDown{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _second = _totalSecond;
                if (_countDownFinished)
                {
                    [self setTitle:_countDownFinished(self,_totalSecond)forState:UIControlStateNormal];
                    [self setTitle:_countDownFinished(self,_totalSecond)forState:UIControlStateDisabled];
                    
                }
                else
                {   
                    [self setTitle:@"点击重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"点击重新获取" forState:UIControlStateDisabled];
                    
                }
            }
        }
    }
}
#pragma -mark block
- (void)CountDownSending:(CountDownSending)countDownSending{
    _countDownSending = [countDownSending copy];
}
-(void)countDownFinished:(CountDownFinished)countDownFinished{
    _countDownFinished = [countDownFinished copy];
}



@end


