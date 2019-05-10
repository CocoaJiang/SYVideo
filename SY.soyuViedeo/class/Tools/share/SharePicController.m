//
//  SharePicController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/29.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SharePicController.h"
#import "SharePicView.h"
#import "PlayModel.h"
#import "SYCollectionViewCell.h"
#import "SYShareObject.h"
@interface SharePicController ()

@property(strong,nonatomic)SharePicView *sharePicView;

@end

@implementation SharePicController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden =NO;
}


-(void)viewDidLoad{
    
    
    [self.dataSorces addObjectsFromArray:SHAREARRAY];
    [self.dataSorces removeLastObject];
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImgView.image = self.image;
    [self.view addSubview:bgImgView];
    bgImgView.userInteractionEnabled = YES;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, bgImgView.frame.size.width, bgImgView.frame.size.height);
    [bgImgView addSubview:effectView];
    
    [self.view addSubview:self.sharePicView];
    [self.sharePicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(300, 400));
    }];
    
    [self.view addSubview:self.collectionView];
     UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SYCollectionViewCell"];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.sharePicView.mas_bottom).offset(10);
        make.height.mas_equalTo(@88);
    }];
    
    
}

-(SharePicView *)sharePicView{
    if (!_sharePicView) {
        _sharePicView = [Tools XJ_XibWithName:@"SharePicView"];
        _sharePicView.pic.image = self.image;
        _sharePicView.name.text = self.info.name;
        _sharePicView.videoClass.text = [NSString stringWithFormat:@"分类：%@", self.info.Class];
        _sharePicView.videodiver.text = [NSString stringWithFormat:@"导演：%@",self.info.director];
        _sharePicView.vodeoActor.text = [NSString stringWithFormat:@"演员：%@",self.info.actor];
        _sharePicView.fromLabel.text = [NSString stringWithFormat:@"来自「%@」",[SYUSERINFO info].systemModel.site_name];
        _sharePicView.codeImage.image = [Tools imageWithUrl:[SYUSERINFO info].systemModel.shareURL imageSize:_sharePicView.codeImage.bounds.size.height];
    }
    return _sharePicView;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYCollectionViewCell" forIndexPath:indexPath];
    cell.title.text = self.dataSorces[indexPath.row];
    cell.title.textColor = [UIColor whiteColor];
    cell.imageview.image = [UIImage imageNamed:self.dataSorces[indexPath.row]];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSorces count];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, 88);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [SYShareObject shareWithImage:[self captureImageFromView:self.view] andWithUrl:nil andWithController:self andWithString:self.dataSorces[indexPath.row]];
}


-(UIImage *)captureImageFromView:(UIView *)view{
    self.collectionView.hidden = YES;
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size,NO, 0);
    [[UIColor clearColor] setFill];
    [[UIBezierPath bezierPathWithRect:self.view.bounds] fill];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.collectionView.hidden = NO;
    return image;
}

@end
