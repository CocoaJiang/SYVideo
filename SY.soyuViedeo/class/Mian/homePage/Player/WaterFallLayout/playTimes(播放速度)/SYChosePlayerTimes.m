//
//  SYChosePlayerTimes.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/3.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYChosePlayerTimes.h"
#import "SYChoseSetCell.h"
#import "NSString+Seleted.h"

@interface SYChosePlayerTimes ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *chosePlaytimes;
@property(strong,nonatomic)NSMutableArray *palyTimes;

@end

@implementation SYChosePlayerTimes

-(void)awakeFromNib{
    [super awakeFromNib];
    _chosePlaytimes.delegate = self;
    _chosePlaytimes.dataSource = self;
    [_chosePlaytimes  registerNib:[UINib nibWithNibName:@"SYChoseSetCell" bundle:nil] forCellWithReuseIdentifier:@"SYChoseSetCell"];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYChoseSetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYChoseSetCell" forIndexPath:indexPath];
    cell.type=hasBorldColor;
    cell.text =self.palyTimes[indexPath.row];
    return cell;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  [self.palyTimes count];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(130, 50);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //先循环。。。
    NSInteger i = 0;
    for (NSString *string in self.palyTimes) {
     
        if (indexPath.row==i) {
            string.isSeleted = YES;
        }else{
            string.isSeleted = NO;
        }
           i++;
    }
        [self.chosePlaytimes reloadData];
    
    if (self.choseItem) {
        self.choseItem(indexPath.row, self.palyTimes[indexPath.row]);
    }
    
 
}
-(NSMutableArray *)palyTimes{
    if (!_palyTimes) {
        _palyTimes = [[NSMutableArray alloc]initWithObjects:@"1.0x",@"1.25x",@"1.5x",@"2.0x",nil];
        NSString *string = _palyTimes.firstObject;
        string.isSeleted = YES;
    }
    return _palyTimes;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 2;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    NSInteger numberOfItems = [collectionView numberOfItemsInSection:0];
    
    CGFloat combinedItemWidth = (numberOfItems * collectionViewLayout.itemSize.width) + ((numberOfItems - 1)*collectionViewLayout.minimumInteritemSpacing);
    
    CGFloat padding = (collectionView.frame.size.width - combinedItemWidth)/2;
    
    padding = padding>0 ? padding :0 ;
    
    return UIEdgeInsetsMake(0, padding,0, padding);
    
}



@end
