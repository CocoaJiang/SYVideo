//
//  UIButton+VerificationCode.m
//  众客推
//
//  Created by Mac on 2018/9/6.
//  Copyright © 2018年 双木科技张晓红. All rights reserved.
//

#import "UIButton+VerificationCode.h"

@implementation UIButton (VerificationCode)

- (void)startCountDown
{
    __block NSInteger time = 59; //设置倒计时时间
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                self.alpha=1;
                [self setTitle:@"重新发送" forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
            
        }else{
            
            NSInteger seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [self setTitle:[NSString stringWithFormat:@"重新发送(%.2ld)", (long)seconds] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                //
                self.alpha=0.4;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


@end
