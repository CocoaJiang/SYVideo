//
//  SYSearchViewDevice.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/30.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYSearchViewDevice.h"

@interface SYSearchViewDevice ()
@property(strong,nonatomic)UIImageView *searchImageView;
@property(strong,nonatomic)UILabel *label;
@end


@implementation SYSearchViewDevice


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.searchImageView];
        [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.searchImageView.mas_bottom).offset(30);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}



-(UIImageView *)searchImageView{
    if (!_searchImageView) {
        NSMutableArray *images = [[NSMutableArray alloc]init];
        NSArray *array = @[@"a7i",@"a7j",@"a7k",@"a7l",@"a7m",@"a7n",@"a7o",@"a7p",@"a7q",@"a7r",@"a7s",@"a7t",@"a7u",@"a7v",@"a7w",@"a7x",@"a7y",@"a7z"];
        for (NSString *string in array) {
            UIImage *image  = [UIImage imageNamed:string];
            [images addObject:image];
        }
        UIImage *image = [UIImage animatedImageWithImages:images duration:0.3];
        _searchImageView = [[UIImageView alloc]initWithImage:image];
        [_searchImageView sizeToFit];
    }
    return _searchImageView;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.textColor = [UIColor darkTextColor];
        _label.font = [UIFont systemFontOfSize:14];
        _label.text = @"正在搜索设备";
        [_label sizeToFit];
        
    }
    return _label;
}



@end
