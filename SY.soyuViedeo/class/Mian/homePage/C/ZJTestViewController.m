//
//  TextViewController.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJTestViewController.h"
#import "UIViewController+ZJScrollPageController.h"
#import "headerView.h"
#import "SYHomeTableViewCell.h"
#import "HomeGussCollectionViewCell.h"
#import "CollectionReusableView.h"
#import "SYVideoDetailCell.h"
#import "HomePageModel.h"
#import "SYScrollView.h"
#import "SYHomePagefootView.h"
#import "SYVideoPlayerController.h"
@interface ZJTestViewController ()
@property(strong,nonatomic)SYScrollView *cycleScrollView;
@end
@implementation ZJTestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.SYindex=1;
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREENH_HEIGHT-kTabBarHeight-kTopHeight);
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[HomeGussCollectionViewCell class] forCellWithReuseIdentifier:@"HomeGussCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SYHomePagefootView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SYHomePagefootView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"section1"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SYVideoDetailCell" bundle:nil] forCellWithReuseIdentifier:@"SYVideoDetailCell"];
    __weak typeof(self)weakSelf = self;
    self.collectionView.mj_footer = [SYGifFoot footerWithRefreshingBlock:^{
        if (weakSelf.isHaveNextPage) {
            weakSelf.SYindex++;
            [weakSelf addMore];
        }else{
            [weakSelf.collectionView.mj_footer endRefreshing];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
       HomeGussCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeGussCollectionViewCell" forIndexPath:indexPath];
        cell.array = self.model.recommend;
        return cell;
    }else{
        SYVideoDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYVideoDetailCell" forIndexPath:indexPath];
        item *model = self.model.data[indexPath.section-1].item_list[indexPath.row];
        cell.model = model;
        return cell;
    }

}
//点击事件！！！！！
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section!=0) {
        SYVideoPlayerController *controller = [[SYVideoPlayerController alloc]init];
        item *model  = self.model.data[indexPath.section-1].item_list[indexPath.row];
        controller.linkerURL = model.link;
        controller.video_id = model.id;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    return;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return [self.model.data[section-1].item_list count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (!self.model) {
        return 0;
    }else{
       return [self.model.data count]+1;
    }
}
-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if ([self.model.recommend count]>0) {
            return CGSizeMake(SCREEN_WIDTH, 100);
        }else{
            return CGSizeZero;
        }
    }else{
        if ([self.model.data[indexPath.section-1].composing integerValue]==1) {
            return CGSizeMake((SCREEN_WIDTH)/2,((SCREEN_WIDTH/2)*0.7)+20);
        }else{
            return CGSizeMake(SCREEN_WIDTH/3,SCREEN_WIDTH/3/0.57);
        }
    }
}
#pragma mark - .头部。。。
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section==0) {
            UICollectionReusableView *section1View = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"section1" forIndexPath:indexPath];
            [section1View addSubview:self.cycleScrollView];
            [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(section1View);
            }];
            self.cycleScrollView.array = (NSMutableArray *)self.model.slide;
            return section1View;
        }else{
            CollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableView" forIndexPath:indexPath];
            data *data = self.model.data[indexPath.section-1];
            view.model = data;
            return view;
        }
    }else if (indexPath.section!=0 && [kind isEqualToString:UICollectionElementKindSectionFooter]){
        SYHomePagefootView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SYHomePagefootView" forIndexPath:indexPath];
        data *data = self.model.data[indexPath.section-1];
        foot.type_id = self.model.type_id; //到foot。。。。
        foot.data = data;
        __weak typeof(self)weakSelf = self;
        foot.refush = ^{
            [UIView performWithoutAnimation:^{
                [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
            }];
        };
        return foot;
    }
    return nil;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
         return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*9/16);
    }else{
        if (self.model.data[section-1].isHaveCover) {
            return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH *9/16+50);
        }else{
            return  CGSizeMake(SCREEN_WIDTH, 50);
        }
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeZero;
    }else{
        if (self.model.data[section-1].isHaveAdd) {
            return CGSizeMake(SCREEN_WIDTH, 160);
        }else{
            return CGSizeMake(SCREEN_WIDTH, 75);
        }
    }
}




//请求数据。。。。
-(void)setModel:(HomePageModel *)model{
    _model = model;
  //  self.cycleScrollView.array = (NSMutableArray *)self.model.slide;
    [self.collectionView reloadData];
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(SYScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [[SYScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, SCREEN_WIDTH*16/9)];
    }
    return _cycleScrollView;
}

#pragma mark  -  加载更多

-(void)addMore{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:self.model.type_id forKey:@"id"];
    [dictionary setObject:@(self.SYindex) forKey:@"page"];
    [dictionary setObject:@(10) forKey:@"size"];
    [HttpTool POST:[SY_more getWholeUrl] param:dictionary success:^(id responseObject) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        self.isHaveNextPage = [[[responseObject objectForKey:@"data"] objectForKey:@"list"] count]<10?NO:YES;
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"list"]) {
            data *model = [data mj_objectWithKeyValues:dict];
            [array addObject:model];
        }
        [self.model.data addObjectsFromArray:array];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
    } error:^(NSString *error) {
        
    }];
}
////回调到大控制里去实现。。。
-(void)reload{
    if (self.refresh) {
        self.refresh();
    }
}










@end
