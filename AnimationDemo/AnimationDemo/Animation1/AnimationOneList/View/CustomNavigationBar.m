//
//  CustomNavigationBar.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/7.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "CustomNavigationBar.h"
#import <Masonry.h>

@interface CustomNavigationBar ()

@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) UIButton *leftButton;

@property(nonatomic,strong) UIButton *rightButton;

@property(nonatomic,strong) UIView *line;


@end

@implementation CustomNavigationBar


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreen_Width, 64);
        
    }
    return self;
}





#pragma mark ------------------------click

- (void)clickLeftButton
{
    if (_delegate && [_delegate respondsToSelector:@selector(customNavigationBarClickLeftButton)]) {
        [_delegate customNavigationBarClickLeftButton];
    }
}

- (void)clickRightButton
{
    if (_delegate && [_delegate respondsToSelector:@selector(customNavigationBarClickRightButton)]) {
        [_delegate customNavigationBarClickRightButton];
    }
}

#pragma mark ------------------------setter

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.titleLabel.textColor = _titleColor;
}

- (void)setLeftImage:(NSString *)leftImage
{
    _leftImage = leftImage;
    
    [self.leftButton setImage:[UIImage imageNamed:_leftImage] forState:UIControlStateNormal];
}

- (void)setRightImage:(NSString *)rightImage
{
    _rightImage = rightImage;
    
    [self.rightButton setImage:[UIImage imageNamed:_rightImage] forState:UIControlStateNormal];
}


#pragma mark ------------------------getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.bottom.equalTo(@0);
            make.centerX.equalTo(self);
        }];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_leftButton];
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.equalTo(self.titleLabel);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(20);
        }];
        [_leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton){
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(self.titleLabel);
            make.width.height.mas_equalTo(20);
        }];
        [_rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc]init];
        [self addSubview:_line];
    }
    return _line;
}


@end
