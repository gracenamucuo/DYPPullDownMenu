//
//  ViewController.m
//  DYPCustomPullDownMenuDemo
//
//  Created by 戴运鹏 on 2017/5/30.
//  Copyright © 2017年 戴运鹏. All rights reserved.
//

#import "ViewController.h"
#import "DYPPullDownMenu.h"
#import "FirstViewController.h"
#define DYPScreenW [UIScreen mainScreen].bounds.size.width
#define DYPScreenH [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<DYPPullDownMenuDataSource>
@property (nonatomic,strong)NSArray *titles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor brownColor];
    DYPPullDownMenu *menu = [[DYPPullDownMenu alloc]init];
    menu.frame = CGRectMake(0, 20, DYPScreenW, 44);
    menu.dataSource = self;
    [self.view addSubview:menu];
    _titles = @[@"第一列"];
    [self setUpAllChildControllers];
    
    
    
    ///////
    
}

- (void)setUpAllChildControllers
{
    FirstViewController *firstVC = [[FirstViewController alloc]init];
    [self addChildViewController:firstVC];
}

- (NSInteger)numberOfColumnsInMenu:(DYPPullDownMenu *)pullDownMenu
{
    return 1;
}

- (UIButton*)pullDownMenu:(DYPPullDownMenu *)pullDownMenu buttonForColumnAtIndex:(NSInteger)index
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:_titles[index] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    return btn;
}

- (UIViewController *)pullDownMenu:(DYPPullDownMenu *)pullDownMenu viewControllerForColumnAtIndex:(NSInteger)index
{
    return self.childViewControllers[index];
}

- (CGFloat)pullDownMenu:(DYPPullDownMenu *)pullDownMenu heightForColumnAtIndex:(NSInteger)index
{
    if (index == 0) {
        return 400.f;
    }
    return 0.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end























































