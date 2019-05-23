//
//  SYShowAleart.h
//  SY.souyunVideo
//
//  Created by 搜云 on 2019/5/21.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger ,AlearType){
    
    OKButtonAndCancelButtonType=0,
    SingleOKbuttonType=1,
};

NS_ASSUME_NONNULL_BEGIN

@interface SYShowAleart : UIView
@property(assign,nonatomic)AlearType type;
-(instancetype)initWithFrame:(CGRect)frame andWithType:(AlearType)type;
@end

NS_ASSUME_NONNULL_END
