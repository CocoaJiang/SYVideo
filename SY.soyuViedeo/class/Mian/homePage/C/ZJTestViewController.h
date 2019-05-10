//
//  TextViewController.h
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYBaseViewController.h"
#import "ZJScrollPageViewDelegate.h"
#import "HomePageModel.h"
@interface ZJTestViewController : SYBaseViewController <ZJScrollPageViewChildVcDelegate>
@property(strong,nonatomic)HomePageModel *model;
@property(copy,nonatomic)dispatch_block_t refresh;
@end
