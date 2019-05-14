//
//  SYDetailCollectionViewCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/14.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYDetailCollectionViewCell.h"
#import "SYDatailScrollViewItem.h"
#import "NSString+Seleted.h"

@interface SYDetailCollectionViewCell ()

@end

@implementation SYDetailCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.collection];
        [self.collection registerNib:[UINib nibWithNibName:@"SYDatailScrollViewItem" bundle:nil] forCellWithReuseIdentifier:@"SYDatailScrollViewItem"];
        self.iShorizontal=YES;
    }
    return self;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYDatailScrollViewItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYDatailScrollViewItem" forIndexPath:indexPath];
    NSString *titleString  = self.dataArray[indexPath.row];
    [cell settitle:titleString andSeleted:titleString.isSeleted];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataArray count];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = [Tools XJCalculateTheSizeWithFont:[UIFont systemFontOfSize:14] andWithText:self.dataArray[indexPath.row] andWithWidthMAX:CGFLOAT_MAX].width;
    return CGSizeMake(width+20, self.bounds.size.height-3);    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //搞定单选
    for (NSString *string in self.dataArray) {
        string.isSeleted=NO;
    }
    NSString *Sletedstring = self.dataArray[indexPath.row];
    Sletedstring.isSeleted=YES;
    if (self.itemClick) {
        self.itemClick(Sletedstring);
    }
    [self.collection reloadData];
    //就是点击了后面的了

}
//搞定默认
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
        make.top.bottom.mas_equalTo(self.contentView);
    }];
}


@end
