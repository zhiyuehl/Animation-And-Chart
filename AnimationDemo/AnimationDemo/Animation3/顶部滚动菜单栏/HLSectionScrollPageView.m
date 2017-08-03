//
//  HLSectionScrollView.m
//  Test1
//
//  Created by tederen on 2017/6/29.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "HLSectionScrollPageView.h"
#import <Masonry.h>

#define SSTopButtonTag 1000

@interface HLSectionScrollPageView ()<UIScrollViewDelegate>
/**
 上部滚动图
 */
@property(nonatomic,strong) UIScrollView *topScrollView;
/**
 下部滚动图
 */
@property(nonatomic,strong) UIScrollView *bottomScrollView;
/**
 上部按钮标题
 */
@property(nonatomic,strong) NSArray *topTitles;
/**
 按钮宽度
 */
@property(nonatomic,assign) CGFloat titleWidth;
/**
 按钮高度
 */
@property(nonatomic,assign) CGFloat titleHeight;

/**
 当前选择的按钮
 */
@property(nonatomic,strong) UIButton *currentSelectButton;




@property(nonatomic,strong) UIView *topLine;



@end

@implementation HLSectionScrollPageView


- (instancetype)initWithFrame:(CGRect)frame topTitles:(NSArray<NSString *> *)topTitles width:(CGFloat)titleWidth height:(CGFloat)titleHeight
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _topTitlesColor = [UIColor blackColor];
        _topTitlesFont = [UIFont systemFontOfSize:16];
        _topTitleSelectColor = [UIColor redColor];
        
        _topTitleSelectType = SSTopTitleSelectTypeLine;
        
        _topTitles = topTitles;
        _titleWidth = titleWidth;
        _titleHeight = titleHeight;
        
        _lineWidth = _titleWidth;
        
        [self initializeTopScrollView];
        
    }
    return self;
}


- (void)initializeTopScrollView
{
    for (int i = 0; i < _topTitles.count; i ++) {
        CGFloat x = i * _titleWidth;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, 0, _titleWidth, _titleHeight);
        [btn setTitle:_topTitles[i] forState:UIControlStateNormal];
        [btn setTitleColor:_topTitlesColor forState:UIControlStateNormal];
        [btn setTitleColor:_topTitleSelectColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickTopTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = _topTitlesFont;
        btn.tag = SSTopButtonTag+i;
        [self.topScrollView addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
            _currentSelectButton = btn;
        }
    }
    self.topScrollView.contentSize = CGSizeMake(_titleWidth*_topTitles.count, 0);
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    line.frame = CGRectMake(0, _titleHeight, self.frame.size.width, 0.5);
    [self addSubview:line];
    self.topLine.hidden = NO;
    [self addSubview:self.bottomScrollView];
}


#pragma mark ------------------------private methods
//设置选中时动画
- (void)topTitleSelectTypeAnimated
{
    switch (_topTitleSelectType) {
        case SSTopTitleSelectTypeLine:
        {
            [UIView animateWithDuration:0.3 animations:^{
               self.topLine.transform = CGAffineTransformMakeTranslation(_currentSelectButton.frame.origin.x, 0);
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case SSTopTitleSelectTypeFrame:
        {
            [self.topLine removeFromSuperview];
            [UIView animateWithDuration:0.3 animations:^{
                _currentSelectButton.transform = CGAffineTransformMakeScale(1.3, 1.3);
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        default:
            break;
    }
}

//设置选中按钮
- (void)selectButtonAnimatedWithButton:(UIButton *)sender
{
    _currentSelectButton.selected = NO;
    _currentSelectButton.transform = CGAffineTransformIdentity;
    
    
    sender.selected = YES;
    _currentSelectButton = sender;
}
//计算button，设置居中
- (void)calueteButtonCenterWithButton:(UIButton *)sender
{
    if (self.topScrollView.contentSize.width <= self.frame.size.width) {
        return;
    }
    //计算偏移
    if (sender.center.x > self.frame.size.width/2 && sender.center.x < self.topScrollView.contentSize.width - self.frame.size.width/2) {
        [self.topScrollView setContentOffset:CGPointMake(sender.center.x - self.frame.size.width/2, 0) animated:YES];
    }else if (sender.center.x < self.frame.size.width/2){
        [self.topScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else {
        [self.topScrollView setContentOffset:CGPointMake(self.topScrollView.contentSize.width - self.frame.size.width, 0) animated:YES];
    }
}
//刷新界面并传出点击事件
- (void)refreshInterfaceWithScrollView:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    if (scrollView == self.topScrollView) {
        
    }else if (scrollView == self.bottomScrollView) {
        NSInteger index = (NSInteger)(offsetX / self.frame.size.width);
        UIButton *button = [self viewWithTag:index+SSTopButtonTag];
        
        [self selectButtonAnimatedWithButton:button];
        [self topTitleSelectTypeAnimated];
        [self calueteButtonCenterWithButton:button];
        if (_delegate && [_delegate respondsToSelector:@selector(sectionScrollPageView:didScrollToIndex:)]) {
            [_delegate sectionScrollPageView:self didScrollToIndex:index];
        }
    }
}

#pragma mark ------------------------click

- (void)clickTopTitleButton:(UIButton *)sender
{
    NSInteger tag = sender.tag - SSTopButtonTag;
    
    [self selectButtonAnimatedWithButton:sender];
    [self topTitleSelectTypeAnimated];
    [self calueteButtonCenterWithButton:sender];
    
    [self.bottomScrollView setContentOffset:CGPointMake(tag*self.frame.size.width, 0) animated:YES];
    
}



#pragma mark ------------------------UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.bottomScrollView && scrollView.isDragging && _topTitleSelectType == SSTopTitleSelectTypeLine) {
        CGFloat offsetX = scrollView.contentOffset.x;
        self.topLine.transform = CGAffineTransformMakeTranslation(_currentSelectButton.frame.origin.x+_titleWidth*((offsetX-(_currentSelectButton.tag-SSTopButtonTag)*kScreen_Width)/kScreen_Width), 0);
        
        NSInteger index = (NSInteger)(offsetX / self.frame.size.width);
        UIButton *button = [self viewWithTag:index+SSTopButtonTag];
        
        [self selectButtonAnimatedWithButton:button];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self refreshInterfaceWithScrollView:scrollView];
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    [self refreshInterfaceWithScrollView:scrollView];
}


#pragma mark ------------------------setter

- (void)setBottomViews:(NSArray<UIView *> *)bottomViews
{
    _bottomViews = bottomViews;
    self.bottomScrollView.contentSize = CGSizeMake(self.frame.size.width*_bottomViews.count, 0);

    
    //隐藏标题，请注释下面代码
    for (int i = 0;i < bottomViews.count;i ++) {
        UIView *view = bottomViews[i];
        CGRect rect = CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.bottomScrollView.frame.size.height);
        view.frame = rect;
        [self.bottomScrollView addSubview:view];
        
        
        UILabel *indexLabel = [[UILabel alloc]init];
        indexLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        indexLabel.bounds = CGRectMake(0, 0, 100, 100);
        indexLabel.font = [UIFont systemFontOfSize:36];
        indexLabel.textColor = [UIColor redColor];
        indexLabel.textAlignment = NSTextAlignmentCenter;
        indexLabel.text = _topTitles[i];
        [view addSubview:indexLabel];
        
    }
    
}


- (void)setTopTitlesFont:(UIFont *)topTitlesFont
{
    _topTitlesFont = topTitlesFont;
    for (int i = 0; i < self.topTitles.count; i ++) {
        UIButton *btn = (UIButton *)[self viewWithTag:SSTopButtonTag + i];
        btn.titleLabel.font = _topTitlesFont;
    }
}

- (void)setTopTitlesColor:(UIColor *)topTitlesColor
{
    _topTitlesColor = topTitlesColor;
    for (int i = 0; i < self.topTitles.count; i ++) {
        UIButton *btn = (UIButton *)[self viewWithTag:SSTopButtonTag + i];
        [btn setTitleColor:_topTitlesColor forState:UIControlStateNormal];
    }
}

- (void)setTopTitleSelectColor:(UIColor *)topTitleSelectColor
{
    _topTitleSelectColor = topTitleSelectColor;
    for (int i = 0; i < self.topTitles.count; i ++) {
        UIButton *btn = (UIButton *)[self viewWithTag:SSTopButtonTag + i];
        [btn setTitleColor:_topTitleSelectColor forState:UIControlStateSelected];
    }
    self.topLine.backgroundColor = _topTitleSelectColor;
}

- (void)setTopTitleSelectType:(SSTopTitleSelectType)topTitleSelectType
{
    _topTitleSelectType = topTitleSelectType;
    [self topTitleSelectTypeAnimated];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    self.topLine.frame = CGRectMake((_titleWidth-_lineWidth)/2, _titleHeight-2, _lineWidth, 2);
}


#pragma mark ------------------------getter

- (UIScrollView *)topScrollView
{
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, _titleHeight)];
        _topScrollView.showsVerticalScrollIndicator = NO;
        _topScrollView.showsHorizontalScrollIndicator = NO;
        _topScrollView.backgroundColor = [UIColor whiteColor];
        _topScrollView.delegate = self;
        [self addSubview:_topScrollView];
    }
    
    return _topScrollView;
}


- (UIScrollView *)bottomScrollView
{
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _titleHeight, self.frame.size.width, self.frame.size.height-_titleHeight)];
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.showsVerticalScrollIndicator = NO;
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        _bottomScrollView.delegate = self;
        _bottomScrollView.bounces = NO;
        [self addSubview:_bottomScrollView];
    }
    
    return _bottomScrollView;
}

- (UIView *)topLine
{
    if (!_topLine) {
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor = _topTitleSelectColor;
        _topLine.frame = CGRectMake((_titleWidth-_lineWidth)/2, _titleHeight-2, _lineWidth, 2);
        [self.topScrollView addSubview:_topLine];
    }
    return _topLine;
}


@end
