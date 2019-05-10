//
//  UITableView+ZXJTableviewCategory.h
//  乐氏同仁APP
//
//  Created by 张孝江 on 2018/9/6.
//  Copyright © 2018年 双木科技张晓红. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ZXJTableviewCategory)


-(void)setHidenLine;

-(void)setOthers;

-(void)XJRegisCellWithNibWithName:(NSString *)name;

-(void)XJRegisHeaderOrFooterforNibWithName:(NSString *)name;

-(void)XJRegisHeadeORfootWithClass:(NSString *)className;

@end
