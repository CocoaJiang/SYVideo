//
//  UIView+extension.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (extension)
@property (nonatomic) CGFloat dd_left;

@property (nonatomic) CGFloat dd_top;

@property (nonatomic) CGFloat dd_right;

@property (nonatomic) CGFloat dd_bottom;

@property (nonatomic) CGFloat dd_width;

@property (nonatomic) CGFloat dd_height;

@property (nonatomic) CGFloat dd_centerX;

@property (nonatomic) CGFloat dd_centerY;

@property (nonatomic) CGPoint dd_origin;

@property (nonatomic) CGSize dd_size;

@property (nonatomic) CGPoint dd_center;

+ (id _Nullable )dd_loadFromXIB;

+ (id _Nullable )dd_loadFromXIBName:(NSString *_Nullable)xibName;

- (void)dd_createBordersWithColor:(UIColor * _Nonnull)color withCornerRadius:(CGFloat)radius andWidth:(CGFloat)width;

- (id _Nullable )subViewOfClassName:(NSString*_Nonnull)className;

-(void)makeBounsWithScrle:(CGFloat)scle;
-(void)makeYuanWithScle:(CGFloat)scle andWithToplef:(BOOL)topLeft andWithTopRight:(BOOL)topRight andWithBootomLeft:(BOOL)bootomLeft andWithBootomRight:(BOOL)bootomRight;
@end

NS_ASSUME_NONNULL_END
