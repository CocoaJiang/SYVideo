//
//  ZXJPopView.h
//  乐氏同仁APP
//
//  Created by 张孝江 on 2018/9/13.
//  Copyright © 2018年 双木科技张晓红. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXJPopView : UIView

@property(assign,nonatomic)BOOL canDisMiss;

@property(strong,nonatomic)UIView *contentview;

@property(copy,nonatomic)dispatch_block_t dismisBlock;





- (void)showAlert;
- (void)dismissAlert;



@end
