//
//  AOneImageStretchViewController.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/7.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "AOneImageStretchViewController.h"
#import "CustomNavigationBar.h"



@interface AOneImageStretchViewController ()<UITableViewDelegate,UITableViewDataSource,CustomNavigationBarDelegate>

@property(nonatomic,strong) CustomNavigationBar *customNavigationBar;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIImageView *topImageView;

@property(nonatomic,assign) CGRect orginalFrame;


@end


const static CGFloat ImageRatio = 2000/1324.0;
const static CGFloat HeaderHeight = 180.f;

@implementation AOneImageStretchViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _orginalFrame = CGRectMake(0, 0, kScreen_Width, kScreen_Width*ImageRatio);;
    _topImageView = [[UIImageView alloc]initWithFrame:_orginalFrame];
    _topImageView.image = [UIImage imageNamed:@"girl.jpg"];
    [self.view addSubview:_topImageView];
        
    _customNavigationBar = [[CustomNavigationBar alloc]init];
    _customNavigationBar.title = @"图片拉伸放大";
    _customNavigationBar.titleColor = [UIColor whiteColor];
    _customNavigationBar.leftImage = @"back";
    _customNavigationBar.rightImage = @"set";
    _customNavigationBar.delegate = self;
    [self.view addSubview:_customNavigationBar];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height-64) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = [UIView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AOneImageStretchCell"];
    [self.view addSubview:_tableView];
    
    //顶部空隙
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, HeaderHeight)];
    headerView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = headerView;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    
    //处理上滑导航渐变
    if (yOffset < HeaderHeight) {
        _customNavigationBar.backgroundColor = [UIColor colorWithWhite:1 alpha:yOffset/HeaderHeight];
        _customNavigationBar.leftImage = @"back";
        _customNavigationBar.rightImage = @"set";
        _customNavigationBar.titleColor = [UIColor whiteColor];
    }else if (yOffset > HeaderHeight) {
        _customNavigationBar.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        _customNavigationBar.leftImage = @"back-black";
        _customNavigationBar.rightImage = @"set-black";
        _customNavigationBar.titleColor = [UIColor blackColor];
    }
    
    //处理图片拉伸
    if (yOffset >= 0) {
        _topImageView.frame = ({
            CGRect frame = _orginalFrame;
            frame.origin.y = -yOffset;
            frame;
        });
    }else {
        _topImageView.frame = ({
            CGRect frame = _orginalFrame;
            frame.size.width = frame.size.width - yOffset;
            frame.size.height = frame.size.width*ImageRatio;
            frame.origin.x = (_orginalFrame.size.width-frame.size.width)/2;
            frame;
        });
    }
}

#pragma mark ------------------------CustomNavigationBarDelegate

- (void)customNavigationBarClickRightButton
{
    
}

- (void)customNavigationBarClickLeftButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ------------------------<UITableViewDataSource,UITableViewDelegate>


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AOneImageStretchCell"];
    cell.textLabel.text = @"图片拉伸放大";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
