

//
//  SYHotScrollView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/21.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYHotScrollView.h"
#import "LKPagerView.h"

@interface SYHotScrollView ()<LKPagerViewDataSource,LKPagerViewDelegate>
@property(strong,nonatomic)LKPagerView *pagerView;
@end

@implementation SYHotScrollView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGBA(111, 113, 120, 1);
        NSArray *imageNames = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", @"6.jpg", @"7.jpg"];
        [self.imageArray addObjectsFromArray:imageNames];
        [self addSubview:self.pagerView];
        [self.pagerView registerClass:[LKPagerViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.pagerView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.pagerView selectItemAtIndex:0 animated:NO];
        });
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark
- (NSInteger)numberOfItemsInPagerView:(LKPagerView *)pagerView
{
    return self.imageArray.count;
}

- (LKPagerViewCell *)pagerView:(LKPagerView *)pagerView cellForItemAtIndex:(NSInteger)index
{
    LKPagerViewCell * cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cell" atIndex:index];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[index]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.clipsToBounds = YES;
    return cell;
}

#pragma mark - LKPagerViewDelegate
- (void)pagerView:(LKPagerView *)pagerView didSelectItemAtIndex:(NSInteger)index
{
    [pagerView deselectItemAtIndex:index animated:YES];
    [pagerView scrollToItemAtIndex:index animated:YES];
}

-(LKPagerView *)pagerView{
    if (!_pagerView) {
        _pagerView = [[LKPagerView alloc]initWithFrame:self.frame];
        _pagerView.delegate = self;
        _pagerView.dataSource = self;
         _pagerView.isInfinite = YES;
        _pagerView.scrollDirection = LKPagerViewScrollDirectionHorizontal;
        _pagerView.transformer = [[LKPagerViewTransformer alloc] initWithType:LKPagerViewTransformerTypeFerrisWheel];
        _pagerView.itemSize = CGSizeMake(160, 220);
  
    }
    return _pagerView;
}
- (BOOL)pagerView:(LKPagerView *)pagerView shouldHighlightItemAtIndex:(NSInteger)index{
    return YES;
}


-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc]init];
    }
    return _imageArray;
}

@end
