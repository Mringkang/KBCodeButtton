//
//  ViewController.m
//  封装倒计时按钮
//
//  Created by kangbing on 16/6/21.
//  Copyright © 2016年 kangbing. All rights reserved.
//

#import "ViewController.h"
#import "KBCodeButton.h"

@interface ViewController (){

    KBCodeButton *_countDownCode;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    _countDownCode = [KBCodeButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.frame = CGRectMake(81, 200, 108, 32);
    [_countDownCode setTitle:@"开始" forState:UIControlStateNormal];
    _countDownCode.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_countDownCode];
    
    
    //  点击事件
    [_countDownCode countDownButtonHandler:^(KBCodeButton *sendButton, NSInteger tag) {
       
        sendButton.enabled = NO;  // 禁用按钮
        [_countDownCode setTitle:@"发送中..." forState:UIControlStateNormal];
        
        // 开始网络请求,  请求成功之后, 调用开始计时的方法
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sendButton startWithSecond:10]; // 总时长
            // 发送中
            [sendButton CountDownSending:^NSString *(KBCodeButton *countDownButton, NSUInteger second) {
                return [NSString stringWithFormat:@"剩余%zd秒",second];
            }];
            
        });
        
        //  发送完成, 改变按钮文字
        [sendButton countDownFinished:^NSString *(KBCodeButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;  // 按钮可以重新点击
            return @"点击重新获取";
        }];
        
        
    }];
    
    
    
  

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
