//
//  CardView.h
//  AnimationDemo
//
//  Created by tederen on 2017/7/11.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView

@property(nonatomic,copy)   NSString *cardText;

- (void)showCardText;

- (void)hideCardText;
@end
