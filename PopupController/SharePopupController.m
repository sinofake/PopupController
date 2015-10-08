//
//  SharePopupController.m
//  PopupController
//
//  Created by zhucuirong on 15/9/19.
//  Copyright © 2015年 SINOFAKE SINEP. All rights reserved.
//

#import "SharePopupController.h"
#import "SSPopupDefine.h"
#import "UIButton+SSEdgeInsets.h"

@interface SharePopupController ()
@property (nonatomic, strong) UIView *shareView;

@end

@implementation SharePopupController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SS_SCREEN_WIDTH, POPUP_CONTENT_HEIGHT)];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(10, 20, 20, 20);
    CGFloat itemGap = 20.f;
    CGFloat buttonWidth = (CGRectGetWidth(self.shareView.frame) - (edgeInsets.left + edgeInsets.right + itemGap * 2))/3.f;
    CGFloat buttonHeight = (CGRectGetHeight(self.shareView.frame) - (edgeInsets.top + edgeInsets.bottom + itemGap))/2.f;
    
    NSArray *imageNames = @[@"TencentWeixin", @"TencentWeixinFriend", @"SinaWeibo", @"SysMail", @"SysMessage"];
    NSArray *selectedImageNames = @[@"TencentWeixin_Selected", @"TencentWeixinFriend_Selected", @"SinaWeibo_Selected", @"SysMail_Selected", @"SysMessage_Selected"];
    NSArray *buttonNames = @[@"微信", @"微信朋友圈", @"微博", @"邮件", @"短信"];
    for (NSUInteger i = 0; i < imageNames.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(edgeInsets.left + i%3 * (buttonWidth + itemGap), edgeInsets.top + i/3 * (buttonHeight + itemGap), buttonWidth, buttonHeight);
        [button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectedImageNames[i]] forState:UIControlStateHighlighted];
        [button setTitle:buttonNames[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [button setImageUpTitleDownWithSpacing:10.f];
        [self.shareView addSubview:button];
    }
    
//    eLongPopupTitleView *titleView = [eLongPopupController commonPopupTitleView];
//    titleView.delegate = self;
//    [self setContents:@[titleView, self.shareView]];
    [self setContents:@[self.shareView]];
}

@end
