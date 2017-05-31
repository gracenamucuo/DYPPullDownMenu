//
//  ImageButton.m
//  DYPCustomPullDownMenuDemo
//
//  Created by daiyunpeng on 2017/5/31.
//  Copyright © 2017年 戴运鹏. All rights reserved.
//

#import "ImageButton.h"
#import "UIView+Frame.h"
@implementation ImageButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.x < self.titleLabel.x) {
        self.titleLabel.x = self.imageView.x;
        self.imageView.x = self.titleLabel.maxX + 10;
    }
}

@end
