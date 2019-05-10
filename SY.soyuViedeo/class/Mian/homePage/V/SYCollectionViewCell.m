//
//  SYCollectionViewCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYCollectionViewCell.h"

@implementation SYCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageview.contentMode = UIViewContentModeScaleToFill;
    self.imageview.layer.masksToBounds=YES;
    self.imageview.layer.cornerRadius=50/2;
    
}

@end
