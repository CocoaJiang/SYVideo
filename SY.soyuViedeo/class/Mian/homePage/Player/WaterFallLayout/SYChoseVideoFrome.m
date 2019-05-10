//
//  ChoseVideoFrome.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/28.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYChoseVideoFrome.h"
#import "PlayModel.h"
#import "SYChoseItempopCell.h"

@interface SYChoseVideoFrome ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic)UILabel  *titleLabel;
@property(strong,nonatomic)UIButton *cancelButton;
@end
@implementation SYChoseVideoFrome
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.cancelButton];
        [self addSubview:self.collectionView];
        
    }
    return self;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing=2;
        layout.minimumInteritemSpacing=2;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-4-20)/2, 44);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled=YES;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"SYChoseItempopCell" bundle:nil] forCellWithReuseIdentifier:@"SYChoseItempopCell"];
    }
    return _collectionView;
}

#pragma mark - delegate and dataSouces

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.info.url count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYChoseItempopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYChoseItempopCell" forIndexPath:indexPath];
    cell.title.text  = self.info.url[indexPath.row].player_name;
    [cell.icon XJ_setImageWithURLString:self.info.url[indexPath.row].icon];
    cell.layer.borderWidth = 0.5f;
    cell.layer.masksToBounds=YES;
    cell.layer.cornerRadius=10;
    if (self.info.url[indexPath.row].isseleted) {
        cell.layer.borderColor = KappBlue.CGColor;
    }else{
        cell.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    }
    return cell;
}

-(void)setInfo:(videoInfo *)info{
    _info = info;
    [self.collectionView reloadData];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    urlInfo *model  = self.info.url[indexPath.row];
    if (model.isseleted) {
        return;
    }
    for (urlInfo *model in self.info.url) {
        model.isseleted = NO;
        for (SYSet *set in model.list) {
            set.isSetseleted = NO;
        }
    }
    //执行选中当前
    [self.collectionView reloadData];
    model.isseleted = YES;
    if (self.choseItem) {
        self.choseItem(indexPath.item);
    }
}

#pragma mark - 布局
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(@40);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
        make.height.mas_equalTo(@40);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.bottom.mas_equalTo(self.cancelButton.mas_top);
    }];
    
}



#pragma mark -懒加载 控件
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.text = @"请选择您要播放的视频源";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}




#pragma mark - 关联事件
-(void)buttonClick:(UIButton *)button{
    //dismiss 事件
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
}



@end
