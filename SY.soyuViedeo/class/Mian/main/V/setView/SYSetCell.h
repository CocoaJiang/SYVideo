//
//  SYSetCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SetCllType){
    CellTpyeJiantou=0,
    CellTypeSwitch=1,
    CellTypeText=2,
    CellTypeJiantouAndText=3,
    CellTypeMessage=4,
};


NS_ASSUME_NONNULL_BEGIN

@interface SYSetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *redPoint;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *jiantou;
@property (weak, nonatomic) IBOutlet UISwitch *SYswitch;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property(assign,nonatomic)SetCllType type;
@property(copy,nonatomic)void(^SwitchBlock)(NSString *titleString, NSInteger index);

@end

NS_ASSUME_NONNULL_END
