//
//  SharePicView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/29.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SharePicView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *videoClass;
@property (weak, nonatomic) IBOutlet UILabel *videodiver;
@property (weak, nonatomic) IBOutlet UILabel *vodeoActor;
@property (weak, nonatomic) IBOutlet UIImageView *codeImage;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@end

NS_ASSUME_NONNULL_END
