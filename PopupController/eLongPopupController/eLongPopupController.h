//
//  eLongPopupController.h
//  PopupController
//
//  Created by zhucuirong on 15/9/16.
//  Copyright (c) 2015年 SINOFAKE SINEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "eLongPopupTitleView.h"
@class eLongPopupController;

typedef NS_ENUM(NSInteger, eLongPopupStyle) {
    eLongPopupStylePicker,//只针对component为1的pickerView
    eLongPopupStyleTable
};

typedef NS_ENUM(NSInteger, eLongPopupActionType) {
    eLongPopupActionTypeLeftButtonClick,
    eLongPopupActionTypeRightButtonClick
};

@protocol eLongPopupControllerDataSource <NSObject>

- (NSInteger)numberOfRowInELongPopupController:(eLongPopupController *)popupController;
- (NSString *)eLongPopupController:(eLongPopupController *)popupController titleForRow:(NSInteger)row;

@end


@protocol eLongPopupControllerDelegate <NSObject>

@optional
- (void)eLongPopupController:(eLongPopupController *)popupController actionWithType:(eLongPopupActionType)type;
- (void)eLongPopupController:(eLongPopupController *)popupController didSelectRow:(NSInteger)row;

@end


@protocol eLongPopupControllerPresentDelegate <NSObject>

@optional
- (void)popupControllerWillPresent:(eLongPopupController *)controller;
- (void)popupControllerDidPresent:(eLongPopupController *)controller;
- (void)popupControllerWillDismiss:(eLongPopupController *)controller;
- (void)popupControllerDidDismiss:(eLongPopupController *)controller;

@end


@interface eLongPopupController : NSObject<eLongPopupTitleViewDelegate>

+ (eLongPopupTitleView *)commonPopupTitleView;

/**
 *  default height: POPUP_CONTENT_HEIGHT，不包含titleView的高度
 *
 *  @param style为HotelPopupStyleTable时，隐藏titleView的右侧按钮
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithStyle:(eLongPopupStyle)style;
- (instancetype)initWithStyle:(eLongPopupStyle)style contentHeight:(CGFloat)height;

/**
 *  自定义内容视图，上方是eLongPopupTitleView
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
@property (nonatomic, readonly) eLongPopupStyle style;
@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, readonly) UIPickerView *pickerView;
@property (nonatomic, readonly) eLongPopupTitleView *titleView;

@property (nonatomic, weak) id<eLongPopupControllerDataSource> dataSource;
@property (nonatomic, weak) id<eLongPopupControllerDelegate> delegate;
@property (nonatomic, weak) id<eLongPopupControllerPresentDelegate> presentDelegate;

@property (nonatomic, assign) NSInteger selectedRow;// returns selected row. default 0.

- (void)presentPopupControllerAnimated:(BOOL)flag;
- (void)presentPopupControllerInView:(UIView *)holderView animated:(BOOL)flag;
- (void)dismissPopupControllerAnimated:(BOOL)flag;

@end
