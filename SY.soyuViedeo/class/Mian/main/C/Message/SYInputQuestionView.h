//
//  SYInputQuestionView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYInputQuestionView : UIView
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *QQtextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *induceOne;
@property (weak, nonatomic) IBOutlet UILabel *induceTwo;

@end

NS_ASSUME_NONNULL_END
