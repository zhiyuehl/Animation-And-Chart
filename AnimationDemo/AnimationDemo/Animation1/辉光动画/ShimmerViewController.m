//
//  ShimmerViewController.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/10.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "ShimmerViewController.h"
#import "FBShimmeringView.h"

@interface ShimmerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *shimmerLabel;


@end

@implementation ShimmerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBShimmeringView *shimmeringView           = [[FBShimmeringView alloc] initWithFrame:self.view.bounds];
    shimmeringView.shimmering                  = YES;
    shimmeringView.shimmeringBeginFadeDuration = 0.3;
    shimmeringView.shimmeringOpacity           = 0.1f;
    shimmeringView.shimmeringAnimationOpacity  = 1.f;
    [self.view addSubview:shimmeringView];
    
    shimmeringView.contentView = _shimmerLabel;

    
}



@end
