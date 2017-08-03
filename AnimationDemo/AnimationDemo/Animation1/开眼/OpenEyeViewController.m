//
//  OpenEyeViewController.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/14.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "OpenEyeViewController.h"
#import "OffsetImageCell.h"

@interface OpenEyeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *imageArray;


@end

@implementation OpenEyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArray = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", @"6.jpg", @"7.jpg"];
    
    
    self.tableView                     = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate            = self;
    self.tableView.dataSource          = self;
    self.tableView.rowHeight           = 250;
    self.tableView.sectionHeaderHeight = 25.f;
    self.tableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[OffsetImageCell class] forCellReuseIdentifier:@"OffsetImageCell"];
    [self.view addSubview:self.tableView];
    
}

#pragma mark ------------------------<UITableViewDataSource,UITableViewDelegate>


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OffsetImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OffsetImageCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(OffsetImageCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [cell cellOffset];

    cell.pictureView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];

}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(OffsetImageCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    [cell cancelAnimation];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"open eye";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UIScrollView's delegate.

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSArray <OffsetImageCell *> *array = [self.tableView visibleCells];
    
    [array enumerateObjectsUsingBlock:^(OffsetImageCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj cellOffset];
    }];
}






@end
