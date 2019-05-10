//
//  SYDetailCollectionController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/14.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYDetailCollectionController.h"
#import "SYVideoDetailCell.h"
#import "SYDetailCollectionViewCell.h"
#import "SYseachViewController.h"
#import "VideoTypeModel.h"
#import "NSString+Seleted.h"
#import "SYVideoPlayerController.h"


@interface SYDetailCollectionController ()
@property(strong,nonatomic)VideoTypeModel *videoModel;
@property(strong,nonatomic)NSMutableDictionary *dict;

@end



@implementation SYDetailCollectionController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self getMessage];
    [self setNAv];
    self.SYindex=1;
    __weak typeof(self)weakSelf  = self;
    self.collectionView.mj_footer  = [SYGifFoot footerWithRefreshingBlock:^{
        if (weakSelf.isHaveNextPage) {
            weakSelf.SYindex++;
            [weakSelf screeningandWithPage:weakSelf.SYindex];
        }else{
            [weakSelf.collectionView.mj_footer endRefreshing];
        }
    }];

    
}
-(void)setNAv{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"搜索2"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem= item;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SYVideoDetailCell" bundle:nil] forCellWithReuseIdentifier:@"SYVideoDetailCell"];
    [self.collectionView registerClass:[SYDetailCollectionViewCell class] forCellWithReuseIdentifier:@"SYDetailCollectionViewCell"];
}
-(void)search{
    SYseachViewController *controller = [[SYseachViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

//首先分组
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return [self.videoModel.extends count];
    }else{
        return [self.videoModel.list count];
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return CGSizeMake(SCREEN_WIDTH, 40);
    }else{
          return CGSizeMake((SCREEN_WIDTH-4)/3,(SCREEN_WIDTH-4)/3/0.62);
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        SYDetailCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SYDetailCollectionViewCell" forIndexPath:indexPath];
        cell.dataArray = (NSMutableArray *)self.videoModel.extends[indexPath.row].item_list;
        __weak typeof(self)weakSelf = self;
        cell.itemClick = ^(NSString * _Nonnull value) {
            if ([self.videoModel.extends[indexPath.row].item_list indexOfObject:value]==0) {
                if ([weakSelf.dict.allKeys containsObject:self.videoModel.extends[indexPath.row].item]) {
                    [weakSelf.dict removeObjectForKey:self.videoModel.extends[indexPath.row].item];
                }
            }else{
                [weakSelf.dict setObject:value forKey:self->_videoModel.extends[indexPath.row].item];
            }
            [weakSelf screeningandWithPage:1];
        };
        return cell;
    }else{
        SYVideoDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYVideoDetailCell" forIndexPath:indexPath];
        cell.model = self.videoModel.list[indexPath.row];
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0)return;
    item *model = self.videoModel.list[indexPath.row];
    SYVideoPlayerController *controller = [[SYVideoPlayerController alloc]init];
    controller.video_id = model.id;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)getMessage{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.Idstring forKey:@"id"];
    [HttpTool POST:[SY_VideoType getWholeUrl] param:dict success:^(id responseObject) {
        self.videoModel = [VideoTypeModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        //只有在这里放！！！！！！！才是最保险的！
        for (int i = 0; i<[self.videoModel.extends count]; i++) {
            SY_Class *item = self.videoModel.extends[i];
            item.item_list[0].isSeleted = YES;
        }
        [self.collectionView reloadData];
    } error:^(NSString *error) {
        
    }];
}


-(NSMutableDictionary *)dict{
    if (!_dict) {
        _dict = [[NSMutableDictionary alloc]init];
    }
    return _dict;
}
-(void)screeningandWithPage:(NSInteger)page{
    /*
     id    必选    number    分类ID
     —    可选    string    扩展分类。{“class”:”喜剧”}例子看备注
     page    可选    number    第几页，默认为1
     pageSize    可选    number    每页条数
     */
    [self.dict setObject:self.Idstring forKey:@"id"];
    [self.dict setObject:@(page) forKey:@"page"];
    [self.dict setObject:@(20) forKey:@"pageSize"];
    /*
     timestamp = "1553572410000",
     sign = "A819FFFD855CF799020B85D8C1D5E369",
     */

    
    
    
    [HttpTool POST:[SY_ChoseLoad getWholeUrl] param:self.dict success:^(id responseObject) {
        [self.videoModel.list removeAllObjects];
        if ([[responseObject objectForKey:@"data"] count]<20) {
            self.isHaveNextPage=NO;
        }else{
            self.isHaveNextPage =YES;
        }
        
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"]objectForKey:@"list"] ) {
            item *model = [item mj_objectWithKeyValues:dict];
            [self.videoModel.list addObject:model];
        }
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];

    } error:^(NSString *error) {
        
        [self.collectionView.mj_footer endRefreshing];
         [self.collectionView reloadData];
    }];

    
    

    
    
}





@end
