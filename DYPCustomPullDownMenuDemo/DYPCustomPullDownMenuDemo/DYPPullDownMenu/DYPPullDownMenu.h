//
//  DYPPullDownMenu.h
//  DYPCustomPullDownMenuDemo
//
//  Created by 戴运鹏 on 2017/5/30.
//  Copyright © 2017年 戴运鹏. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class DYPPullDownMenu,DYPPullDownItem;

@protocol DYPPullDownMenuDataSource <NSObject>

/**
 返回有几列

 @param pullDownMenu 下拉菜单
 @return 列数
 */
- (NSInteger)numberOfColumnsInMenu:(DYPPullDownMenu*)pullDownMenu;


/**
 返回下拉菜单的点击按钮

 @param pullDownMenu 下拉菜单
 @param index 列的索引
 @return 返回按钮
 */
- (UIButton*)pullDownMenu:(DYPPullDownMenu*)pullDownMenu buttonForColumnAtIndex:(NSInteger)index;


/**
 返回下拉菜单每列对应的控制器

 @param pullDownMenu 下拉菜单
 @param index 索引
 @return 返回对应的控制器。
 */
- (UIViewController*)pullDownMenu:(DYPPullDownMenu*)pullDownMenu viewControllerForColumnAtIndex:(NSInteger)index;

/**
 返回每列下拉菜单的高度

 @param pullDownMenu 下拉菜单
 @param index 索引
 @return 高度
 */
- (CGFloat)pullDownMenu:(DYPPullDownMenu*)pullDownMenu heightForColumnAtIndex:(NSInteger)index;

@end

@protocol DYPPullDownMenuDelegate <NSObject>

/**
 点击了下拉列表

 @param pullDownMenu 下拉菜单
 @param column 点击的列
 @param info 点击的行的内容
 */
- (void)pullDownMenu:(DYPPullDownMenu*)pullDownMenu didSelectedColumn:(NSInteger)column info:(NSString*)info row:(NSInteger)row;

@end


extern NSString *const DYPUpdateMenuTitleNoti;



@interface DYPPullDownMenu : UIView

/**
 下拉菜单数据源
 */
@property (nonatomic,weak)id<DYPPullDownMenuDataSource>dataSource;

/**
 下拉菜单代理
 */
@property (nonatomic,weak)id<DYPPullDownMenuDelegate> delegate;

/**
 分割线颜色
 */
@property (nonatomic,strong)UIColor *splitLineColor;


/**
 风恶心距离顶部间距，默认10
 */
@property (nonatomic,assign)NSInteger splitLineTopMargin;

/**
 蒙版颜色
 */
@property (nonatomic,strong)UIColor *coverColor;

/**
 刷新下拉菜单
 */
- (void)reload;
@end















