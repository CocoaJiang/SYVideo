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
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
///定时关闭选择器
@property (weak, nonatomic) IBOutlet UICollectionView *tinmerCloseCollectionView;
///画面尺寸选择器
@property (weak, nonatomic) IBOutlet UICollectionView *playSizeSetCollectionView;
///跳过片头片尾
@property (weak, nonatomic) IBOutlet UISwitch *deleteHeaderAndFoot;
///连续播放
@property (weak, nonatomic) IBOutlet UISwitch *goonPlayerback;
///数据源相关只定时关闭
@property(strong,nonatomic)NSMutableArray *timeCloseTitle;
///画面尺寸
@property(strong,nonatomic)NSMutableArray *playerSize;


@end


@implementation SYPlaySetView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.likeButton setUpImageAndDownLableWithSpace:10];
    self.tinmerCloseCollectionView.delegate = self;
    self.playSizeSetCollectionView.delegate = self;
    self.tinmerCloseCollectionView.dataSource = self;
    self.playSizeSetCollectionView.dataSource = self;
     [self.playSizeSetCollectionView registerNib:[UINib nibWithNibName:@"SYChoseSetCell" bundle:nil] forCellWithReuseIdentifier:@"SYChoseSetCell"];
     [self.tinmerCloseCollectionView registerNib:[UINib nibWithNibName:@"SYChoseSetCell" bundle:nil] forCellWithReuseIdentifier:@"SYChoseSetCell"];
    self.deleteHeaderAndFoot.onTintColor = KAPPMAINCOLOR;
    self.goonPlayerback.onTintColor = KAPPMAINCOLOR;
    [self.deleteHeaderAndFoot addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    [self.goonPlayerback addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    BOOL autoPlay = [[SYUSERINFO info].userInfo.setting.autoPlay boolValue];
    BOOL continuity = [[SYUSERINFO info].userInfo.setting.continuity boolValue];
    [self.deleteHeaderAndFoot setOn:autoPlay animated:NO];
    [self.goonPlayerback setOn:continuity animated:NO];
    
}
-(void)switchChange:(UISwitch*)swithch{
    swithch.on  = !swithch.on;
    if (swithch==self.deleteHeaderAndFoot) {
        [SYUSERINFO info].userInfo.setting.autoPlay = [NSString stringWithFormat:@"%d",swithch.on];
    }else{
        [SYUSERINFO info].userInfo.setting.continuity = [NSString stringWithFormat:@"%d",swithch.on];
    }
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
        int i = 0;
        for (NSString *string in self.timeCloseTitle) {
            string.isSeleted = i==indexPath.row?YES:NO;
            i++;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tinmerCloseCollectionView reloadData];
        });
        if (self.closeVideoPlayer) {
            self.closeVideoPlayer(self.timeCloseTitle [indexPath.row]);
        }
    }else{
        if (collectionView == _playSizeSetCollectionView) {
            int i = 0;
            for (NSString *string in self.playerSize) {
                string.isSeleted = i==indexPath.row?YES:NO;
                i++;
            }
            
                [self.playSizeSetCollectionView reloadData];

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
        NSString *string = _timeCloseTitle.firstObject;
        string.isSeleted =YES;
    }
    return _timeCloseTitle;
}








@end
