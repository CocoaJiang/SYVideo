//
//  SYBootonInPutView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,bootomType){
    hasTwoButton=0,
    Nobutton=1,
};


NS_ASSUME_NONNULL_BEGIN

@interface SYBootonInPutView : UIView
@property(copy,nonatomic)void(^buttonClick)(NSString *buttonTitle);
@property(strong,nonatomic)NSString *store;
@property(strong,nonatomic)NSString *videoID;
@property(assign,nonatomic)bootomType type;
@end

NS_ASSUME_NONNULL_END
