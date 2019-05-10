//
//  SYEXPCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYEXPCell.h"
#import "SYEXPCollectionViewCell.h"
#import "SYLeveModel.h"

@interface SYEXPCell ()

@end

@implementation SYEXPCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.collection];
        [self.collection registerNib:[UINib nibWithNibName:@"SYEXPCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SYEXPCollectionViewCell"];
        [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        }];
    }
    return self;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYEXPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYEXPCollectionViewCell" forIndexPath:indexPath];
    experience *exp = self.array[indexPath.item];
    cell.topLanel.text = exp.name;
    cell.bottomLabel.text = exp.exp;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.contentView.bounds.size.width-24)/5, (self.contentView.bounds.size.width)/5);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.array count];
}
-(void)setArray:(NSArray *)array{
    _array = array;
    [self.collection reloadData];
}

@end
