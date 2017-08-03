//
//  OffsetImageCell.h
//  Animations
//
//  Created by YouXianMing on 16/4/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OffsetImageCell : UITableViewCell

@property (nonatomic, strong) UIImageView *pictureView;


- (CGFloat)cellOffset;

- (void)cancelAnimation;

@end
