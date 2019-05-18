//
//  SYPersonHistoryCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYPersonHistoryCell.h"
#import "HistoryView.h"
#import "SYHistoryItemCell.h"
#import "HistoryDetailViewController.h"
#import "PlayInfoModel.h"
#import "SYNewLoginViewController.h"
#import "SYVideoPlayerController.h"

@interface SYPersonHistoryCell ()
@property(strong,nonatomic)HistoryView *historyView;
@end

@implementation SYPersonHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.historyView];
        [self.contentView addSubview:self.collection];
        [self.contentView addSubview:self.lineView];
        [self.collection registerNib:[UINib nibWithNibName:@"SYHistoryItemCell" bundle:nil] forCellWithReuseIdentifier:@"SYHistoryItemCell"];
        self.collection.contentInset = UIEdgeInsetsMake(0, 20, 0, 0);
        self.iShorizontal=YES;
    }
    return self;
}


-(HistoryView *)historyView{
    if (!_historyView) {
        _historyView = [Tools XJ_XibWithName:@"HistoryView"];
        _historyView.userInteractionEnabled=YES;
        UITapGestureRecognizer *zer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Click)];
        [_historyView addGestureRecognizer:zer];
    }
    return _historyView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_historyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(@45);
    }];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-1);
        make.top.mas_equalTo(self.historyView.mas_bottom);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(@0.3);
    }];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SYVideoPlayerController *controller = [[SYVideoPlayerController alloc]init];
    PlayInfoModel *model = self.dataSources[indexPath.row];
    controller.video_id = model.id;
    [[Tools viewController:self].navigationController pushViewController:controller animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSources count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYHistoryItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYHistoryItemCell" forIndexPath:indexPath];
    PlayInfoModel *model = self.dataSources[indexPath.row];
    [cell.iCon XJ_setImageWithURLString:model.pic];
    cell.progress.text = [NSString stringWithFormat:@"%@%%",model.playTime];
    if ([model.serlize integerValue]>0) {
        model.serlize = [NSString stringWithFormat:@"第%@集",model.serlize];
    }
    cell.VideoName.text = [NSString stringWithFormat:@"%@%@",model.name,model.serlize];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-20)/2.5, self.contentView.bounds.size.height-60);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}


-(void)Click{
    if ([Tools isNeedLogin]) {
        [[Tools viewController:self].navigationController pushViewController:[SYNewLoginViewController new] animated:YES];
        return;
    }
    [[Tools viewController:self].navigationController pushViewController:[HistoryDetailViewController new] animated:YES];
}

-(void)setDataSources:(NSMutableArray *)dataSources{
    _dataSources = dataSources;
    [self.collection reloadData];
}


@end
