//
//  eLongPopupTitleView.h
//  PopupController
//
//  Created by zhucuirong on 15/9/16.
//  Copyright (c) 2015年 SINOFAKE SINEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SSPopupTitleView;

typedef NS_ENUM(NSInteger, SSPopupTitleViewActionType) {
    SSPopupTitleViewActionTypeLeftButtonClick,
    SSPopupTitleViewActionTypeRightButtonClick
};

@protocol SSPopupTitleViewDelegate<NSObject>

- (void)SSPopupTitleView:(SSPopupTitleView *)titleView actionWithType:(SSPopupTitleViewActionType)type;

@end


@interface SSPopupTitleView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, weak) id<SSPopupTitleViewDelegate> delegate;

@end
