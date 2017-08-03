//
//  SectionScrollPageViewController.m
//  AnimationDemo
//
//  Created by tederen on 2017/8/2.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "SectionScrollPageViewController.h"
#import "HLSectionScrollPageView.h"


@interface SectionScrollPageViewController ()<HLSectionScrollPageViewDeletage>
@property(nonatomic,strong) HLSectionScrollPageView *sectionPageView;

@end

@implementation SectionScrollPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _sectionPageView = [[HLSectionScrollPageView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height-64) topTitles:@[@"语文",@"数学",@"英语",@"物理",@"化学",@"生物",@"历史",@"地理",@"政治",@"语文",@"数学",@"英语",@"物理",@"化学",@"生物",@"历史",@"地理",@"政治"] width:60 height:44];
    //    _sectionPageView.topTitleSelectType = SSTopTitleSelectTypeFrame;
    _sectionPageView.topTitleSelectType = SSTopTitleSelectTypeLine;
    _sectionPageView.bottomViews = @[[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init],[[UIView alloc]init]];
    _sectionPageView.delegate = self;
    _sectionPageView.lineWidth = 40;
    [self.view addSubview:_sectionPageView];
}

- (void)sectionScrollPageView:(HLSectionScrollPageView *)sectionScrollPageView didScrollToIndex:(NSInteger)index
{
    NSLog(@"滚到了---%ld",index);
}

@end
