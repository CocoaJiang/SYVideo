//
//  SYHomePagefootView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/13.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYHomePagefootView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *upView;
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIButton *lookMore;
@property (weak, nonatomic) IBOutlet UIButton *Change;
@property (weak, nonatomic) IBOutlet UIImageView *addImage;
@property(strong,nonatomic)data *data;
@property(copy,nonatomic)dispatch_block_t refush;
@property(copy,nonatomic)NSString *type_id;





@end

NS_ASSUME_NONNULL_END
