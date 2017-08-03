//
//  CustomNavigationBar.h
//  AnimationDemo
//
//  Created by tederen on 2017/7/7.
//  Copyright © 2017年 tederen. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol CustomNavigationBarDelegate <NSObject>

@optional

- (void)customNavigationBarClickLeftButton;

- (void)customNavigationBarClickRightButton;


@end



@interface CustomNavigationBar : UIView


@property(nonatomic,copy)   NSString *title;
@property(nonatomic,copy)   NSString *leftImage;
@property(nonatomic,copy)   NSString *rightImage;
@property(nonatomic,strong) UIColor *titleColor;

@property(nonatomic,weak) id<CustomNavigationBarDelegate> delegate;


@end
