//
//  PhotoCollectionCell.m
//  BaseDemo
//
//  Created by 周鹏 on 2017/9/19.
//  Copyright © 2017年 周鹏. All rights reserved.
//

#import "PhotoCollectionCell.h"

@implementation PhotoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)deleteBtn:(id)sender {
    
    
    if (_deletePhotoBlock) {
        _deletePhotoBlock(self.index);
    }
}

@end
