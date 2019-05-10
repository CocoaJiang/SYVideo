//
//  SYLiveSetController.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/23.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , SYLiveSetControllerType){
    /// ///选择播放源
    SYLiveSetControllerchangSetIndex =0,
    /// //选择频道
    SYLiveSetControllerchangIndex =1,
    //充满屏幕
    SYLiveSetControllerFullTpe =2,
};

NS_ASSUME_NONNULL_BEGIN

@class LiveListModel;


@interface SYLiveSetController : UIView

///播放源
@property(strong,nonatomic)NSMutableArray *array_choseSetIndex;
///选台
@property(strong,nonatomic)NSMutableArray *array_choseIndex;

///type
@property(assign,nonatomic)SYLiveSetControllerType type;


@property(copy,nonatomic)dispatch_block_t dismissBlock;

///选中Cell 进行回调

@property(copy,nonatomic)void(^ChoseCell)(NSURL *url);
///判断是否选中以及选中的回调 保存信息。。。
@property(copy,nonatomic)NSString *idString;

@property(copy,nonatomic)void(^changchnel)(LiveListModel *model);






@end

NS_ASSUME_NONNULL_END
