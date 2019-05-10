//
//  LSLoadPhotoTableViewCell.m
//  乐氏同仁APP
//
//  Created by Mac on 2018/11/7.
//  Copyright © 2018 双木科技张晓红. All rights reserved.
//

#import "LSLoadPhotoTableViewCell.h"
#import "PhotoCollectionCell.h"

static CGFloat const MGIN = 5;

@interface LSLoadPhotoTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic)NSMutableArray *attesSeltedArray;
@property (nonatomic,strong)UICollectionView *collectionView;
@property(strong,nonatomic)NSMutableArray *selectedAssets;
@end
@implementation LSLoadPhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //标题
        UILabel * titleLab =[[UILabel alloc]init];
        titleLab.text = @"图片(最多上传9张照片)";
        titleLab.font = [UIFont systemFontOfSize:16];
        titleLab.frame = CGRectMake(16, 10, 220, 17);
        titleLab.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:titleLab];
        //我要更改样式
        UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = MGIN;
        // 2.设置 最小列间距
        flowLayout. minimumInteritemSpacing  = CGFLOAT_MIN;
        flowLayout.scrollDirection =  UICollectionViewScrollDirectionVertical;
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor =[UIColor whiteColor];
        [self.collectionView setShowsVerticalScrollIndicator:NO];
        [self.collectionView setShowsHorizontalScrollIndicator:NO];
        self.collectionView.dataSource=self;
        self.collectionView.delegate=self;
        self.collectionView.scrollEnabled = NO;
        [self.contentView addSubview:self.collectionView];
        [_collectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([PhotoCollectionCell class ])];
        UIView *line =[[UIView alloc]init];
        line.backgroundColor = RGBA(234, 234, 234, 1);
        [self.contentView addSubview:line];
        line.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(5);
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLab.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
            make.top.mas_equalTo(titleLab.mas_bottom).offset(10);
            make.bottom.mas_equalTo(line.mas_top).offset(-5);
        }];
    }
    return self;
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.selectedAssets.count>=9) {
        return 9;
    }
    return self.selectedAssets.count +1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PhotoCollectionCell class]) forIndexPath:indexPath];
    if (indexPath.row == self.selectedAssets.count) {
        cell.phtotImg.hidden = YES;
        cell.deleteBtn.hidden = YES;
    } else {
        cell.phtotImg.hidden = NO;
        cell.deleteBtn.hidden = NO;
        NSObject *obj = self.selectedAssets[indexPath.row];
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *imgUrl = self.selectedAssets[indexPath.row];
            [cell.phtotImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil];
        }else{
            UIImage *image = self.selectedAssets[indexPath.row];
            cell.phtotImg.image = image;
        }
        cell.index = indexPath.row;
        [cell setDeletePhotoBlock:^(NSInteger index){
            [self deleteClikWithIndex:index];
            [self cancleCellHeight];
        }];
        
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = (SCREEN_WIDTH-_collectionView.left-(SCREEN_WIDTH-_collectionView.right)-MGIN *2)/3;
    return CGSizeMake(height, height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.selectedAssets.count) {
        [self addPhotoBlockPicture];
    }
}





#pragma mark - //右上角删除图片按钮
- (void)deleteClikWithIndex :(NSInteger)index
{
    [self.selectedAssets removeObjectAtIndex:index];
    [self.attesSeltedArray removeObjectAtIndex:index];
    [self cancleCellHeight];
    [_collectionView reloadData];
}

//上传图片
- (void)addPhotoBlockPicture{
    
    [Tools XJ_morePickerController:[Tools viewController:self] image:^(NSArray *images) {
        self.selectedAssets =(NSMutableArray *)images;
        [self.collectionView reloadData];
        [self cancleCellHeight];
    } :9 andSeletedArray:self.attesSeltedArray andWithAttesBlock:^(NSArray *attesArray) {
        self.attesSeltedArray = (NSMutableArray *)attesArray;
    }];
    

    
}

-(void)cancleCellHeight{
    CGFloat height = (SCREEN_WIDTH-_collectionView.left-(SCREEN_WIDTH-_collectionView.right)-MGIN *2)/3;
    if (self.addOrDelegateImage) {
        self.addOrDelegateImage(self.selectedAssets, height);
    }
}

-(NSMutableArray *)selectedAssets{
    if (!_selectedAssets) {
        _selectedAssets = [[NSMutableArray alloc]init];
    }
    return _selectedAssets;
}

-(NSMutableArray *)attesSeltedArray{
    if (!_attesSeltedArray) {
        _attesSeltedArray = [[NSMutableArray alloc]init];
    }
    return _attesSeltedArray;
}



@end
