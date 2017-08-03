//
//  CardCompare.h
//  AnimationDemo
//
//  Created by tederen on 2017/7/14.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardTextModel.h"
#import "ThreeCardModel.h"

@interface CardCompare : NSObject

//得出金花卡牌的类型
+ (NSArray<ThreeCardModel *> *)cardCompareWithArray:(NSArray<NSArray *> *)cardTextArray;


@end
