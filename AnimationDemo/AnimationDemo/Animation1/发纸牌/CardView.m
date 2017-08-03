//
//  CardView.m
//  AnimationDemo
//
//  Created by tederen on 2017/7/11.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import "CardView.h"
#import "UIView+SetRect.h"
#import "CardTextModel.h"

@interface CardView ()

@property(nonatomic,strong) UILabel *cardTextLabel;

@end


@implementation CardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor redColor];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.5;
        
        self.cardTextLabel = [[UILabel alloc]init];
        self.cardTextLabel.font = [UIFont systemFontOfSize:26];
        self.cardTextLabel.x = 5;
        self.cardTextLabel.y = 5;
        self.cardTextLabel.hidden = YES;
        [self addSubview:self.cardTextLabel];
        
    }
    return self;
}


- (void)setCardText:(NSString *)cardText
{
    _cardText = cardText;
    if ([cardText hasPrefix:RedPeach] || [cardText hasPrefix:Square]) {
        self.cardTextLabel.textColor = [UIColor redColor];
    }else {
        self.cardTextLabel.textColor = [UIColor blackColor];
    }
    self.cardTextLabel.text = _cardText;
    [self.cardTextLabel sizeToFit];
}


- (void)showCardText
{
    self.cardTextLabel.hidden = NO;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)hideCardText
{
    self.cardTextLabel.hidden = YES;
    self.backgroundColor = [UIColor redColor];
}

@end
