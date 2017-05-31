//
//  SecondViewController.h
//  DYPCustomPullDownMenuDemo
//
//  Created by daiyunpeng on 2017/5/31.
//  Copyright © 2017年 戴运鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^secondSelectBlock)(NSString *str);

@interface SecondViewController : UIViewController

@property (nonatomic,copy)secondSelectBlock secondSelectBlock;

@end
