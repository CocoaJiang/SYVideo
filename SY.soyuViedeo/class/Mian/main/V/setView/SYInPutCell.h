//
//  SYInPutCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYInPutCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nicktextField;
@end

NS_ASSUME_NONNULL_END
