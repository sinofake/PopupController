//
//  eLongPopupController.h
//  PopupController
//
//  Created by zhucuirong on 15/9/16.
//  Copyright (c) 2015年 SINOFAKE SINEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SSPopupTitleView.h"
@class SSPopupController;

typedef NS_ENUM(NSInteger, SSPopupStyle) {
    SSPopupStylePicker,//只针对component为1的pickerView
    SSPopupStyleTable
};

typedef NS_ENUM(NSInteger, SSPopupActionType) {
    SSPopupActionTypeLeftButtonClick,
    SSPopupActionTypeRightButtonClick
};

@protocol SSPopupControllerDataSource <NSObject>

- (NSInteger)numberOfRowInSSPopupController:(SSPopupController *)popupController;
- (NSString *)SSPopupController:(SSPopupController *)popupController titleForRow:(NSInteger)row;

@end


@protocol SSPopupControllerDelegate <NSObject>

@optional
- (void)SSPopupController:(SSPopupController *)popupController actionWithType:(SSPopupActionType)type;
- (void)SSPopupController:(SSPopupController *)popupController didSelectRow:(NSInteger)row;

@end


@protocol SSPopupControllerPresentDelegate <NSObject>

@optional
- (void)popupControllerWillPresent:(SSPopupController *)controller;
- (void)popupControllerDidPresent:(SSPopupController *)controller;
- (void)popupControllerWillDismiss:(SSPopupController *)controller;
- (void)popupControllerDidDismiss:(SSPopupController *)controller;

@end


@interface SSPopupController : NSObject<SSPopupTitleViewDelegate>

+ (SSPopupTitleView *)commonPopupTitleView;

/**
 *  default height: POPUP_CONTENT_HEIGHT，不包含titleView的高度
 *
 *  @param style为HotelPopupStyleTable时，隐藏titleView的右侧按钮
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithStyle:(SSPopupStyle)style;
- (instancetype)initWithStyle:(SSPopupStyle)style contentHeight:(CGFloat)height;

/**
 *  自定义内容视图，上方是SSPopupTitleView
 *
 *  @param contentView 自定义的内容视图
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithContentView:(UIView *)contentView;

/**
 *  完全自定义
 *
 *  @param contents 从上到下的view数组，无须对view.origin赋值，但须对view.size赋值
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithContents:(NSArray *)contents;

- (void)setContents:(NSArray *)contents;//子类化时用以设置contents，样式同initWithContents:

@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly) SSPopupStyle style;
@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, readonly) UIPickerView *pickerView;
@property (nonatomic, readonly) SSPopupTitleView *titleView;

@property (nonatomic, weak) id<SSPopupControllerDataSource> dataSource;
@property (nonatomic, weak) id<SSPopupControllerDelegate> delegate;
@property (nonatomic, weak) id<SSPopupControllerPresentDelegate> presentDelegate;

@property (nonatomic, assign) NSInteger selectedRow;// returns selected row. -1 if nothing selected

- (void)presentPopupControllerAnimated:(BOOL)flag;
- (void)presentPopupControllerInView:(UIView *)holderView animated:(BOOL)flag;
- (void)dismissPopupControllerAnimated:(BOOL)flag;

@end
