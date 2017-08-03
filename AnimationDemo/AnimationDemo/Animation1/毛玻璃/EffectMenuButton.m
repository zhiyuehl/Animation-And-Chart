//
//  EffectMenuButton.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/13.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "EffectMenuButton.h"

@implementation EffectMenuButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //上图下文
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height+5;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y-10;

}

@end
