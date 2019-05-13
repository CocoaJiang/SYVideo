//
//  SYVideoPlayerCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYVideoPlayerCell.h"
#import "SYCellTitleView.h"
#import "SYChoseEpisodCell.h"
#import "PlayModel.h"

@interface SYVideoPlayerCell()
@property(strong,nonatomic)SYCellTitleView *titleView;
@property(assign,nonatomic)NSIndexPath *selectedIndex;


@end


@implementation SYVideoPlayerCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleView];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.collection];
        self.iShorizontal  = YES;
        self.collection.contentInset = UIEdgeInsetsMake(0, 10, 0, 0);
        [self.collection registerNib:[UINib nibWithNibName:@"SYChoseEpisodCell" bundle:nil] forCellWithReuseIdentifier:@"SYChoseEpisodCell"];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(SYCellTitleView *)titleView{
    if (!_titleView) {
        _titleView = [Tools XJ_XibWithName:@"SYCellTitleView"];
        _titleView.clipsToBounds = YES;
        __weak typeof(self)weakSelf = self;
        _titleView.rightClick = ^{
            if (weakSelf) {
                weakSelf.selection_item();
            }
        };
    }
    return _titleView;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(45);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.mas_equalTo(self.contentView);
        make.height.mas_equalTo(@0.4);
    }];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.bottom.mas_equalTo(self.lineView.mas_top);
    }];
}
#pragma mark -  delegate

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYChoseEpisodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYChoseEpisodCell" forIndexPath:indexPath];
    SYSet *model =self.info.url[self.index].list[indexPath.item];
    cell.number.font = [UIFont systemFontOfSize:14];
    cell.number.text = model.title;
    if (model.isSetseleted) {
        cell.number.textColor = KAPPMAINCOLOR;
    }else{
        cell.number.textColor = [UIColor darkGrayColor];
    }
    
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.info.url[self.index].list count];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYSet *model =self.info.url[self.index].list[indexPath.item];
    if (model.width>0) {
        return CGSizeMake(model.width, 58);
    }else{
        model.width = [Tools XJCalculateTheSizeWithFont:[UIFont systemFontOfSize:14] andWithText:model.title andWithWidthMAX:CGFLOAT_MAX].width+40;
        return CGSizeMake(model.width, 58);
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     SYSet *model =self.info.url[self.index].list[indexPath.item];
    if (model.isSetseleted) {
        return;
    }
    for (SYSet *set in self.info.url[self.index].list) {
        set.isSetseleted = NO;
    }
     model.isSetseleted =!model.isSetseleted;
    [self.collection reloadData];
    if (self.itemSetClick) {
        self.itemSetClick(indexPath.row);
    }
    
    //选中后滚动到屏幕中间
    [collectionView layoutIfNeeded];

    //首先我能获取到点击的Cell 吧！
    SYChoseEpisodCell *cell = (SYChoseEpisodCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //然后在获取他的位置
    CGRect rect = [collectionView convertRect:cell.frame fromView:collectionView];
    //去到最后面的item的位置！！！
    
    CGSize  lastSize = self.collection.contentSize;
    
    //然后让CollectionView 滚动到这个Rect 。。。
    if (rect.origin.x<self.contentView.center.x||lastSize.width-rect.origin.x<self.centerX) {
        return;
    }else{
        [collectionView setContentOffset:CGPointMake(rect.origin.x-self.contentView.centerX+rect.size.width/2, rect.origin.y)animated:YES];
    }

}
-(void)setIndex:(NSInteger)index{
    _index = index;
    if (!self.info)return;
    int i = 0;
    for (SYSet *set in self.info.url[self.index].list) {
        if (set.isSetseleted) {
            break;
        }
        i++;
    }
   
    [self.collection reloadData];
   
     NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
    [self.collection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];

    //此时 cell 在可见范围内 可以取出cell
  
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self.collection layoutIfNeeded];

        SYChoseEpisodCell *cell = (SYChoseEpisodCell *)[self.collection cellForItemAtIndexPath:indexPath];
        if (!cell) return;
        //然后在获取他的位置
        CGRect rect = [self.collection convertRect:cell.frame fromView:self.collection];
        //去到最后面的item的位置！！！

        CGSize  lastSize = self.collection.contentSize;

        //然后让CollectionView 滚动到这个Rect 。。。
        if (rect.origin.x<self.contentView.center.x||lastSize.width-rect.origin.x<self.centerX) {
            return;
        }else{
            [self.collection setContentOffset:CGPointMake(rect.origin.x-self.contentView.centerX+rect.size.width/2, rect.origin.y)animated:YES];
        }

    });

    
    
    
    
    
    

}

-(void)setInfo:(videoInfo *)info{
    _info = info;
    NSString *string = [NSString stringWithFormat:@"更新至%@集",info.serial];
    [_titleView.rightButton setTitle:string forState:UIControlStateNormal];
    [self.collection reloadData];
    
}






@end
