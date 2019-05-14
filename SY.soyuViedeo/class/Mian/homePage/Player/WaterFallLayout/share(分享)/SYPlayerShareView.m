//
//  SYPlayerShareView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/3.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYPlayerShareView.h"
#import "SYCollectionViewCell.h"


@interface SYPlayerShareView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
///分享的CollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *shareCollectionView;
///数据源
@property(strong,nonatomic)NSMutableArray *infoArray;
@end


@implementation SYPlayerShareView

-(void)awakeFromNib{
    [super awakeFromNib];
    _shareCollectionView.delegate = self;
    _shareCollectionView.dataSource = self;
     [_shareCollectionView registerNib:[UINib nibWithNibName:@"SYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SYCollectionViewCell"];
    _title.font = [UIFont systemFontOfSize:17];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.infoArray count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYCollectionViewCell" forIndexPath:indexPath];
    cell.title.text = self.infoArray[indexPath.row];
    cell.title.textColor = [UIColor whiteColor];
    cell.imageview.image = [UIImage imageNamed:self.infoArray[indexPath.row]];
    return cell;
}

-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, 88);
}
-(NSMutableArray *)infoArray{
    if (!_infoArray) {
        NSArray *array = @[
                           @"朋友圈",
                            @"微信",
                           @"QQ",
                           @"QQ空间",
                           @"微博",
                           @"赋值链接",
                           @"分享图片",
                        ];
        _infoArray = [[NSMutableArray alloc]initWithArray:array];
    }
    return _infoArray;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}


@end
