//
//  OffsetImageCell.m
//  Animations
//
//  Created by YouXianMing on 16/4/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "OffsetImageCell.h"
#import "UIView+SetRect.h"

@interface OffsetImageCell ()

@property (nonatomic, strong) UILabel     *infoLabel;

@end

@implementation OffsetImageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        [self buildSubview];
    }
    return self;
}




- (void)setupCell {
    
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor blackColor];
}

- (void)buildSubview {
    
    self.clipsToBounds           = YES;
    self.pictureView             = [[UIImageView alloc]initWithFrame:CGRectMake(0, -(Height / 1.7 - 250) / 2, Width, Height / 1.7)];
    self.pictureView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.pictureView];
    
}

- (void)cancelAnimation {
    
    [self.pictureView.layer removeAllAnimations];
}

- (CGFloat)cellOffset {
    
    CGRect  centerToWindow = [self convertRect:self.bounds toView:self.window];
    CGFloat centerY        = CGRectGetMidY(centerToWindow);
    CGPoint windowCenter   = self.superview.center;
    
    CGFloat cellOffsetY = centerY - windowCenter.y;
    
    CGFloat offsetDig =  cellOffsetY / self.superview.frame.size.height * 2;
    CGFloat offset    =  -offsetDig * (Height / 1.7 - 250) / 2;
    
    CGAffineTransform transY   = CGAffineTransformMakeTranslation(0, offset);
    self.pictureView.transform = transY;
    
    return offset;
}

@end
