//
//  SYPlayChoseSetView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/1.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYPlayChoseSetView.h"
#import "SYChoseSetCell.h"
#import "PlayModel.h"
#import "NSString+Seleted.h"

@interface SYPlayChoseSetView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic)UICollectionView *collectionView;
@end

@implementation SYPlayChoseSetView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        self.backgroundColor = self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = CGFLOAT_MIN;
        layout.minimumLineSpacing = CGFLOAT_MIN;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled=YES;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.contentInset= UIEdgeInsetsMake(50, 50, 50, 50);
        [_collectionView registerNib:[UINib nibWithNibName:@"SYChoseSetCell" bundle:nil] forCellWithReuseIdentifier:@"SYChoseSetCell"];
    }
    return _collectionView;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYChoseSetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYChoseSetCell" forIndexPath:indexPath];
    cell.type = hasBorldColor;
    SYSet *set = self.info.url[self.index].list[indexPath.row];
    set.title.isSeleted = set.isSetseleted;
    cell.text = set.title;
    return cell;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     return [self.info.url[self.index].list count];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
      return CGSizeMake(60, 60);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    int i = 0 ;
    for (SYSet *set  in self.info.url[self.index].list) {
        if (indexPath.row==i) {
            set.isSetseleted=YES;
        }else{
            set.isSetseleted =NO;
        }
        i++;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
    
    if (self.choseItem) {
        self.choseItem(indexPath.row);
    }
    
    

}


-(void)setInfo:(videoInfo *)info{
    _info = info;
    [self relodData];
}

-(void)setIndex:(NSInteger)index{
    _index = index;
    [self relodData];
}



-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    NSInteger numberOfItems = [collectionView numberOfItemsInSection:0];
    
    CGFloat combinedItemWidth = (numberOfItems * collectionViewLayout.itemSize.width) + ((numberOfItems - 1)*collectionViewLayout.minimumInteritemSpacing);
    
    CGFloat padding = (collectionView.frame.size.width - combinedItemWidth)/2;
    
    padding = padding>0 ? padding :0 ;
    
    return UIEdgeInsetsMake(0, padding,0, padding);

}

-(void)relodData{
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        [weakSelf.collectionView reloadData];
    });
}

@end
