//
//  SKinCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SKinCell.h"

@interface SKinCell ()
@property(strong,nonatomic)UICollectionView *newsCollectionViewCell;
@property(strong,nonatomic)UICollectionView *classCollectionViewCell;
@property(strong,nonatomic)UICollectionView *cardCollectionView;
@end





@implementation SKinCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(UICollectionView *)newsCollectionViewCell{
    if (!_newsCollectionViewCell) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    }
    return _newsCollectionViewCell;
}



@end
