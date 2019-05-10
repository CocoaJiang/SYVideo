//
//  SYChoseSetCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/2.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,choseCellType){
    hasBorldColor=0,
    NOhasBorldColor=1,
};


@interface SYChoseSetCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property(assign,nonatomic)choseCellType type;
@property(strong,nonatomic)NSString *text;

@end

NS_ASSUME_NONNULL_END
