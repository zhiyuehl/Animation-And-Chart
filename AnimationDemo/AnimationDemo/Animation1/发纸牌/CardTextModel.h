//
//  CardTextModel.h
//  AnimationDemo
//
//  Created by tederen on 2017/7/14.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import <Foundation/Foundation.h>

//type
static NSString *const BlackPeach = @"♤";
static NSString *const RedPeach = @"♡";
static NSString *const PlumBlossom = @"♧";
static NSString *const Square = @"♢";

//text
static NSString *const One = @"A";   //14
static NSString *const Two = @"2";
static NSString *const Three = @"3";
static NSString *const Four = @"4";
static NSString *const Five = @"5";
static NSString *const Six = @"6";
static NSString *const Seven = @"7";
static NSString *const Eight = @"8";
static NSString *const Nine = @"9";
static NSString *const Ten = @"10";
static NSString *const Eleven = @"J";   //11
static NSString *const Twelve = @"Q";   //12
static NSString *const Thirteen = @"K";  //13


@interface CardTextModel : NSObject


+ (instancetype)cardTextModelWithText:(NSString *)text;

@property(nonatomic,copy)   NSString *cardType;   //花色

@property(nonatomic,copy)   NSString *cardText;   //字

@property(nonatomic,strong) NSNumber *cardNum;    //数字大小



@end
