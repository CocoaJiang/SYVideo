//
//  SYHotSearchCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/25.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYHotSearchCell.h"

@implementation SYHotSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _title.font = [UIFont systemFontOfSize:14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)setSearchDetailModel:(searchDetailModel *)searchDetailModel{
    _searchDetailModel = searchDetailModel;
    NSString *stringImageName = [NSString stringWithFormat:@"ico_searchpage_sorting_%ld",[searchDetailModel.rank integerValue]];
    _rankIcon.image = [UIImage imageNamed:stringImageName];
    _title.text = searchDetailModel.keyword;
    switch ([searchDetailModel.trend integerValue]) {
        case 0:
            _upOrDownicon.image = [UIImage imageNamed:@"平箭头"];
            break;
        case 1:
            _upOrDownicon.image = [UIImage imageNamed:@"上箭头"];
            break;
        case 2:
            _upOrDownicon.image = [UIImage imageNamed:@"下箭头"];
            break;
            
        default:[_upOrDownicon setHidden:YES];
            break;
    }

    //0什么都没有1火爆2热播其他则是字符高清度1080P蓝光
    switch ([searchDetailModel.hot integerValue]) {
        case 0:
            [_hotIcon setHidden:YES];
            break;
        case 1:
            _hotIcon.image = [UIImage imageNamed:@"火爆"];
            break;
        case 2:
            _hotIcon.image = [UIImage imageNamed:@"热播"];
            break;
            
        default:[_hotIcon setHidden:YES];
            break;
    }


    

    
}

@end
