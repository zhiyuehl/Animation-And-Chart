//
//  EffectMenuView.h
//  AnimationDemo
//
//  Created by tederen on 2017/7/13.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EffectMenuView;

@protocol EffectMenuViewDelegate <NSObject>

- (void)effectMenuView:(EffectMenuView *)effectMenuView didSelectMenuIndex:(NSInteger)index;

@end

@interface EffectMenuView : UIView

/**
 初始化

 @param buttonImages 图片
 @param buttonTitles 标题，需与图片一致
 @return view
 */
- (instancetype)initWithMenuButtonImages:(NSArray *)buttonImages
                            buttonTitles:(NSArray *)buttonTitles;

//显示
- (void)show;


@property(nonatomic,weak) id<EffectMenuViewDelegate> delegate;


@end
