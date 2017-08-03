//
//  AllCardText.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/19.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "AllCardText.h"

@implementation AllCardText

+ (NSArray *)allCardText
{
    NSArray *cardColor = @[BlackPeach,RedPeach,PlumBlossom,Square];
    NSArray *cardNum = @[One,Two,Three,Four,Five,Six,Seven,Eight,Nine,Ten,Eleven,Twelve,Thirteen];
    
    NSMutableArray *cardNumbers = @[].mutableCopy;
    for (int i = 0; i < cardColor.count; i ++) {
        for (int j = 0; j < cardNum.count; j ++) {
            NSString *str = [NSString stringWithFormat:@"%@%@",cardColor[i],cardNum[j]];
            [cardNumbers addObject:str];
        }
    }
    return cardNumbers;
}


@end
