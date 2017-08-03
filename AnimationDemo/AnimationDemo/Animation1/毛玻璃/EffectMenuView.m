//
//  EffectMenuView.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/13.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "EffectMenuView.h"
#import "EffectMenuButton.h"

static const NSInteger      CountForRow = 4;            //一行个数
static const NSTimeInterval ShowAnimationTime = 0.8;   //按钮动画时间
static const NSTimeInterval EffectBackAlphaTime = 0.4;  //背景渐变时间
static const CGFloat        BottomHeight = 100.f;       //距离下边高度
static const CGFloat        DelayTime = 0.05f;          //延迟时间

#define ViewWidth  [UIScreen mainScreen].bounds.size.width
#define ViewHeight [UIScreen mainScreen].bounds.size.height

#define ButtonScrollGap 100.f  //按钮距scrollView上距离
#define ButtonGap 20.f    //每行按钮行距
#define ButtonTag 1000

#define ButtonWidth (ViewWidth/(CountForRow+(CountForRow+1)/2.0))    //按钮宽
#define ButtonHeight (ButtonWidth*1.6)                                   //按钮高

@interface EffectMenuView ()<UIScrollViewDelegate>
/**
 deafult is UIBlurEffectStyleLight。
 */
@property(nonatomic,strong) UIBlurEffect *blurEffect;
/**
 deafult is UIBlurEffectStyleLight。
 */
@property(nonatomic,assign) UIBlurEffectStyle blurEffectStyle;
/**
 背景
 */
@property(nonatomic,strong) UIVisualEffectView *effectView;
/**
 X图片
 */
@property(nonatomic,strong) UIImageView *cancleImage;
/**
 scrollView
 */
@property(nonatomic,strong) UIScrollView *scrollView;
/**
 page
 */
@property(nonatomic,strong) UIPageControl *pageControl;
/**
 按钮图片，必传
 */
@property(nonatomic,strong) NSArray *buttonImages;
/**
 按钮标题，必传，需与图片相同个数
 */
@property(nonatomic,strong) NSArray *buttonTitles;
/**
 所有按钮
 */
@property(nonatomic,strong) NSMutableArray *buttons;


@property(nonatomic,strong) UIView *bottomLine;

//时间
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UILabel *weekLabel;


@end


@implementation EffectMenuView


#pragma mark ------------------------init


- (instancetype)initWithMenuButtonImages:(NSArray *)buttonImages buttonTitles:(NSArray *)buttonTitles
{
    self = [super init];
    if (self) {
        
        NSAssert(buttonImages.count == buttonTitles.count,@"图片与标题个数不一致");
        
        self.frame = CGRectMake(0, 0, ViewWidth, ViewHeight);
        _buttonImages = buttonImages;
        _buttonTitles = buttonTitles;
        _buttons = @[].mutableCopy;
        _blurEffectStyle = UIBlurEffectStyleLight;
        
        [self addSubview:self.effectView];
        
        [self initBottomView];
        
        [self initMenuButtons];
        
        [self initTimeZone];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)]];

        
    }
    return self;
}

- (void)initBottomView
{
    [self.effectView addSubview:self.cancleImage];
    [self.effectView addSubview:self.bottomLine];
}


- (void)initMenuButtons
{
    //页数
    NSInteger maxPage = (NSInteger)ceil(self.buttonImages.count/(CGFloat)(CountForRow*2));
    self.scrollView.contentSize = CGSizeMake(maxPage*ViewWidth, 0);
    if (maxPage > 1) {
        [self.effectView addSubview:self.pageControl];
        self.pageControl.numberOfPages = maxPage;
    }
    
    for (int i = 0; i < self.buttonImages.count; i ++) {
        
        //x
        CGFloat x = ButtonWidth * (i%CountForRow) + ButtonWidth/2 * (i%CountForRow + 1) + (ViewWidth*(i/(CountForRow*2)));
        
        //y 默认在屏幕外
        CGFloat y = ViewHeight + ButtonHeight*((i%(CountForRow*2))/CountForRow);

        EffectMenuButton *menuBtn = [EffectMenuButton buttonWithType:UIButtonTypeCustom];
        [menuBtn setImage:[UIImage imageNamed:_buttonImages[i]] forState:UIControlStateNormal];
        [menuBtn setImage:[UIImage imageNamed:_buttonImages[i]] forState:UIControlStateHighlighted];
        [menuBtn setTitle:_buttonTitles[i] forState:UIControlStateNormal];
        menuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        menuBtn.frame = CGRectMake(x, y, ButtonWidth, ButtonHeight);
        menuBtn.tag = ButtonTag + i;
        [menuBtn addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
        [_buttons addObject:menuBtn];
        [self.scrollView addSubview:menuBtn];
    }
}


- (void)initTimeZone
{
    //时间
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.x = 30;
    _timeLabel.y = 120;
    _timeLabel.font = [UIFont systemFontOfSize:30];
    _timeLabel.textColor = [UIColor darkGrayColor];
    [self.effectView addSubview:_timeLabel];
    
    //星期几
    _weekLabel = [[UILabel alloc]init];
    _weekLabel.x = 30;
    _weekLabel.y = 80;
    _weekLabel.font = [UIFont systemFontOfSize:30];
    _weekLabel.textColor = [UIColor darkGrayColor];
    [self.effectView addSubview:_weekLabel];
    
}

- (void)loadTimeText
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyy/MM/dd HH:mm"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar components:NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth fromDate:date];
    NSDateFormatter *weekFormatter = [[NSDateFormatter alloc]init];
    [weekFormatter setDateFormat:@"EEEE"];
    
    _timeLabel.text = [formatter stringFromDate:date];
    [_timeLabel sizeToFit];
    _weekLabel.text = [weekFormatter stringFromDate:date];
    [_weekLabel sizeToFit];
}


#pragma mark ------------------------click

- (void)clickMenu:(EffectMenuButton *)sender
{
    NSInteger tag = sender.tag - ButtonTag;
    if (_delegate && [_delegate respondsToSelector:@selector(effectMenuView:didSelectMenuIndex:)]) {
        [_delegate effectMenuView:self didSelectMenuIndex:tag];
    }
    [self hide];
}

- (void)tap
{
    [self hide];
}

#pragma mark ------------------------UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat xOffset = scrollView.contentOffset.x;
    NSInteger page = (NSInteger)(xOffset/ViewWidth);
    self.pageControl.currentPage = page;
}

#pragma mark ------------------------method
//显示
- (void)show
{
    //加载时间文本
    [self loadTimeText];
    //背景
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:EffectBackAlphaTime animations:^{
        self.effectView.alpha = 1;
    }];
    
    //X图片
    [UIView animateWithDuration:EffectBackAlphaTime animations:^{
        self.cancleImage.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    //按钮动画
    [self addSubview:self.scrollView];
    
    for (int i = 0; i < self.buttons.count; i ++) {
        EffectMenuButton *btn = self.buttons[i];
        
        //y
        CGFloat y = (ButtonHeight)*((i%(CountForRow*2))/CountForRow) + ButtonScrollGap;
        (i %(CountForRow*2)) < CountForRow ? (y -= ButtonGap) : y;
        
        NSTimeInterval delay = ((i%(CountForRow*2))%CountForRow)*DelayTime;
        
        [UIView animateWithDuration:ShowAnimationTime-delay
                              delay:delay
             usingSpringWithDamping:0.65
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            btn.y = y;
        } completion:^(BOOL finished) {
            
        }];
    }    
}
//消失
- (void)hide
{
    [UIView animateWithDuration:EffectBackAlphaTime animations:^{
        self.effectView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [UIView animateWithDuration:EffectBackAlphaTime animations:^{
        self.cancleImage.transform = CGAffineTransformMakeRotation(-M_PI_4);
    } completion:^(BOOL finished) {
    }];
    
    for (int i = 0; i < self.buttons.count; i ++) {
        EffectMenuButton *btn = self.buttons[i];
        CGFloat y = ViewHeight + ButtonHeight*((i%(CountForRow*2))/CountForRow);
        
        NSTimeInterval delay = (CountForRow - (i%(CountForRow*2))%CountForRow)*DelayTime;

        [UIView animateWithDuration:ShowAnimationTime-delay
                              delay:delay
             usingSpringWithDamping:0.75
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            btn.y = y;
        } completion:^(BOOL finished) {
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            self.pageControl.currentPage = 0;
        }];
    }
}




#pragma mark ------------------------getter

- (UIVisualEffectView *)effectView
{
    if (!_effectView) {
        _effectView = ({
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:self.blurEffect];
            effectView.frame = CGRectMake(0, 0, ViewWidth, ViewHeight);
            effectView.alpha = 0;
            effectView;
        });
    }
    return _effectView;
}


- (UIBlurEffect *)blurEffect
{
    if (!_blurEffect) {
        _blurEffect = ({
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:_blurEffectStyle];
            effect;
        });
    }
    return _blurEffect;
}

- (UIImageView *)cancleImage
{
    if (!_cancleImage) {
        _cancleImage = [[UIImageView alloc]initWithFrame:CGRectMake((ViewWidth-15)/2, ViewHeight-30, 15, 15)];
        _cancleImage.image = [UIImage imageNamed:@"close"];
        _cancleImage.contentMode = UIViewContentModeScaleToFill;
        _cancleImage.transform = CGAffineTransformMakeRotation(-M_PI_4);
    }
    return _cancleImage;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight-45, ViewWidth, 0.5)];
        _bottomLine.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    }
    return _bottomLine;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, ViewHeight - BottomHeight - 2*ButtonHeight-ButtonScrollGap, ViewWidth, ButtonHeight*2+BottomHeight+ButtonScrollGap);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.center = CGPointMake(ViewWidth/2, ViewHeight-BottomHeight*0.75);
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}



@end
