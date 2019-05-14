//
//  SYTableViewHeader.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYTableViewHeader.h"

@implementation SYTableViewHeader

- (IBAction)clik:(UIButton *)sender {
    
    if (self.click) {
        self.click();
    }
    
}


-(void)awakeFromNib{
    [super awakeFromNib];
    _title.font = [UIFont systemFontOfSize:16];
}

@end
