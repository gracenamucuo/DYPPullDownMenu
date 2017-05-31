//
//  FirstViewController.h
//  DYPCustomPullDownMenuDemo
//
//  Created by 戴运鹏 on 2017/5/30.
//  Copyright © 2017年 戴运鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^firstSelectBlock)(NSString *str);

@interface FirstViewController : UIViewController

@property (nonatomic,copy)firstSelectBlock firstSelectBlock;

@end
