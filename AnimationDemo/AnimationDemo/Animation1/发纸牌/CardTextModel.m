//
//  CardTextModel.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/14.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "CardTextModel.h"

@implementation CardTextModel



+ (instancetype)cardTextModelWithText:(NSString *)text
{
    CardTextModel *model = [[CardTextModel alloc]init];
    if ([text hasPrefix:BlackPeach]) {
        model.cardType = BlackPeach;
        model.cardText = [text stringByReplacingOccurrencesOfString:BlackPeach withString:@""];
    }else if ([text hasPrefix:RedPeach]) {
        model.cardType = RedPeach;
        model.cardText = [text stringByReplacingOccurrencesOfString:RedPeach withString:@""];
    }else if ([text hasPrefix:PlumBlossom]) {
        model.cardType = PlumBlossom;
        model.cardText = [text stringByReplacingOccurrencesOfString:PlumBlossom withString:@""];
    }else if ([text hasPrefix:Square]) {
        model.cardType = Square;
        model.cardText = [text stringByReplacingOccurrencesOfString:Square withString:@""];
    }
    
    if ([model.cardText isEqualToString:One]) {
        model.cardNum = @14;
    }else if ([model.cardText isEqualToString:Eleven]) {
        model.cardNum = @11;
    }else if ([model.cardText isEqualToString:Twelve]) {
        model.cardNum = @12;
    }else if ([model.cardText isEqualToString:Thirteen]) {
        model.cardNum = @13;
    }else {
        model.cardNum = [NSNumber numberWithInteger:[model.cardText integerValue]];
    }
    
    return model;
}



@end
