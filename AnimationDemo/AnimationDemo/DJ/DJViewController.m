//
//  DJViewController.m
//  AnimationDemo
//
//  Created by tederen on 2017/8/3.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "DJViewController.h"
#import "HLSectionScrollPageView.h"
#import "DJRecommendView.h"
#import <Masonry.h>

@interface DJViewController ()<HLSectionScrollPageViewDeletage>

@property(nonatomic,strong) UISearchBar *searchBar;

@property(nonatomic,strong) HLSectionScrollPageView *sectionPageView;

@property(nonatomic,strong) DJRecommendView *recommendView;



@end

@implementation DJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.sectionPageView];
    
    _sectionPageView.bottomViews = @[self.recommendView,self.recommendView,self.recommendView,self.recommendView];
    
//    self.navigationItem.titleView = self.searchBar;
    
}



#pragma mark ------------------------HLSectionScrollPageViewDeletage

- (void)sectionScrollPageView:(HLSectionScrollPageView *)sectionScrollPageView didScrollToIndex:(NSInteger)index
{
    [self.view endEditing:YES];
}

#pragma mark ------------------------getter

- (HLSectionScrollPageView *)sectionPageView
{
    if (!_sectionPageView) {
        _sectionPageView = [[HLSectionScrollPageView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, 44) topTitles:@[@"推荐",@"分类",@"电台",@"主播"] width:kScreen_Width/4 height:44];
        _sectionPageView.lineWidth = kScreen_Width/6;
        _sectionPageView.delegate = self;
        _sectionPageView.topTitlesColor = [UIColor grayColor];
        _sectionPageView.topTitleSelectColor = [UIColor purpleColor];

    }
    return _sectionPageView;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
//        _searchBar.bounds = CGRectMake(0, 0, 0, 20);
        _searchBar.placeholder = @"搜索";
        _searchBar.layer.cornerRadius = 10;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.backgroundColor = [UIColor whiteColor];
    }
    return _searchBar;
}

- (DJRecommendView *)recommendView
{
    if (!_recommendView) {
        _recommendView = [[DJRecommendView alloc]init];
    }
    return _recommendView;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
