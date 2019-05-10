//
//  SYNavController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/14.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYNavController.h"
#import "SYNavCollectionViewCell.h"
#import "SYDetailCollectionController.h"

@interface SYNavController ()

@end

@implementation SYNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNAV];
    [self.dataSorces addObjectsFromArray:@[
                                           @"电影",
                                           @"电视剧",
                                           @"动漫",
                                           @"综艺",
                                           @"纪录片",
                                           @"音乐",
                                           @"体育",
                                           @"美食",
                                           @"旅行",
                                           @"军事",
                                           @"公开课",
                                           ]];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SYNavCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SYNavCollectionViewCell"];
    
    
}
-(void)setNAV{
    self.title = @"导航";
}
-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/3,SCREEN_WIDTH/3);
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYNavCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYNavCollectionViewCell" forIndexPath:indexPath];
    cell.title.text = self.dataSorces[indexPath.row];
    cell.icon.image = [UIImage  imageNamed:self.dataSorces[indexPath.row]];
    return cell;
}
//点击。。。
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SYDetailCollectionController *controller = [[SYDetailCollectionController alloc]init];
    controller.title = self.dataSorces[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
