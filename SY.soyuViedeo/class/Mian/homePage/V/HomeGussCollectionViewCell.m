//
//  HomeGussCollectionViewCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "HomeGussCollectionViewCell.h"
#import "SYCollectionViewCell.h"
#import "HomePageModel.h"
#import "SYVideoPlayerController.h"
@implementation HomeGussCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.collection];
        self.iShorizontal=YES;
        [self.collection registerNib:[UINib nibWithNibName:@"SYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SYCollectionViewCell"];
        self.collection.pagingEnabled=YES;
        self.lineView = [Tools retunLineView];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(@0.3);
    }];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.lineView.mas_top);
        
    }];
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SYVideoPlayerController *controller = [[SYVideoPlayerController alloc]init];
    recommendModel *model  = self.array[indexPath.row];
    controller.video_id = model.id;
    [[Tools viewController:self].navigationController pushViewController:controller animated:YES];
    
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYCollectionViewCell" forIndexPath:indexPath];
    recommendModel *model = self.array[indexPath.row];
    [cell.imageview XJ_setImageWithURLString:model.pic];
    cell.title.text = model.name;
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.array count];
}
-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/4, 100);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(void)setArray:(NSArray *)array{
    _array = array;
    [self.collection reloadData];
}

@end
