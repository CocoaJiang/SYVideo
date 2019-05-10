//
//  SY_VoiceView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/5.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SY_VoiceView : UIView
@property(copy,nonatomic)void(^voiceAddOrReduction)(BOOL isAdd);
@end

NS_ASSUME_NONNULL_END
