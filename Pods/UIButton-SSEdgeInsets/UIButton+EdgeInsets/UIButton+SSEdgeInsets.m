//
//  UIButton+SSEdgeInsets.m
//  ElongIpadClient
//
//  Created by zhucuirong on 15/3/9.
//  Copyright (c) 2015年 dragonyuan. All rights reserved.
//

#import "UIButton+SSEdgeInsets.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define SS_SINGLELINE_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define SS_SINGLELINE_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

@implementation UIButton (SSEdgeInsets)

- (void)setImageUpTitleDownWithSpacing:(CGFloat)spacing {
    // lower the text and push it left so it appears centered
    //  below the image
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    // raise the image and push it right so it appears centered
    //  above the text
    CGSize titleSize = SS_SINGLELINE_TEXTSIZE([self titleForState:UIControlStateNormal], self.titleLabel.font);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
}

- (void)setImageRightTitleLeftWithSpacing:(CGFloat)spacing {
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - (imageSize.width + spacing), 0, imageSize.width);
    
    CGSize titleSize = SS_SINGLELINE_TEXTSIZE([self titleForState:UIControlStateNormal], self.titleLabel.font);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width, 0, - (titleSize.width + spacing));
}

- (void)setDefaultImageTitleStyleWithSpacing:(CGFloat)spacing {
    CGFloat delta = spacing/2.f;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -delta, 0, delta);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, delta, 0, -delta);
}

- (void)setEdgeInsetsWithType:(SSEdgeInsetsType)edgeInsetsType marginType:(SSMarginType)marginType margin:(CGFloat)margin {
    CGSize itemSize = CGSizeZero;
    if (edgeInsetsType == SSEdgeInsetsTypeTitle) {
        itemSize = SS_SINGLELINE_TEXTSIZE([self titleForState:UIControlStateNormal], self.titleLabel.font);
    }
    else {
        itemSize = [self imageForState:UIControlStateNormal].size;
    }
    
    CGFloat horizontalDelta = (CGRectGetWidth(self.frame) - itemSize.width)/2.f - margin;
    CGFloat vertivalDelta = (CGRectGetHeight(self.frame) - itemSize.height)/2.f - margin;
    
    NSInteger horizontalSignFlag = 1;
    NSInteger verticalSignFlag = 1;
    
    switch (marginType) {
        case SSMarginTypeTop:
        {
            horizontalSignFlag = 0;
            verticalSignFlag = -1;
        }
            break;
        case SSMarginTypeBottom:
        {
            horizontalSignFlag = 0;
            verticalSignFlag = 1;
        }
            break;
        case SSMarginTypeLeft:
        {
            horizontalSignFlag = -1;
            verticalSignFlag = 0;
        }
            break;
        case SSMarginTypeRight:
        {
            horizontalSignFlag = 1;
            verticalSignFlag = 0;
        }
            break;
        case SSMarginTypeTopLeft:
        {
            horizontalSignFlag = -1;
            verticalSignFlag = -1;
        }
            break;
        case SSMarginTypeTopRight:
        {
            horizontalSignFlag = 1;
            verticalSignFlag = -1;
        }
            break;
        case SSMarginTypeBottomLeft:
        {
            horizontalSignFlag = -1;
            verticalSignFlag = 1;
        }
            break;
        
        case SSMarginTypeBottomRight:
        {
            horizontalSignFlag = 1;
            verticalSignFlag = 1;
        }
            break;
            
        default:
            break;
    }
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(vertivalDelta * verticalSignFlag, horizontalDelta * horizontalSignFlag, -vertivalDelta * verticalSignFlag, -horizontalDelta * horizontalSignFlag);
    if (edgeInsetsType == SSEdgeInsetsTypeTitle) {
        self.titleEdgeInsets = edgeInsets;
    }
    else {
        self.imageEdgeInsets = edgeInsets;
    }
}
@end
