//
//  CardSizeModel.h
//  AnimationDemo
//
//  Created by tederen on 2017/7/15.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CardTextModel;

typedef NS_ENUM(NSUInteger, CardSizeType) {
    CardSizeTypeThreeSame,    //滚筒，三张一样
    CardSizeTypeShunKing,     //顺金，三张顺序且花色一致
    CardSizeTypeKingFlower,   //金花,颜色一致，顺序不一致
    CardSizeTypeShun,         //顺子，顺序一致，颜色不一致
    CardSizeTypePairs,        //对子
    CardSizeTypeSingle,       //单张
};



#define CardSizeThreeSameText    @"滚筒"
#define CardSizeShunKingText     @"顺金"
#define CardSizeKingFlowerText   @"金花"
#define CardSizeShunText         @"顺子"
#define CardSizePairsText        @"对子"
#define CardSizeSingleText       @"单张"



@interface CardSizeModel : NSObject


+ (CardSizeType)cardSizeWithTextArray:(NSArray<CardTextModel *> *)textArray;

+ (BOOL)accordingToTheOrderWithTexts:(NSArray *)textArray;

@end
