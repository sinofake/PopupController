//
//  eLongPopupTitleView.h
//  PopupController
//
//  Created by zhucuirong on 15/9/16.
//  Copyright (c) 2015年 SINOFAKE SINEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class eLongPopupTitleView;

typedef NS_ENUM(NSInteger, eLongPopupTitleViewActionType) {
    eLongPopupTitleViewActionTypeLeftButtonClick,
    eLongPopupTitleViewActionTypeRightButtonClick
};

@protocol eLongPopupTitleViewDelegate<NSObject>

- (void)eLongPopupTitleView:(eLongPopupTitleView *)titleView actionWithType:(eLongPopupTitleViewActionType)type;

@end


@interface eLongPopupTitleView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, weak) id<eLongPopupTitleViewDelegate> delegate;

@end
