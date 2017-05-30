//
//  DYPClickCover.m
//  DYPCustomPullDownMenuDemo
//
//  Created by 戴运鹏 on 2017/5/30.
//  Copyright © 2017年 戴运鹏. All rights reserved.
//

#import "DYPClickCover.h"

@implementation DYPClickCover

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_clickCover) {
        _clickCover();
    }
};

@end















