//
//  HLSectionScrollView.h
//  Test1
//
//  Created by tederen on 2017/6/29.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, SSTopTitleSelectType) {
    SSTopTitleSelectTypeLine,               //底部线条
    SSTopTitleSelectTypeFrame,              //变大
//    SSTopTitleSelectTypeEllipe,             //椭圆
};//上部标题点击效果


@class HLSectionScrollPageView;

@protocol HLSectionScrollPageViewDeletage <NSObject>

@optional

- (void)sectionScrollPageView:(HLSectionScrollPageView *)sectionScrollPageView didScrollToIndex:(NSInteger)index;

@end


@interface HLSectionScrollPageView : UIView


/**
 初始化

 @param frame farme
 @param topTitles 上部标题数组
 @param titleWidth 标题宽度
 @param titleHeight 标题高度
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame topTitles:(NSArray<NSString *> *)topTitles width:(CGFloat)titleWidth height:(CGFloat)titleHeight;


@property(nonatomic,weak) id<HLSectionScrollPageViewDeletage> delegate;

/**
 !!!底部views
 */
@property(nonatomic,strong) NSArray<UIView *> *bottomViews;

/**
 上部标题字体大小 defalut is 16
 */
@property(nonatomic,strong) UIFont *topTitlesFont;


/**
 上部标题字体颜色 default is black
 */
@property(nonatomic,strong) UIColor *topTitlesColor;

/**
 上部标题选择颜色 deault is red
 */
@property(nonatomic,strong) UIColor *topTitleSelectColor;

/**
 上部标题选择样式 default is SSTopTitleSelectTypeLine
 */
@property(nonatomic,assign) SSTopTitleSelectType topTitleSelectType;

/**
 下面线条的长度，default is titleWidth
 */
@property(nonatomic,assign) CGFloat lineWidth;














@end
