//
//  PhotoCollectionCell.h
//  BaseDemo
//
//  Created by 周鹏 on 2017/9/19.
//  Copyright © 2017年 周鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *phtotImg;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic,copy) void(^deletePhotoBlock)(NSInteger);

@end
