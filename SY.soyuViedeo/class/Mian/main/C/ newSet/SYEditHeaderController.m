//
//  SYEditHeaderController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/7.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYEditHeaderController.h"

#import "SYEditHeaderItem.h"

#import "NSString+Seleted.h"

@interface SYEditHeaderController ()

@end

@implementation SYEditHeaderController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self getMessage];
    
    self.title = @"修改头像";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"确认" forState:UIControlStateNormal];
    
    button.size = CGSizeMake(50, 50);
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    button.clickAction = ^(UIButton *button) {
      
        [self editHeader];
        
    };
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = item;
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(self.view);
        
    }];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SYEditHeaderItem" bundle:nil] forCellWithReuseIdentifier:@"SYEditHeaderItem"];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYEditHeaderItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYEditHeaderItem" forIndexPath:indexPath];
    NSDictionary *dict = self.dataSorces[indexPath.row];
    NSString *urlString = dict[@"url"];
    if (urlString.isSeleted) {
        item.bgView.backgroundColor = RGBA(0, 0, 0, 0.4);
    }else{
        item.bgView.backgroundColor = [UIColor clearColor];
    }
    item.seletedImageView.hidden = !urlString.isSeleted;
    [item.iconImageView XJ_setImageWithURLString:urlString];
    return item;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/4, SCREEN_WIDTH/4);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataSorces[indexPath.row];
    NSString *string = dict[@"url"];
    if (string.isSeleted) {
        return;
    }else{
        for (NSDictionary *dictionary in self.dataSorces) {
            NSString *url = [dictionary objectForKey:@"url"];
            url.isSeleted = NO;
        }
    }
    string.isSeleted = YES;
    
    [self.collectionView reloadData];
}

-(void)getMessage{
    [HttpTool POST:[SY_choseHeaderImage getWholeUrl] param:nil success:^(id responseObject) {
        self.dataSorces = [responseObject objectForKey:@"data"];
        [self.collectionView reloadData];
    } error:^(NSString *error) {
        
    }];
    
}


////拿到确认的头像来显示。。。

-(NSString *)retrunStringVur{
    //
    
    for (NSDictionary *dict in self.dataSorces) {
        
        NSString *string = dict[@"url"];
        
        if (string.isSeleted) {
            
            return [dict objectForKey:@"val"];
        }
        
    }
    
    return nil;
    
}

///修改用户信息。。。

-(void)editHeader{
    
    
    NSString *string = [self retrunStringVur];
    
    if ([string isEmpty] || string == nil) {
        
        [Tools showErrorWithString:@"请选择一个头像"];
        
        return;
        
    }
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setObject:string forKey:@"portrait"];
    
    [HttpTool POST:[SY_edit getWholeUrl] param:dict success:^(id responseObject) {
        

    } error:^(NSString *error) {
        
    }];
    
}



@end
