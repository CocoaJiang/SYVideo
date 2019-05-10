//
//  SYTextTopView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/20.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,headerType){
    twoButtonType=0,
    oneLableType=1,
};
@interface SYTextTopView : UIView
@property(assign,nonatomic)headerType type;
-(void)setLabelText:(NSString *)string;
@property(copy,nonatomic)void(^topButtonClick)(NSString *title);


@end

NS_ASSUME_NONNULL_END
