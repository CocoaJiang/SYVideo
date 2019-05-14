//
//  SYPlaySetView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/3.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYPlaySetView.h"
#import "SYChoseSetCell.h"
#import "NSString+Seleted.h"

@interface SYPlaySetView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
///收藏按钮
@property (strong, nonatomic)  UIButton *likeButton;
///定时关闭选择器
@property (strong, nonatomic)  UICollectionView *tinmerCloseCollectionView;
///画面尺寸选择器
@property (strong, nonatomic)  UICollectionView *playSizeSetCollectionView;
@property (strong, nonatomic)  NSMutableArray *timeCloseTitle;
///画面尺寸
@property (strong, nonatomic)  NSMutableArray *playerSize;
@property (strong, nonatomic)  UILabel *timeClose;
@property (strong, nonatomic)  UILabel *videoSize;
@property (strong, nonatomic)  UILabel *tiao;
@property (strong, nonatomic)  UILabel *lian;
@end
@implementation SYPlaySetView
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self addUI];
        self.likeButton.titleLabel.font = self.timeClose.font = self.videoSize.font = self.tiao.font = self.lian.font = [UIFont systemFontOfSize:14];
        [self.playSizeSetCollectionView registerNib:[UINib nibWithNibName:@"SYChoseSetCell" bundle:nil] forCellWithReuseIdentifier:@"SYChoseSetCell"];
        [self.tinmerCloseCollectionView registerNib:[UINib nibWithNibName:@"SYChoseSetCell" bundle:nil] forCellWithReuseIdentifier:@"SYChoseSetCell"];
        __weak typeof(self)weakSefl = self;
        _likeButton.clickAction = ^(UIButton *button) {
            weakSefl.likeButton.selected = !button.selected;
        };
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return collectionView==_tinmerCloseCollectionView?[self.timeCloseTitle count]:[self.playerSize count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYChoseSetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYChoseSetCell" forIndexPath:indexPath];

    cell.type = NOhasBorldColor;
    if (collectionView==_tinmerCloseCollectionView) {
        cell.text = _timeCloseTitle[indexPath.row];
    }else{
        cell.text = _playerSize[indexPath.row];
    }
    return cell;
}
-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, collectionView.bounds.size.height);
    
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _tinmerCloseCollectionView) {
        for (NSString *string in self.timeCloseTitle) {
            string.isSeleted =NO;
        }
        NSString *string_seleted = self.timeCloseTitle[indexPath.row];
        string_seleted.isSeleted = YES;
        [self reloadData];
        if (self.closeVideoPlayer) {
            self.closeVideoPlayer(self.timeCloseTitle [indexPath.row]);
        }
    }else{
        if (collectionView == _playSizeSetCollectionView) {
            for (NSString *string in self.playerSize) {
                string.isSeleted =NO;
            }
            NSString *string_seleted = self.playerSize[indexPath.row];
            string_seleted.isSeleted = YES;
            [self reloadData];
            NSString *sting = self.playerSize[indexPath.row];
            
            if (self.changVideoViewType) {
                self.changVideoViewType([sting isEqualToString:@"适应"]);
            }
    }
}
    
}


-(NSMutableArray *)playerSize{
    if (!_playerSize) {
        _playerSize  = [[NSMutableArray alloc]initWithObjects:@"适应",@"拉伸",@"填充",nil];
        NSString *string = _playerSize.firstObject;
        string.isSeleted =YES;
    }
    return _playerSize;
}
-(NSMutableArray *)timeCloseTitle{
    if (!_timeCloseTitle) {
        _timeCloseTitle  = [[NSMutableArray alloc]initWithObjects:@"不开启",@"播完当前",@"15分钟",@"30分钟",@"60分钟",nil];
        NSString * string = _timeCloseTitle.firstObject;
        string.isSeleted =YES;
    }
    return _timeCloseTitle;
}
#pragma mark - laz。。

-(UICollectionView *)tinmerCloseCollectionView{
    if (!_tinmerCloseCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _tinmerCloseCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _tinmerCloseCollectionView.delegate = self;
        _tinmerCloseCollectionView.dataSource = self;
        _tinmerCloseCollectionView.backgroundColor = [UIColor clearColor];
    }
    return _tinmerCloseCollectionView;
}


-(UICollectionView *)playSizeSetCollectionView{
    if (!_playSizeSetCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _playSizeSetCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _playSizeSetCollectionView.delegate = self;
        _playSizeSetCollectionView.dataSource = self;
        _playSizeSetCollectionView.backgroundColor = [UIColor clearColor];
    }
    return _playSizeSetCollectionView;
}
-(UIButton *)likeButton{
    if (!_likeButton) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeButton setTitle:@"收  藏" forState:UIControlStateNormal];
        [_likeButton setTitle:@"已收藏" forState:UIControlStateSelected];
        [_likeButton setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
        [_likeButton setImage:[UIImage imageNamed:@"收藏_选中"] forState:UIControlStateSelected];
        [_likeButton sizeToFit];
    }
    return _likeButton;
}

-(UILabel *)timeClose{
    if (!_timeClose) {
        _timeClose = [[UILabel alloc]init];
        _timeClose.text = @"定时关闭";
        _timeClose.textColor = [UIColor whiteColor];
        [_timeClose sizeToFit];
    }
    return _timeClose;
}
-(UILabel *)videoSize{
    if (!_videoSize) {
        _videoSize = [[UILabel alloc]init];
        _videoSize.text = @"画面尺寸";
        [_videoSize sizeToFit];
        _videoSize.textColor = [UIColor whiteColor];
    }
    return _videoSize;
}

#pragma mark -  自动布局。。。

-(void)addUI{
    [self addSubview:self.likeButton];
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(70);
       make.top.mas_equalTo(self).offset(50);
    }];
    [self addSubview:self.timeClose];
    [self.timeClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(70);
        make.top.mas_equalTo(self.likeButton.mas_bottom).offset(50);
    }];
    [self addSubview:self.videoSize];
    [self.videoSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(70);
        make.top.mas_equalTo(self.timeClose.mas_bottom).offset(50);
    }];
    [self addSubview:self.tinmerCloseCollectionView];
    [self.tinmerCloseCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeClose.mas_centerY);
        make.height.mas_equalTo(@40);
        make.left.mas_equalTo(self.timeClose.mas_right).offset(40);
        make.right.mas_equalTo(self.mas_right).offset(-40);
    }];
    [self addSubview:self.playSizeSetCollectionView];
    [self.playSizeSetCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.videoSize.mas_centerY);
        make.height.mas_equalTo(@40);
        make.left.mas_equalTo(self.videoSize.mas_right).offset(40);
        make.right.mas_equalTo(self.mas_right).offset(-40);
    }];
}

-(void)reloadData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tinmerCloseCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.timeClose.mas_centerY);
            make.height.mas_equalTo(@40);
            make.left.mas_equalTo(self.timeClose.mas_right).offset(40);
            make.right.mas_equalTo(self.mas_right).offset(-40);
        }];
        [self.playSizeSetCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.videoSize.mas_centerY);
            make.height.mas_equalTo(@40);
            make.left.mas_equalTo(self.videoSize.mas_right).offset(40);
            make.right.mas_equalTo(self.mas_right).offset(-40);
        }];
        [self.tinmerCloseCollectionView reloadData];
        [self.playSizeSetCollectionView reloadData];
    });
}


@end
