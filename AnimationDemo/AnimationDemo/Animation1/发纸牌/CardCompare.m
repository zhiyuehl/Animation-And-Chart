//
//  CardCompare.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/14.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "CardCompare.h"
#import "CardSizeModel.h"


typedef NS_ENUM(NSUInteger, CardSizeCompareType) {
    CardSizeCompareTypeBig,
    CardSizeCompareTypeSame,
    CardSizeCompareTypeSmall,
};


@implementation CardCompare


+ (NSArray<ThreeCardModel *> *)cardCompareWithArray:(NSArray<NSArray *> *)cardTextArray
{
    //转成模型
    NSMutableArray *arr1 = @[].mutableCopy;
    for (int i = 0; i <cardTextArray.count; i ++) {
        NSAssert([cardTextArray[i] isKindOfClass:[NSArray class]], @"cardText不是数组");
        NSArray *cardNums = cardTextArray[i];
        NSMutableArray *arr2 = @[].mutableCopy;
        for (int j = 0; j < cardNums.count; j ++) {
            NSAssert([cardNums[j] isKindOfClass:[NSString class]], @"cardText不是字符串");
            NSString *text = cardNums[j];
            CardTextModel *model = [CardTextModel cardTextModelWithText:text];
            [arr2 addObject:model];
        }
        //从大到小排列
        [arr2 sortUsingComparator:^NSComparisonResult(CardTextModel * _Nonnull obj1, CardTextModel * _Nonnull obj2) {
            return [obj2.cardNum compare:obj1.cardNum];
        }];
        [arr1 addObject:arr2];
    }
    
    // 比较是哪一类型牌
    NSMutableArray *sizeTypeArray = @[].mutableCopy;
    NSMutableArray *threeCardModelArray = @[].mutableCopy;
    [arr1 enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CardSizeType sizeType = [CardSizeModel cardSizeWithTextArray:obj];
        
        [sizeTypeArray addObject:@(sizeType)];
        
        
        ThreeCardModel *threeCardModel = [[ThreeCardModel alloc]init];

        switch (sizeType) {
            case CardSizeTypeThreeSame:
                threeCardModel.cardSizeText = CardSizeThreeSameText;
                
                break;
            case CardSizeTypeShunKing:
                threeCardModel.cardSizeText = CardSizeShunKingText;

                break;
            case CardSizeTypeKingFlower:
                threeCardModel.cardSizeText = CardSizeKingFlowerText;

                break;
            case CardSizeTypeShun:
                threeCardModel.cardSizeText = CardSizeShunText;

                break;
            case CardSizeTypePairs:
                threeCardModel.cardSizeText = CardSizePairsText;

                break;
            case CardSizeTypeSingle:
                threeCardModel.cardSizeText = CardSizeSingleText;

                break;

                
            default:
                break;
        }
        NSInteger sortNum = 1;
        for (int i = 0; i < arr1.count; i ++) {
            if ([self compareOneCard:arr1[i] twoCard:obj] == CardSizeCompareTypeBig) {
                sortNum ++;
            }
        }
        threeCardModel.sortNum = sortNum;
        
        [threeCardModelArray addObject:threeCardModel];
        
    }];
    
    return threeCardModelArray;
    
}


//从小到大排列
+ (CardSizeCompareType)compareOneCard:(NSArray *)cardOne twoCard:(NSArray *)cardTwo
{
    CardSizeType oneType = [CardSizeModel cardSizeWithTextArray:cardOne];
    CardSizeType twoType = [CardSizeModel cardSizeWithTextArray:cardTwo];
    
    if (oneType < twoType) {
        return CardSizeCompareTypeBig;
    }else if (oneType == twoType) {
        
        switch (oneType) {
            case CardSizeTypeThreeSame:
            {
                return [self compareThreeSameCardOne:cardOne cardTwo:cardTwo];
            }
                break;
            case CardSizeTypeShunKing:
            {
                return [self compareThreeNotSameCardOne:cardOne cardTwo:cardTwo];
            }
                break;
            case CardSizeTypeKingFlower:
            {
                return [self compareThreeNotSameCardOne:cardOne cardTwo:cardTwo];
            }
                break;
            case CardSizeTypeShun:
            {
                return [self compareThreeNotSameCardOne:cardOne cardTwo:cardTwo];
            }
                break;
            case CardSizeTypePairs:
            {
                return [self comparePairsCardOne:cardOne cardTwo:cardTwo];
            }
                break;
            case CardSizeTypeSingle:
            {
                return [self compareThreeNotSameCardOne:cardOne cardTwo:cardTwo];
            }
                break;
                
            default:
                break;
        }
        
    }else {
        return CardSizeCompareTypeSmall;
    }
    
    
    return YES;
}

//比较滚筒的大小
+ (CardSizeCompareType)compareThreeSameCardOne:(NSArray *)cardOne cardTwo:(NSArray *)cardTwo
{
    CardTextModel *one = cardOne[0];
    CardTextModel *two = cardTwo[0];
    if (one.cardNum > two.cardNum) {
        return CardSizeCompareTypeBig;
    }else if(one.cardNum == two.cardNum) {
        return CardSizeCompareTypeSame;
    }else {
        return CardSizeCompareTypeSmall;
    }
}



//比较三张不同卡的牌大小
+ (CardSizeCompareType)compareThreeNotSameCardOne:(NSArray *)cardOne cardTwo:(NSArray *)cardTwo
{
    CardTextModel *one = cardOne[0];
    CardTextModel *two = cardTwo[0];
    if (one.cardNum > two.cardNum) {
        return CardSizeCompareTypeBig;
    }else if(one.cardNum == two.cardNum) {
        
        CardTextModel *one2 = cardOne[1];
        CardTextModel *two2 = cardTwo[1];
        if (one2.cardNum > two2.cardNum) {
            return CardSizeCompareTypeBig;
        }else if(one2.cardNum == two2.cardNum) {
            
            CardTextModel *one3 = cardOne[2];
            CardTextModel *two3 = cardTwo[2];
            if (one3.cardNum > two3.cardNum) {
                return CardSizeCompareTypeBig;
            }else if(one3.cardNum == two3.cardNum) {
                return CardSizeCompareTypeSame;
            }else {
                return CardSizeCompareTypeSmall;
            }
        }else {
            return CardSizeCompareTypeSmall;
        }
        
    }else {
        return CardSizeCompareTypeSmall;
    }
}

//比较对子的大小
+ (CardSizeCompareType)comparePairsCardOne:(NSArray *)cardOne cardTwo:(NSArray *)cardTwo
{
    CardTextModel *one2 = cardOne[1];
    CardTextModel *two2 = cardTwo[1];
    
    if (one2.cardNum > two2.cardNum) {
        return CardSizeCompareTypeBig;
    }else if (one2.cardNum == two2.cardNum) {
        
        CardTextModel *one = cardOne[0];
        CardTextModel *one3 = cardOne[2];
        
        NSNumber *oneSingle;
        if (one.cardNum == one2.cardNum) {
            oneSingle = one3.cardNum;
        }else {
            oneSingle = one.cardNum;
        }
        
        CardTextModel *two = cardTwo[0];
        CardTextModel *two3 = cardTwo[2];

        NSNumber *twoSingle;
        if (two.cardNum == two2.cardNum) {
            twoSingle = two3.cardNum;
        }else {
            twoSingle = two.cardNum;
        }
        
        if (oneSingle > twoSingle) {
            return CardSizeCompareTypeBig;
        }else if (oneSingle == twoSingle) {
            return CardSizeCompareTypeSame;
        }else {
            return CardSizeCompareTypeSmall;
        }
        
    }else {
        return CardSizeCompareTypeSmall;
    }
    
}







@end
