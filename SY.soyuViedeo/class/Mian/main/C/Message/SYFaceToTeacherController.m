//
//  SYFaceToTeacherController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYFaceToTeacherController.h"
#import "SYInputQuestionView.h"
#import "SYSeletQuestionView.h"
#import "IQKeyboardManager.h"
@interface SYFaceToTeacherController ()
@property(strong,nonatomic)SYInputQuestionView *questionView;
@property(strong,nonatomic)SYSeletQuestionView *seletedQuestView;
@property(strong,nonatomic)UIButton *button;

@property(strong,nonatomic)UIScrollView *scrollView;



@end

@implementation SYFaceToTeacherController

-(void)viewWillAppear:(BOOL)animated{

}
-(void)viewWillDisappear:(BOOL)animated{

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈";
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.seletedQuestView];
    [self.scrollView addSubview:self.questionView];
    [self.scrollView addSubview:self.button];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.seletedQuestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(@160);
    }];
    [self.questionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.seletedQuestView.mas_bottom);
        make.height.mas_equalTo(@300);
    }];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.top.mas_equalTo(self.questionView.mas_bottom).offset(35);
        make.height.mas_equalTo(@40);
    }];
    
    [self.scrollView layoutIfNeeded];
    CGRect rect = [self.scrollView convertRect:self.button.frame toView:self.scrollView];
    if (rect.origin.y+self.button.height+10>SCREENH_HEIGHT) {
         self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, rect.origin.y+self.button.height+10);
    }else{
         self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREENH_HEIGHT);
    }
}

-(UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"提 交" forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button setBackgroundColor:KappBlue];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        _button.layer.cornerRadius = 10;
        _button.layer.masksToBounds = YES;
    }
    return _button;
}

-(void)buttonClick{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if ([self.seletedQuestView.seleArray count]<1) {
        [Tools showStatusWithString:@"请选择您遇到的问题"];
        return;
    }
    if ([self.questionView.textView.text isEmpty]) {
        [Tools showStatusWithString:@"请对问题详细描述"];
        return;
    }
    if ([self.questionView.QQtextField.text isEmpty]) {
        [Tools showStatusWithString:@"请输入您的QQ号"];
        return;
    }
    [dict setObject:self.seletedQuestView.seleArray forKey:@"issue"];
    [dict setObject:self.questionView.textView.text forKey:@"detail"];
    [dict setObject:self.questionView.QQtextField.text forKey:@"qq"];
    __weak typeof(self)weakSelf = self;
    [HttpTool POST:[SY_UpdataUserReport getWholeUrl] param:dict success:^(id responseObject) {
        [Tools showSuccess:[responseObject objectForKey:@"message"] andWithDoEveryThingWithBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    } error:^(NSString *error) {
        
    }];
}





-(SYInputQuestionView *)questionView{
    if (!_questionView) {
        _questionView = [Tools XJ_XibWithName:@"SYInputQuestionView"];
    }
    return _questionView;
}

-(SYSeletQuestionView *)seletedQuestView{
    if (!_seletedQuestView) {
        _seletedQuestView = [Tools XJ_XibWithName:@"SYSeletQuestionView"];
    }
    return _seletedQuestView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
}

@end
