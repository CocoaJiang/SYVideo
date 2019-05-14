//
//  SYChoseClearView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/3.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYChoseClearView.h"
#import "SYChoseSetCell.h"
#import "NSString+Seleted.h"

@interface SYChoseClearView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *choseClearCollectionView;

@property(strong,nonatomic)NSMutableArray *clearArray;

@end


@implementation SYChoseClearView

-(void)awakeFromNib{
    [super awakeFromNib];
    _choseClearCollectionView.delegate = self;
    _choseClearCollectionView.dataSource = self;
    [_choseClearCollectionView  registerNib:[UINib nibWithNibName:@"SYChoseSetCell" bundle:nil] forCellWithReuseIdentifier:@"SYChoseSetCell"];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYChoseSetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYChoseSetCell" forIndexPath:indexPath];
    cell.type=hasBorldColor;
    cell.text =self.clearArray[indexPath.row];
    cell.contentView.layer.borderWidth = 0.8f;
    return cell;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  [self.clearArray count];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(160, 50);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger i = 0;
    
    for (NSString *string in self.clearArray) {
        if (i==indexPath.row) {
            string.isSeleted = YES;
        }else{
            string.isSeleted = NO;
        }
        
        i++;
        
    }
            
        [self.choseClearCollectionView reloadData];
        

    if (self.choseItem) {
        self.choseItem(indexPath.row, self.clearArray[indexPath.row]);
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 2;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSMutableArray *)clearArray{
    if (!_clearArray) {
        _clearArray = [[NSMutableArray alloc]init];
        [_clearArray addObjectsFromArray:@[@"1080P",@"超清",@"高清",@"标清"]];
        NSString *item = _clearArray.lastObject;
        item.isSeleted = YES;
    }
    return _clearArray;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    NSInteger numberOfItems = [collectionView numberOfItemsInSection:0];
    
    CGFloat combinedItemWidth = (numberOfItems * collectionViewLayout.itemSize.width) + ((numberOfItems - 1)*collectionViewLayout.minimumInteritemSpacing);
    
    CGFloat padding = (collectionView.frame.size.width - combinedItemWidth)/2;
    
    padding = padding>0 ? padding :0 ;
    
    return UIEdgeInsetsMake(0, padding,0, padding);
    
}


@end
