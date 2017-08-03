//
//  DigitalGradientViewController.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/7.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "DigitalGradientViewController.h"
#import "UIView+SetRect.h"
#import "POPNumberAnimation.h"

@interface DigitalGradientViewController ()<POPNumberAnimationDelegate>

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property(nonatomic,strong) POPNumberAnimation *numberAnimation;

@property(nonatomic,strong) NSTimer *timer;

@end

@implementation DigitalGradientViewController


- (void)dealloc
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        NSLog(@"_timer dealloc");
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.numberAnimation = [[POPNumberAnimation alloc]init];
    self.numberAnimation.delegate = self;
    
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf configNumberAnimation];
        [weakSelf.numberAnimation startAnimation];
    }];
    [_timer fire];
    
    
}

- (void)configNumberAnimation
{
    self.numberAnimation.fromValue      = self.numberAnimation.currentValue;
    self.numberAnimation.toValue        = self.numberAnimation.currentValue + 50;
    self.numberAnimation.duration       = 2.f;
    self.numberAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.69 :0.11 :0.32 :0.88];
    [self.numberAnimation saveValues];
}




#pragma mark ------------------------POPNumberAnimationDelegate

- (void)POPNumberAnimation:(POPNumberAnimation *)numberAnimation currentValue:(CGFloat)currentValue {
    
    NSString *numberString = [NSString stringWithFormat:@"%.1f", currentValue];
    
    self.numberLabel.text = numberString;

}



@end
