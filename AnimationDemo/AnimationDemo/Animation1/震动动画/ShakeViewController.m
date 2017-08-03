//
//  ShakeViewController.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/10.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "ShakeViewController.h"
#import "UIView+Shake.h"
#import "UIView+SetRect.h"

@interface ShakeViewController ()

@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label      = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.center        = self.view.center;
    label.bounds        = CGRectMake(0, 0, 200, 200);
    label.text          = @"😂";
    label.font          = [UIFont systemFontOfSize:100.f];
    label.textColor     = [UIColor blackColor];
    [self.view addSubview:label];
    
    static int i = 0;
    switch (i++ % 4) {
            
        case 0:
            [label shakeWithOptions:SCShakeOptionsDirectionRotate | SCShakeOptionsForceInterpolationExpDown | SCShakeOptionsAtEndRestart | SCShakeOptionsAutoreverse force:0.15 duration:1 iterationDuration:0.03 completionHandler:nil];
            break;
            
        case 1:
            [label shakeWithOptions:SCShakeOptionsDirectionHorizontal | SCShakeOptionsForceInterpolationNone | SCShakeOptionsAtEndContinue force:0.05 duration:1 iterationDuration:0.03 completionHandler:nil];
            break;
            
        case 2:
            [label shakeWithOptions:SCShakeOptionsDirectionHorizontalAndVertical | SCShakeOptionsForceInterpolationRandom | SCShakeOptionsAtEndContinue force:0.3 duration:1 iterationDuration:0.02 completionHandler:nil];
            break;
            
        case 3:
            [label shakeWithOptions:SCShakeOptionsDirectionRotate | SCShakeOptionsForceInterpolationExpDown | SCShakeOptionsAtEndRestart force:0.15 duration:0.75 iterationDuration:0.03 completionHandler:nil];
            break;
            
        default:
            break;
    }

}



@end
