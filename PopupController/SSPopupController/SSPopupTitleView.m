//
//  eLongPopupTitleView.m
//  PopupController
//
//  Created by zhucuirong on 15/9/16.
//  Copyright (c) 2015年 SINOFAKE SINEP. All rights reserved.
//

#import "SSPopupTitleView.h"
#import "SSPopupDefine.h"
#import "UIButton+SSEdgeInsets.h"

@interface SSPopupTitleView ()
@property (nonatomic, strong) UIView *splitView;

@end

@implementation SSPopupTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    
    // title label
    UILabel *titleLabel = [UILabel new];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor colorWithRed:52/255.f green:52/255.f blue:52/255.f alpha:1]];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    // left button
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.backgroundColor = [UIColor clearColor];
    [leftBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor colorWithRed:210/255.f green:70/255.f blue:36/255.f alpha:1] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor colorWithRed:228/255.f green:144/255.f blue:124/255.f alpha:1] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    self.leftButton = leftBtn;
    
    // right button
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn.titleLabel setFont:leftBtn.titleLabel.font];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[leftBtn titleColorForState:UIControlStateNormal] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[leftBtn titleColorForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    self.rightButton = rightBtn;
    
    self.splitView = [UIView new];
    self.splitView.backgroundColor = [UIColor colorWithRed:200/255.f green:200/255.f blue:200/255.f alpha:1];
    [self addSubview:self.splitView];
}

- (void)leftButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(SSPopupTitleView:actionWithType:)]) {
        [self.delegate SSPopupTitleView:self actionWithType:SSPopupTitleViewActionTypeLeftButtonClick];
    }
}

- (void)rightButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(SSPopupTitleView:actionWithType:)]) {
        [self.delegate SSPopupTitleView:self actionWithType:SSPopupTitleViewActionTypeRightButtonClick];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftButton.frame = CGRectMake(0, 0, POPUP_TITLE_VIEW_BUTTON_WIDTH, CGRectGetHeight(self.frame));
    [self.leftButton setEdgeInsetsWithType:SSEdgeInsetsTypeTitle marginType:SSMarginTypeLeft margin:POPUP_TITLE_VIEW_BUTTON_PADDING];
    
    self.rightButton.frame = CGRectMake(CGRectGetWidth(self.frame) - POPUP_TITLE_VIEW_BUTTON_WIDTH, 0, POPUP_TITLE_VIEW_BUTTON_WIDTH, CGRectGetHeight(self.frame));
    [self.rightButton setEdgeInsetsWithType:SSEdgeInsetsTypeTitle marginType:SSMarginTypeRight margin:POPUP_TITLE_VIEW_BUTTON_PADDING];
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.leftButton.frame), 0, CGRectGetWidth(self.frame) - POPUP_TITLE_VIEW_BUTTON_WIDTH * 2.f, CGRectGetHeight(self.frame));
    self.splitView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - SS_SCREEN_SCALE, CGRectGetWidth(self.frame), SS_SCREEN_SCALE);
}

@end
