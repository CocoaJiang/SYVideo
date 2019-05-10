//
//  LSLoadPhotoTableViewCell.h
//  乐氏同仁APP
//
//  Created by Mac on 2018/11/7.
//  Copyright © 2018 双木科技张晓红. All rights reserved.
//

#import "SYTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSLoadPhotoTableViewCell : SYTableViewCell
@property(copy,nonatomic)void(^addOrDelegateImage)(NSMutableArray *selectedAsstes,CGFloat oneRowHight);
@end

NS_ASSUME_NONNULL_END
