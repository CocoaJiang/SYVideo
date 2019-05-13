//
//  SYBaseCollectionViewCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYBaseCollectionViewCell : UICollectionViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic)UICollectionView *collection;
//UICollectionViewFlowLayout
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(assign,nonatomic)BOOL iShorizontal;

@end

NS_ASSUME_NONNULL_END