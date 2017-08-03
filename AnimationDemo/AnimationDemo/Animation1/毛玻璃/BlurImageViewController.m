//
//  BlurImageViewController.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/12.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "BlurImageViewController.h"
#import "EffectMenuView.h"
#import "UIImage+ImageEffects.h"

@interface BlurImageViewController ()<EffectMenuViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *girlImage;

@property(nonatomic,strong) EffectMenuView *effectMenuView;

@end


@implementation BlurImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *img = [[UIImage imageNamed:@"girl.jpg"] blurImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            _girlImage.image = img;
        });
    });
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickAdd)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}

- (void)clickAdd
{
    [self.effectMenuView show];
}


#pragma mark ------------------------EffectMenuViewDelegate

- (void)effectMenuView:(EffectMenuView *)effectMenuView didSelectMenuIndex:(NSInteger)index
{
    NSLog(@"__%s__%d__点击了第%ld个",__FUNCTION__,__LINE__,index);
}


#pragma mark ------------------------getter



- (EffectMenuView *)effectMenuView
{
    if (!_effectMenuView) {
        _effectMenuView = [[EffectMenuView alloc]initWithMenuButtonImages:@[@"冰山",@"钓鱼",@"飞鸟",@"海底",@"火车",@"猎鹿",@"龙卷风",@"鹿鹿",@"旅馆",@"农场",@"鲨鱼",@"树木",@"悉尼歌剧院",@"洗澡",@"夜晚"] buttonTitles:@[@"冰山",@"钓鱼",@"飞鸟",@"海底",@"火车",@"猎鹿",@"龙卷风",@"鹿鹿",@"旅馆",@"农场",@"鲨鱼",@"树木",@"悉尼歌剧院",@"洗澡",@"夜晚"]];
        _effectMenuView.delegate = self;
    }
    return _effectMenuView;
}


@end
