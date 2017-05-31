//
//  UIView+Frame.h
//  DYPCustomPullDownMenuDemo
//
//  Created by daiyunpeng on 2017/5/31.
//  Copyright © 2017年 戴运鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat maxX;
@property (nonatomic,assign)CGFloat maxY;
@property (nonatomic,assign)CGFloat centerX;
@property (nonatomic,assign)CGFloat centerY;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGPoint origin;
@property (nonatomic,assign)CGSize size;

@end

@interface UIView (Category)

- (UIViewController*)viewController;


@end
