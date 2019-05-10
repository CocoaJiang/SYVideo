//
//  SYMoreVideos.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/14.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYMoreVideos.h"
#import "SYVideoDetailCell.h"
#import "SYseachViewController.h"
#import "HomePageModel.h"
#import "SYVideoPlayerController.h"
@interface SYMoreVideos ()

@end
@implementation SYMoreVideos
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self setNAv];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SYVideoDetailCell" bundle:nil] forCellWithReuseIdentifier:@"SYVideoDetailCell"];
    __weak typeof(self)weakSelf = self;
    self.collectionView.mj_header = [SYGifHeader headerWithRefreshingBlock:^{
        [weakSelf.dataSorces removeAllObjects];
        weakSelf.SYindex=1;
        [weakSelf getMessage];
    }];
    //下拉刷新
    self.collectionView.mj_footer = [SYGifFoot footerWithRefreshingBlock:^{
        weakSelf.SYindex++;
        [weakSelf getMessage];
    }];
    
    
    self.SYindex = 1;
    [self getMessage];
    
}
-(void)setNAv{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"搜索2"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem= item;
}
-(void)search{
    SYseachViewController *controller = [[SYseachViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/3,SCREEN_WIDTH/3/0.57);
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYVideoDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYVideoDetailCell" forIndexPath:indexPath];
    item *model = self.dataSorces[indexPath.row];
    cell.model = model;
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SYVideoPlayerController *controller = [[SYVideoPlayerController alloc]init];
    item *model = self.dataSorces[indexPath.row];
    controller.video_id =model.id;
    [self.navigationController pushViewController:controller animated:YES];
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSorces count];
}

-(void)getMessage{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:self.itemID forKey:@"id"];
    [dict setObject:@(self.SYindex) forKey:@"page"];
    [HttpTool POST:[SY_AllData getWholeUrl] param:dict success:^(id responseObject) {
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"]objectForKey:@"list"]) {
            item *model  = [item mj_objectWithKeyValues:dict];
            [self.dataSorces addObject:model];
        }
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
        
    } error:^(NSString *error) {
        
    }];
    
    
    
    
    
}





@end
