//
//  CardSizeModel.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/15.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "CardSizeModel.h"
#import "CardTextModel.h"

@implementation CardSizeModel



+ (CardSizeType)cardSizeWithTextArray:(NSArray<CardTextModel *> *)textArray
{
    
    NSAssert(textArray.count == 3, @"不是三张牌");
    
    CardTextModel *model1 = textArray[0];
    CardTextModel *model2 = textArray[1];
    CardTextModel *model3 = textArray[2];
    
    //三张一样
    if ([model1.cardText isEqualToString:model2.cardText] && [model1.cardText isEqualToString:model3.cardText]) {
        return CardSizeTypeThreeSame;
    }
    
    //颜色一致
    if ([model1.cardType isEqualToString:model2.cardType] && [model1.cardType isEqualToString:model3.cardType]) {
        
        if ([self accordingToTheOrderWithTexts:@[model1.cardNum,model2.cardNum,model3.cardNum]]) {
            //顺序一致，顺金
            return CardSizeTypeShunKing;
        }else {
            //顺序不一致，金花
            return CardSizeTypeKingFlower;
        }
    }
    
    if ([self accordingToTheOrderWithTexts:@[model1.cardNum,model2.cardNum,model3.cardNum]]) {
        //顺序一致，顺子
        return CardSizeTypeShun;
    }
    
    if (model1.cardNum == model2.cardNum || model1.cardNum == model3.cardNum || model2.cardNum == model3.cardNum) {
        //对子
        return CardSizeTypePairs;
    }
    //单张
    return CardSizeTypeSingle;
}




+ (BOOL)accordingToTheOrderWithTexts:(NSArray *)textArray
{
    NSMutableArray *arr = textArray.mutableCopy;
    [arr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
        
    NSInteger one = [arr[0] integerValue];
    NSInteger two = [arr[1] integerValue];
    NSInteger three = [arr[2] integerValue];
    
    if (one == 2 && two == 3 && three == 14) {   ///A23
        return YES;
    }
    
    if (one + 1 == two && two + 1 == three) {   //其他顺子
        return YES;
    }
    
    return NO;
}



@end
