//
//  RegisAcountCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisAcountCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *eightsix;
@property (weak, nonatomic) IBOutlet UITextField *phonetextfield;
@property (weak, nonatomic) IBOutlet UITextField *vercode;
@property (weak, nonatomic) IBOutlet UIButton *regisButton;
@property (weak, nonatomic) IBOutlet UIButton *sendVerCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *readbutton;
@property (weak, nonatomic) IBOutlet UIButton *xieyibutton;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextfield;

@end

NS_ASSUME_NONNULL_END
