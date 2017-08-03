//
//  WaterWaveViewController.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/7.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "WaterWaveViewController.h"
#import "WaveView.h"
#import "UIView+SetRect.h"
#import "DefaultNotificationCenter.h"

@interface WaterWaveViewController ()<DefaultNotificationCenterDelegate>

@property(nonatomic,strong) DefaultNotificationCenter *notificationCenter;

@property(nonatomic,strong) WaveView *oneWave;

@property(nonatomic,strong) WaveView *twoWave;

@property(nonatomic,strong) WaveView *threeWave;

@end

@implementation WaterWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.masksToBounds = YES;
    
    self.notificationCenter          = [DefaultNotificationCenter new];
    self.notificationCenter.delegate = self;
    [self.notificationCenter addNotificationName:UIApplicationDidBecomeActiveNotification];
    
//    {
//        _threeWave = [[WaveView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width*2, 300)];
//        _threeWave.phase = 0;
//        _threeWave.waveCrest = 10;
//        _threeWave.waveCount = 2;
//        _threeWave.type = kFillWave;
//        [self.view addSubview:_threeWave];
//        
//        _threeWave.fillStyle = ({
//            DrawingStyle *style = [[DrawingStyle alloc]init];
//            style.fillColor = [DrawingColor colorWithUIColor:[[UIColor brownColor] colorWithAlphaComponent:0.25]];
//            style;
//        });
//        
//        _threeWave.strokeStyle = ({
//            DrawingStyle *style = [[DrawingStyle alloc]init];
//            style.strokeColor = [DrawingColor colorWithUIColor:[[UIColor brownColor] colorWithAlphaComponent:0.15]];
//            style.lineWidth = 0.5;
//            style;
//        });
//    }
    
    {
        _twoWave = [[WaveView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width*2, 300)];
        _twoWave.phase = 4.f;
        _twoWave.waveCrest = 20;
        _twoWave.waveCount = 4;
        _twoWave.type = kFillWave;
        [self.view addSubview:_twoWave];
        
        _twoWave.fillStyle = ({
            DrawingStyle *style = [[DrawingStyle alloc]init];
            style.fillColor = [DrawingColor colorWithUIColor:[[UIColor brownColor] colorWithAlphaComponent:0.5]];
            style;
        });
        
        _twoWave.strokeStyle = ({
            DrawingStyle *style = [[DrawingStyle alloc]init];
            style.strokeColor = [DrawingColor colorWithUIColor:[[UIColor brownColor] colorWithAlphaComponent:0.25]];
            style.lineWidth = 0.5;
            style;
        });
    }
    
    {
        _oneWave = [[WaveView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width*2, 300)];
        _oneWave.phase = 0;
        _oneWave.waveCrest = 10;
        _oneWave.waveCount = 4;
        _oneWave.type = kFillWave;
        [self.view addSubview:_oneWave];
        
        _oneWave.fillStyle = ({
            DrawingStyle *style = [[DrawingStyle alloc]init];
            style.fillColor = [DrawingColor colorWithUIColor:[[UIColor brownColor] colorWithAlphaComponent:0.25]];
            style;
        });
        
        _oneWave.strokeStyle = ({
            DrawingStyle *style = [[DrawingStyle alloc]init];
            style.strokeColor = [DrawingColor colorWithUIColor:[[UIColor brownColor] colorWithAlphaComponent:0.5]];
            style.lineWidth = 0.5;
            style;
        });
    }
    
    
    [self readyToBegin];
    
}

- (void)readyToBegin
{
    
    [_oneWave.layer removeAllAnimations];
    [_twoWave.layer removeAllAnimations];
//    [_threeWave.layer removeAllAnimations];
    
    _oneWave.x = 0.f;
    _twoWave.x = 0.f;
//    _threeWave.x = 0.f;
    
    [UIView animateWithDuration:3.0
                          delay:0
                        options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         _oneWave.x = -kScreen_Width;
                     } completion:nil];
    
    [UIView animateWithDuration:4.0
                          delay:0
                        options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         _twoWave.x = -kScreen_Width;
                     } completion:nil];
    
//    [UIView animateWithDuration:6.0
//                          delay:0
//                        options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         _threeWave.x = -kScreen_Width;
//                     } completion:nil];
//
}


- (void)defaultNotificationCenter:(DefaultNotificationCenter *)notification name:(NSString *)name object:(id)object {
    
    if ([name isEqualToString:UIApplicationDidBecomeActiveNotification]) {
        
        [self readyToBegin];
    }
}


@end
