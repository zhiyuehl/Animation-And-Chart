//
//  AnimationOneListViewController.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/6.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "AnimationOneListViewController.h"
#import "AnimateTableViewCell.h"

@interface AnimationOneListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong) NSArray *dataArray;

@property(nonatomic,strong) NSArray *controllersArray;

@end

@implementation AnimationOneListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tableView.tableFooterView = [UIView new];
    
    _dataArray = @[@"顶部图片拉伸放大效果",
                   @"水波纹",
                   @"数字渐变",
                   @"辉光动画",
                   @"震动动画",
                   @"发纸牌",
                   @"毛玻璃效果",
                   @"集合视图",
                   @"开眼"];
    _controllersArray = @[@"AOneImageStretchViewController",
                          @"WaterWaveViewController",
                          @"DigitalGradientViewController",
                          @"ShimmerViewController",
                          @"ShakeViewController",
                          @"CardViewController",
                          @"BlurImageViewController",
                          @"LinerCollectionViewController",
                          @"OpenEyeViewController"];
    
    NSAssert(_dataArray.count == _controllersArray.count, @"dataArray与controllersArray不一致");

}




#pragma mark ------------------------<UITableViewDataSource,UITableViewDelegate>


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnimateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnimateTableViewCell"];
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.detailTextLabel.text = _controllersArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_controllersArray.count > indexPath.row) {
        [self performSegueWithIdentifier:_controllersArray[indexPath.row] sender:self];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


@end
