//
//  SYSeletQuestionView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYSeletQuestionView : UIView
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property(strong,nonatomic)NSMutableArray *seleArray;
@property (weak, nonatomic) IBOutlet UILabel *induce;


@end

NS_ASSUME_NONNULL_END
