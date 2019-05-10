//
//  SYDatailScrollViewItem.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/14.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYDatailScrollViewItem : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;

-(void)settitle:(NSString *)title andSeleted:(BOOL)isseleted;


@end

NS_ASSUME_NONNULL_END
