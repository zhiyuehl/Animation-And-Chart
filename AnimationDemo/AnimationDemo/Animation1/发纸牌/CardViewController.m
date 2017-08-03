//
//  CardViewController.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/11.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "CardViewController.h"
#import "CardView.h"
#import "UIView+SetRect.h"
#import "Math.h"
#import "CardCompare.h"
#import "AllCardText.h"

static int CardCount = 52;
static CGFloat AngleRadio = 1.0f;
static CGFloat CardThick = 1.0f;   //纸牌厚度

static const CGFloat CardRadio = 0.65f;
static const CGFloat CardHeight = 100.f;

static const NSInteger HeapCardNum = 3;  //每份3张
static const NSInteger HeapNum   = 5;   //4份


@interface CardViewController ()

@property(nonatomic,strong) NSMutableArray *cardsArray;

@property(nonatomic,strong) UIBarButtonItem *rightBarItem;

@property(nonatomic,strong) NSMutableArray *cardNumbers;

@property(nonatomic,strong) NSMutableArray *cardSizeLabelArray;



@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //♤,♡,♧,♢
    NSArray *testArr = @[@[@"♤2",@"♤3",@"♤A"]
                         ,@[@"♧4",@"♢4",@"♤4"]
                         ,@[@"♧6",@"♡6",@"♤5"]];
    
    
    NSArray *cardSizeArray = [CardCompare cardCompareWithArray:testArr];
    
    [cardSizeArray enumerateObjectsUsingBlock:^(ThreeCardModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%ld----%@",obj.sortNum,obj.cardSizeText);
    }];
    
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~萌萌的分割线~~~~~~~~~~~~~~~~~~~~~~~~");

    _cardSizeLabelArray = @[].mutableCopy;
    
    _cardNumbers = [AllCardText allCardText].mutableCopy;
    
    NSMutableArray *arr = _cardNumbers.mutableCopy;
    _cardsArray = @[].mutableCopy;
    for (int i = 0; i < CardCount; i ++) {
        CardView *card = [[CardView alloc]init];
        card.center = CGPointMake(self.view.center.x-CardThick*CardCount/2+CardThick*i, self.view.center.y+100);
        card.bounds = CGRectMake(0, 0, CardHeight*CardRadio, CardHeight);
        [_cardsArray addObject:card];
        [self.view addSubview:card];
        
        NSInteger count = arr.count;
        int cardIndex = arc4random()%(count);
        card.cardText = arr[cardIndex];
        [arr removeObjectAtIndex:cardIndex];
    }
    
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    
}

- (IBAction)clickCard:(UIButton *)sender
{
    // 圆弧形散列
//    [self circleCardsWithButton:sender];
    
    //发牌看牌
    [self heapCardWithButton:sender];
    
}


- (void)heapCardWithButton:(UIButton *)sender
{
    sender.enabled = NO;
    sender.selected = !sender.selected;
    if (sender.selected) {
        if (HeapNum * HeapCardNum > CardCount) {
            return;
        }
        //发牌
        CGFloat heapY = 200;
        CGFloat heapWidth = CardHeight*CardRadio+CardThick*HeapCardNum;
        CGFloat gap = (kScreen_Width - (HeapNum * heapWidth)) / (HeapNum + 1);
        for (int i = 0; i < HeapNum; i ++) {
            CGFloat heapX = gap * (i+1) + heapWidth * i + heapWidth/2;
            for (int j = 0; j < HeapCardNum; j ++) {
                
                CardView *card = _cardsArray[(i*HeapCardNum + j)];
                
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
                animation.fromValue = [NSValue valueWithCGPoint:card.center];
                animation.toValue = [NSValue valueWithCGPoint:CGPointMake(heapX + CardThick*j, heapY)];
                animation.duration = 0.3;
                animation.removedOnCompletion = NO;
                animation.fillMode = kCAFillModeForwards;
                animation.beginTime = CACurrentMediaTime() + i*0.1*HeapCardNum + 0.5*i + j*0.1;
                [card.layer addAnimation:animation forKey:nil];
            }
            
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.1*HeapCardNum*HeapNum + 0.5*HeapNum) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.rightBarItem.enabled = YES;
            sender.enabled = YES;
        });
        [self showCardSizeLabel];
    }else {
        //收牌
        [self.cardSizeLabelArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self.cardSizeLabelArray removeAllObjects];
        
        for (int i = 0; i < HeapNum; i ++) {
            for (int j = 0; j < HeapCardNum; j ++) {
                CardView *card = _cardsArray[i*HeapCardNum + j];
                [card hideCardText];
                
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
                animation.toValue = [NSValue valueWithCGPoint:card.center];
                animation.duration = 0.3;
                animation.removedOnCompletion = NO;
                animation.fillMode = kCAFillModeForwards;
                animation.beginTime = CACurrentMediaTime() + j*0.1;
                [card.layer addAnimation:animation forKey:nil];
                
            }
        }
        
        //重置牌的数字
        NSMutableArray *arr = _cardNumbers.mutableCopy;
        for (int i = 0; i < CardCount; i ++) {
            CardView *card = _cardsArray[i];
            NSInteger count = arr.count;
            int cardIndex = arc4random()%(count);
            card.cardText = arr[cardIndex];
            [arr removeObjectAtIndex:cardIndex];
        }
        sender.enabled = YES;

    }
}

- (void)showCardSizeLabel
{
    CGFloat heapY = 200;
    CGFloat heapWidth = CardHeight*CardRadio+CardThick*HeapCardNum;
    CGFloat gap = (kScreen_Width - (HeapNum * heapWidth)) / (HeapNum + 1);
    for (int i = 0; i < HeapNum; i ++) {
        CGFloat heapX = gap * (i+1) + heapWidth * i + heapWidth/2;

        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(heapX-CardHeight*CardRadio/2, heapY+100, CardHeight*CardRadio, 50)];
        titleLable.font = [UIFont systemFontOfSize:16];
        titleLable.textColor = [UIColor redColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [self.cardSizeLabelArray addObject:titleLable];
        [self.view addSubview:titleLable];
    }
    
}


// 圆弧形散列
- (void)circleCardsWithButton:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {   //发牌
        for (int i = 0; i < CardCount; i ++) {
            CardView *card = _cardsArray[i];
            
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"anchorPoint"];
            animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 1.f)];
            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 2.0f)];
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            
            CGFloat angle = -M_PI*AngleRadio/2.0 + ((M_PI*AngleRadio)/(CardCount-1))*i;
            CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
            transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
            transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(angle, 0, 0, 1)];
            transformAnimation.removedOnCompletion = NO;
            transformAnimation.fillMode = kCAFillModeForwards;
            
            CAAnimationGroup *group = [CAAnimationGroup animation];
            group.animations = @[animation,transformAnimation];
            group.duration = 0.2;
            group.repeatCount = 1;
            group.removedOnCompletion = NO;
            group.fillMode = kCAFillModeForwards;
            group.beginTime = CACurrentMediaTime()+0.1*i;
            [card.layer addAnimation:group forKey:nil];
        }
    }else {  //收牌
        for (int i = 0; i < CardCount; i ++) {
            CardView *card = _cardsArray[CardCount-i-1];
            
            CGFloat fromAngle = -M_PI*AngleRadio/2.0 + ((M_PI*AngleRadio)/(CardCount-1))*(CardCount-i-1);
            CGFloat angle = -M_PI*AngleRadio/2.0;
            CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
            transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(fromAngle, 0, 0, 1)];
            transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(angle, 0, 0, 1)];
            transformAnimation.repeatCount = 1;
            transformAnimation.duration = 1.0;
            transformAnimation.removedOnCompletion = NO;
            transformAnimation.fillMode = kCAFillModeForwards;
            
            [card.layer addAnimation:transformAnimation forKey:nil];
            
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"anchorPoint"];
            animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 2.f)];
            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5f)];
            animation.removedOnCompletion = NO;
            animation.duration = 1.0;
            animation.fillMode = kCAFillModeForwards;
            animation.beginTime = CACurrentMediaTime()+1.0;
            [card.layer addAnimation:animation forKey:nil];
            
            CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform"];
            anima.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(angle, 0, 0, 1)];
            anima.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1)];
            anima.repeatCount = 1;
            anima.duration = 0.5;
            anima.removedOnCompletion = NO;
            anima.fillMode = kCAFillModeForwards;
            anima.beginTime = CACurrentMediaTime()+1.0;
            [card.layer addAnimation:anima forKey:nil];
            
        }
        
       
    }
    
}


- (void)clickRightItem
{
    //看牌
    CGFloat heapY = 200;
    CGFloat heapWidth = CardHeight*CardRadio+CardThick*HeapCardNum;
    CGFloat gap = (kScreen_Width - (HeapNum * heapWidth)) / (HeapNum + 1);
    NSMutableArray *arr1 = @[].mutableCopy;
    for (int i = 0; i < HeapNum; i ++) {
        NSMutableArray *arr2 = @[].mutableCopy;
        for (int j = 0; j < HeapCardNum; j ++) {
            CardView *card = _cardsArray[i*HeapCardNum + j];
            [card showCardText];
            [arr2 addObject:card.cardText];
            
            CGFloat x = gap * (i+1) + heapWidth * i + heapWidth/2;
            CGFloat y = heapY + (j - HeapCardNum/2)*40;
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
            animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(x + CardThick*j, heapY)];
            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
            animation.repeatCount = 1;
            animation.duration = 0.3;
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            [card.layer addAnimation:animation forKey:nil];
        }
        [arr1 addObject:arr2];
    }
    
    NSArray *cardSizeArray = [CardCompare cardCompareWithArray:arr1];
    
    [cardSizeArray enumerateObjectsUsingBlock:^(ThreeCardModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%ld----%@",obj.sortNum,obj.cardSizeText);
        UILabel *label = self.cardSizeLabelArray[idx];
        label.text = [NSString stringWithFormat:@"%ld---%@",obj.sortNum,obj.cardSizeText];
    }];

    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~萌萌的分割线~~~~~~~~~~~~~~~~~~~~~~~~");
    
    self.rightBarItem.enabled = NO;
}

- (UIBarButtonItem *)rightBarItem
{
    if (!_rightBarItem) {
        _rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"看牌" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
        _rightBarItem.enabled = NO;
    }
    return _rightBarItem;
}




@end
