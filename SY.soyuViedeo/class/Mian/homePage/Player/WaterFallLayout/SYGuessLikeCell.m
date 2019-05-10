//
//  SYGuessLikeCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYGuessLikeCell.h"
#import "SYVideoDetailCell.h"
#import "PlayModel.h"

@implementation SYGuessLikeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.collection];
        [self.collection registerNib:[UINib nibWithNibName:@"SYVideoDetailCell" bundle:nil] forCellWithReuseIdentifier:@"SYVideoDetailCell"];
        self.iShorizontal=YES;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(@0.4);
    }];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.lineView.mas_top);
    }];
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYVideoDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYVideoDetailCell" forIndexPath:indexPath];
    cell.model  = self.model.recommend[indexPath.row];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.model.recommend count];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
     return CGSizeMake((SCREEN_WIDTH-4)/3,((SCREEN_WIDTH-4)/3/0.618)+20);
}

-(void)setModel:(PlayModel *)model{
    _model=model;
    [self.collection reloadData];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.collectionClick) {
        self.collectionClick(self.model.recommend[indexPath.row].id);
    }
}


@end
