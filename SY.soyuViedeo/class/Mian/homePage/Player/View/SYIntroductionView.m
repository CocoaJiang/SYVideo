//
//  SYIntroductionView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/19.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYIntroductionView.h"
#import "SYPoPTitleView.h"
#import "SYChoseEpisodCell.h"
#import "SYContentCell.h"
#import "SYInduceCell.h"
#import "PlayModel.h"

@interface SYIntroductionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)SYPoPTitleView *titleView;
@property(strong,nonatomic)UICollectionView *collectionView; //选集的形式！！！！
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(strong,nonatomic)UITableView *tableView;
@end
@implementation SYIntroductionView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
            make.height.mas_equalTo(@50);
        }];
        [self.collectionView reloadData];
    }
    return self;
}
-(SYPoPTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[SYPoPTitleView alloc]init];
        __weak typeof(self)weakSelf = self;
        _titleView.close = ^{
            if (weakSelf.close) {
                weakSelf.close();
            }
        };
  
    }
    return _titleView;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing=CGFLOAT_MIN;
        layout.minimumInteritemSpacing=CGFLOAT_MIN;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled=YES;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"SYChoseEpisodCell" bundle:nil] forCellWithReuseIdentifier:@"SYChoseEpisodCell"];
    }
    return _collectionView;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYChoseEpisodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYChoseEpisodCell" forIndexPath:indexPath];
    cell.number.textColor = [UIColor darkGrayColor];
    urlInfo *model = self.info.url[self.index];
    cell.number.text = model.list[indexPath.row].title;
    if (model.list[indexPath.row].isSetseleted) {
        cell.number.textColor = KAPPMAINCOLOR;
    }else{
         cell.number.font = [UIFont systemFontOfSize:14];
    }
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.info.url[self.index].list count];
}

-(void)setViewtype:(SYViewType)viewtype{
    _viewtype  = viewtype;
    if (viewtype==TV) {
        if (self.tableView) {
            [self.tableView removeFromSuperview];
        }
        _titleView.title_string = @"选集";
        _titleView.subtitle_string = [NSString stringWithFormat:@"更新至%@集",self.info.serial];
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self);
            make.top.mas_equalTo(self.titleView.mas_bottom);
        }];
    }else if (viewtype==Introduction){
        [self addSubview:self.tableView];
        if (self.collectionView) {
            [self.collectionView removeFromSuperview];
        }
        
        _titleView.title_string = self.info.name;
        _titleView.subtitle_string = @"";
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self);
            make.top.mas_equalTo(self.titleView.mas_bottom);
        }];
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/4, 58);
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight=130;
        [_tableView setOthers];
        [_tableView setHidenLine];
        [_tableView registerNib:[UINib nibWithNibName:@"SYContentCell" bundle:nil] forCellReuseIdentifier:@"SYContentCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"SYInduceCell" bundle:nil] forCellReuseIdentifier:@"SYInduceCell"];
    }
    return _tableView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        SYContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYContentCell"];
        cell.info  = self.info;
        return cell;
    }else{
        SYInduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYInduceCell"];
        cell.content.text = [[self.info.content stringByReplacingOccurrencesOfString:@"<p>" withString:@"    "] stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
        return cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 121; //到时候赋值的时候计算高度
    }else{
        if (self.info.contentHeight>0) {
            return self.info.contentHeight;
        }else{
            self.info.contentHeight = 50+[Tools XJCalculateTheSizeWithFont:[UIFont systemFontOfSize:13] andWithText:self.info.content andWithWidthMAX:SCREEN_WIDTH-40].height;
            return self.info.contentHeight;
        }
    }
}
-(void)setInfo:(videoInfo *)info{
    _info = info;
    [self.collectionView reloadData];
    [self.tableView reloadData];
}
-(void)setIndex:(NSInteger)index{
    _index = index;
    [self.collectionView reloadData];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SYSet *model = self.info.url[self.index].list[indexPath.row];
    if (model.isSetseleted) {
        return;
    }
    for (SYSet *model in self.info.url[self.index].list) {
        model.isSetseleted = NO;
    }
    model.isSetseleted  = !model.isSetseleted;
    [self.collectionView reloadData];
    if (self.itemClick) {
        self.itemClick(indexPath.row);
    }
}



@end
