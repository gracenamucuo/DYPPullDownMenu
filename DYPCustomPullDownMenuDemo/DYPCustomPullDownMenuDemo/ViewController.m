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
#import "SecondViewController.h"
#import "ImageButton.h"
#define DYPScreenW [UIScreen mainScreen].bounds.size.width
#define DYPScreenH [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<DYPPullDownMenuDataSource,DYPPullDownMenuDelegate>
@property (nonatomic,strong)NSArray *titles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    DYPPullDownMenu *menu = [[DYPPullDownMenu alloc]init];
  
    menu.frame = CGRectMake(0, 20, DYPScreenW, 44);
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    _titles = @[@"第一列",@"第二列"];
    [self setUpAllChildControllers];
    
}

- (void)setUpAllChildControllers
{
    FirstViewController *firstVC = [[FirstViewController alloc]init];
    [self addChildViewController:firstVC];
//    firstVC.firstSelectBlock = ^(NSString *str) {
//        NSLog(@"第一列打印");
//    };
    
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    [self addChildViewController:secondVC];
//    secondVC.secondSelectBlock = ^(NSString *str) {
//        NSLog(@"第二列打印");
//    };
    
    
    
    
}

#pragma mark -- DYPPullDownMenuDataDource

- (NSInteger)numberOfColumnsInMenu:(DYPPullDownMenu *)pullDownMenu
{
    return 2;
}

- (UIButton*)pullDownMenu:(DYPPullDownMenu *)pullDownMenu buttonForColumnAtIndex:(NSInteger)index
{
    ImageButton *btn = [ImageButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:_titles[index] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"shortStaffPullRepoIcon"] forState:UIControlStateNormal];
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
    
    if (index == 1) {
        return 300.f;
    }
    return 0.f;
}

#pragma mark -- DYPPullDownMenuDelegate
- (void)pullDownMenu:(DYPPullDownMenu *)pullDownMenu didSelectedColumn:(NSInteger)column info:(NSString *)info row:(NSInteger)row
{
    NSLog(@"第%ld列--%@--%ld",(long)column,info,(long)row);
}



@end























































