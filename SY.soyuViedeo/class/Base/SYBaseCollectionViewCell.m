//
//  SYBaseCollectionViewCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYBaseCollectionViewCell.h"

@implementation SYBaseCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


-(UICollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.scrollEnabled=YES;
        _collection.showsVerticalScrollIndicator=NO;
        _collection.showsHorizontalScrollIndicator=NO;
        _collection.backgroundColor = [UIColor whiteColor];
    }
    return _collection;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataArray count];
}

-(void)setIShorizontal:(BOOL)iShorizontal{
    _iShorizontal = iShorizontal;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    if (iShorizontal) {
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }else{
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    self.collection.collectionViewLayout = layout;
    [self.collection reloadData];
}

-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self.collection reloadData];
}

@end
