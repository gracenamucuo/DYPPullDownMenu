//
//  DYPPullDownMenu.m
//  DYPCustomPullDownMenuDemo
//
//  Created by 戴运鹏 on 2017/5/30.
//  Copyright © 2017年 戴运鹏. All rights reserved.
//

#import "DYPPullDownMenu.h"
#import "DYPClickCover.h"
NSString *const DYPUpdateMenuTitleNoti = @"DYPUpdateMenuTitleNoti";
@interface DYPPullDownMenu ()

/**
 下拉菜单所有按钮
 */
@property (nonatomic,strong)NSMutableArray *menuButtons;

/**
 下拉菜单所有分割线
 */
@property (nonatomic,strong)NSMutableArray *spliteLines;

/**
 下拉菜单所有控制器
 */
@property (nonatomic,strong)NSMutableArray *controllers;

/**
 下拉菜单每列高度
 */
@property (nonatomic,strong)NSMutableArray *columsHeight;

/**
 下拉菜单内容View
 */
@property (nonatomic,strong)UIView *contentView;

/**
 下拉菜单蒙版
 */
@property (nonatomic,strong)DYPClickCover *coverView;

/**
下拉菜单底部View
 */
@property (nonatomic,strong)UIView *bottomView;

/**
 观察者
 */
@property (nonatomic,weak)id observer;
@end


@implementation DYPPullDownMenu
#pragma mark --懒加载
- (NSMutableArray*)spliteLines
{
    if (nil == _spliteLines) {
        _spliteLines = [[NSMutableArray alloc]init];
    }
    return _spliteLines;
}

- (NSMutableArray *)menuButtons
{
    if (_menuButtons == nil) {
        _menuButtons = [[NSMutableArray alloc] init];
    }
    return _menuButtons;
}

- (NSMutableArray *)controllers
{
    if (nil == _controllers) {
        _controllers = [[NSMutableArray alloc] init];
    }
    return _controllers;
}

- (NSMutableArray*)columsHeight
{
    if (nil == _columsHeight) {
        _columsHeight = [[NSMutableArray alloc]init];
    }
    return _columsHeight;
}

- (DYPClickCover *)coverView
{
    if (nil == _coverView) {
        CGFloat coverX = 0.f;
        CGFloat coverY = CGRectGetMaxY(self.frame);
        CGFloat coverW = self.frame.size.width;
        CGFloat coverH = self.superview.bounds.size.height - coverY;
        _coverView = [[DYPClickCover alloc]initWithFrame:CGRectMake(coverX, coverY, coverW, coverH)];
        _coverView.backgroundColor = _coverColor;
        [self.superview addSubview:_coverView];
        __weak typeof(self) weakSelf = self;
        _coverView.clickCover = ^{
            [weakSelf dismiss];
        };
    }
    
    return _coverView;
}

- (UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.frame = CGRectMake(0, 0, self.bounds.size.width, 0);
        _contentView.clipsToBounds = YES;
        [self.coverView addSubview:_contentView];
    }
    return _contentView;
}

#pragma mark --初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}


- (void)setUp
{
    self.backgroundColor = [UIColor whiteColor];
    _splitLineTopMargin = 10;
    _splitLineColor = [UIColor lightGrayColor];
    _coverColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    _observer = [[NSNotificationCenter defaultCenter]addObserverForName:DYPUpdateMenuTitleNoti object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSInteger col = [self.controllers indexOfObject:note.object];
        
        UIButton *btn = self.menuButtons[col];
        
        [self dismiss];
        
        [btn setTitle:note.userInfo[@"title"] forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(pullDownMenu:didSelectedColumn:info:row:)]) {
            [self.delegate pullDownMenu:self didSelectedColumn:col info:note.userInfo[@"title"] row:[note.userInfo[@"row"] integerValue]];
        }
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = self.menuButtons.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.bounds.size.width / count;
    CGFloat btnH = self.bounds.size.height;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *btn = self.menuButtons[i];
        btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        if (i < count - 1) {
            UIView *splite = self.spliteLines[i];
            splite.frame = CGRectMake(CGRectGetMaxX(btn.frame), _splitLineTopMargin, 1, btnH - 2 * _splitLineTopMargin);
        
        }
    }
    
    CGFloat bottomH =1;
    CGFloat bottomY = btnH - bottomH;
    _bottomView.frame = CGRectMake(0, bottomY, self.bounds.size.width, bottomH);
    
}

#pragma mark -- 即将进入窗口
- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    [self reload];
}

#pragma mark -- 下拉菜单功能
- (void)clear
{
    self.bottomView=  nil;
    self.coverView = nil;
    self.contentView = nil;
    [self.menuButtons removeAllObjects];
    [self.controllers removeAllObjects];
    [self.columsHeight removeAllObjects];
    [self.spliteLines removeAllObjects];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)reload
{
    [self clear];
    if (self.dataSource == nil) {
        return;
    }
    
    if (self.menuButtons.count) {
        return;
    }
    
    if (![self.dataSource respondsToSelector:@selector(numberOfColumnsInMenu:)]) {
        @throw [NSException exceptionWithName:@"DYPError" reason:@"没有实现(numberOfColumnsInMenu)" userInfo:nil];
    }
    
    if (![self.dataSource respondsToSelector:@selector(pullDownMenu:buttonForColumnAtIndex:)]) {
        @throw [NSException exceptionWithName:@"DYPError" reason:@"没有实现(pullDownMenu:buttonForColumnAtIndex:)" userInfo:nil];
    }

    
    if (![self.dataSource respondsToSelector:@selector(pullDownMenu:viewControllerForColumnAtIndex:)]) {
        @throw [NSException exceptionWithName:@"DYPError" reason:@"没有实现(pullDownMenu:viewControllerForColumnAtIndex:)" userInfo:nil];
    }
    
    NSInteger columns = [self.dataSource numberOfColumnsInMenu:self];
    if (columns == 0) {
        return;
    }
    
    for (NSInteger col = 0; col < columns; col ++) {
        UIButton *menuBtn = [self.dataSource pullDownMenu:self buttonForColumnAtIndex:col];
        menuBtn.tag = col;
        [menuBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (menuBtn == nil) {
            @throw [NSException exceptionWithName:@"DYPError" reason:@"不能返回空按钮" userInfo:nil];
            return;
        }
        
        [self addSubview:menuBtn];
        [self.menuButtons addObject:menuBtn];
        CGFloat height = [self.dataSource pullDownMenu:self heightForColumnAtIndex:col];
        [self.columsHeight addObject:@(height)];
        UIViewController *vc = [self.dataSource pullDownMenu:self viewControllerForColumnAtIndex:col];
        [self.controllers addObject:vc];
    }
    
    NSInteger count = columns - 1;
    for (NSInteger i = 0; i < count; i++) {
        UIView *splite = [[UIView alloc]init];
        splite.backgroundColor = _splitLineColor;
        [self addSubview:splite];
        [self.spliteLines addObject:splite];
    }
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = _splitLineColor;
    _bottomView = bottomView;
    [self addSubview:bottomView];
    [self layoutSubviews];//设置子控件尺寸
    
    
}

- (void)dismiss
{
    for (UIButton *btn  in self.menuButtons) {
        btn.selected = NO;
    }
    
    self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.contentView.frame;
        frame.size.height = 0;
        self.contentView.frame = frame;
    } completion:^(BOOL finished) {
        self.coverView.hidden = YES;
        self.coverView.backgroundColor = _coverColor;
    }];
    
}

- (void)btnClick:(UIButton*)button
{
    button.selected = !button.selected;
    for (UIButton *btn in self.menuButtons) {
        if (button == btn) {
            continue;
        }
        btn.selected = NO;
    }
    if (button.selected == YES) {
        self.coverView.hidden = NO;
        NSInteger i = button.tag;
        //移除之前子控制器的view
        [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        //添加对应子控制器的view
        UIViewController *vc = self.controllers[i];
        vc.view.frame = self.contentView.bounds;
        [self.contentView addSubview:vc.view];
        CGFloat height = [self.columsHeight[i] floatValue];
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.contentView.frame;
            frame.size.height = height;
            self.contentView.frame= frame;
        } completion:nil];
        
    }else{
        [self dismiss];
    }
}

- (void)dealloc
{
    [self clear];
    [[NSNotificationCenter defaultCenter]removeObserver:_observer];
}

@end






























