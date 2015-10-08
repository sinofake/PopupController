//
//  eLongPopupController.m
//  PopupController
//
//  Created by zhucuirong on 15/9/16.
//  Copyright (c) 2015年 SINOFAKE SINEP. All rights reserved.
//

#import "SSPopupController.h"
#import "SSPopupDefine.h"
#import "SSPopupTableViewCell.h"
#import "CNPPopupController.h"

static NSString *CellIdentifier = @"CellID";

@interface SSPopupController ()<UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, CNPPopupControllerDelegate>
@property (nonatomic, assign) SSPopupStyle style;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) SSPopupTitleView *titleView;
@property (nonatomic, strong) CNPPopupController *popupController;


@end

@implementation SSPopupController

+ (SSPopupTitleView *)commonPopupTitleView {
    return [[SSPopupTitleView alloc] initWithFrame:CGRectMake(0, 0, SS_SCREEN_WIDTH, POPUP_TITLE_VIEW_HEIGHT)];
}

- (instancetype)initWithStyle:(SSPopupStyle)style {
    return [self initWithStyle:style contentHeight:POPUP_CONTENT_HEIGHT];
}

- (instancetype)initWithStyle:(SSPopupStyle)style contentHeight:(CGFloat)height {
    self = [super init];
    if (self) {
        self.style = style;
        self.contentHeight = height;
        [self setup];
    }
    return self;
}

- (void)setup {
    self.selectedRow = -1;
    
    SSPopupTitleView *titleView = [[SSPopupTitleView alloc] initWithFrame:CGRectMake(0, 0, SS_SCREEN_WIDTH, POPUP_TITLE_VIEW_HEIGHT)];
    titleView.delegate = self;
    self.titleView = titleView;
    
    UIView *contentView;
    CGRect contentFrame = CGRectMake(0, 0, SS_SCREEN_WIDTH, self.contentHeight);
    if (self.style == SSPopupStylePicker) {
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:contentFrame];
        pickerView.backgroundColor = [UIColor clearColor];
        pickerView.showsSelectionIndicator = YES;
        pickerView.dataSource = self;
        pickerView.delegate = self;
        contentView = pickerView;
        self.pickerView = pickerView;
    }
    else if (self.style == SSPopupStyleTable) {
        self.titleView.rightButton.hidden = YES;
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:contentFrame];
        tableView.backgroundColor = [UIColor clearColor];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        [tableView registerClass:[SSPopupTableViewCell class] forCellReuseIdentifier:CellIdentifier];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.dataSource = self;
        tableView.delegate = self;
        contentView = tableView;
        tableView.tableFooterView = [UIView new];
        self.tableView = tableView;
    }
    
    self.popupController = [[CNPPopupController alloc] initWithContents:@[self.titleView, contentView]];
    [self configurePopupTheme];
}

- (void)configurePopupTheme {
    CNPPopupTheme *theme = self.popupController.theme;
    theme.backgroundColor = [UIColor colorWithRed:248/255.f green:248/255.f blue:248/255.f alpha:1];
    theme.contentVerticalPadding = 0;
    theme.popupContentInsets = UIEdgeInsetsZero;
    theme.popupStyle = CNPPopupStyleActionSheet;
    self.popupController.delegate = self;
}

- (instancetype)initWithContentView:(UIView *)contentView {
    self = [super init];
    if (self) {
        self.titleView = [SSPopupController commonPopupTitleView];
        self.titleView.delegate = self;
        
        self.popupController = [[CNPPopupController alloc] initWithContents:@[self.titleView, contentView]];
        [self configurePopupTheme];
    }
    return self;
}

- (instancetype)initWithContents:(NSArray *)contents {
    self = [super init];
    if (self) {
        self.popupController = [[CNPPopupController alloc] initWithContents:contents];
        [self configurePopupTheme];
    }
    return self;
}

- (void)setContents:(NSArray *)contents {
    self.popupController = [[CNPPopupController alloc] initWithContents:contents];
    [self configurePopupTheme];
}

#pragma mark - Presentation & Dismiss
- (void)presentPopupControllerAnimated:(BOOL)flag {
    [self.popupController presentPopupControllerAnimated:flag];
}

- (void)presentPopupControllerInView:(UIView *)holderView animated:(BOOL)flag {
    [self.popupController presentPopupControllerInView:holderView animated:flag];
}

- (void)dismissPopupControllerAnimated:(BOOL)flag {
    [self.popupController dismissPopupControllerAnimated:flag];
}

#pragma mark - CNPPopupControllerDelegate
- (void)popupControllerWillPresent:(CNPPopupController *)controller {
    if ([self.presentDelegate respondsToSelector:@selector(popupControllerWillPresent:)]) {
        [self.presentDelegate popupControllerWillPresent:self];
        return;
    }
    
    if (self.style == SSPopupStylePicker) {
        [self.pickerView reloadAllComponents];
        [self.pickerView selectRow:_selectedRow inComponent:0 animated:NO];
    }
    else {
        [self.tableView reloadData];
        if (self.selectedRow >= 0 && self.selectedRow < [self.dataSource numberOfRowInSSPopupController:self]) {
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedRow inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)popupControllerDidPresent:(CNPPopupController *)controller {
    if ([self.presentDelegate respondsToSelector:@selector(popupControllerDidPresent:)]) {
        [self.presentDelegate popupControllerDidPresent:self];
    }
}

- (void)popupControllerWillDismiss:(CNPPopupController *)controller {
    if ([self.presentDelegate respondsToSelector:@selector(popupControllerWillDismiss:)]) {
        [self.presentDelegate popupControllerWillDismiss:self];
    }
}

- (void)popupControllerDidDismiss:(CNPPopupController *)controller {
    if ([self.presentDelegate respondsToSelector:@selector(popupControllerDidDismiss:)]) {
        [self.presentDelegate popupControllerDidDismiss:self];
    }
}

#pragma mark - eLongPopupTitleViewDelegate
- (void)SSPopupTitleView:(SSPopupTitleView *)titleView actionWithType:(SSPopupTitleViewActionType)type {
    if ([self.delegate respondsToSelector:@selector(SSPopupController:actionWithType:)]) {
        if (type == SSPopupTitleViewActionTypeLeftButtonClick) {
            [self.delegate SSPopupController:self actionWithType:SSPopupActionTypeLeftButtonClick];
        }
        else {
            [self.delegate SSPopupController:self actionWithType:SSPopupActionTypeRightButtonClick];
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfRowInSSPopupController:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSPopupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = [self.dataSource SSPopupController:self titleForRow:indexPath.row];
    if (indexPath.row == self.selectedRow) {
        cell.checked = YES;
    }
    else {
        cell.checked = NO;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedRow = indexPath.row;
    [tableView reloadData];
    if ([self.delegate respondsToSelector:@selector(SSPopupController:didSelectRow:)]) {
        [self.delegate SSPopupController:self didSelectRow:indexPath.row];
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataSource numberOfRowInSSPopupController:self];
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 36.f;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *string = [self.dataSource SSPopupController:self titleForRow:row];
    return [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f], NSForegroundColorAttributeName: [UIColor colorWithRed:52/255.f green:52/255.f blue:52/255.f alpha:1]}];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([self.delegate respondsToSelector:@selector(SSPopupController:didSelectRow:)]) {
        [self.delegate SSPopupController:self didSelectRow:row];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - custom accessor
- (NSInteger)selectedRow {
    if (self.style == SSPopupStylePicker) {
        return _selectedRow = [self.pickerView selectedRowInComponent:0];
    }
    else {
        return _selectedRow;
    }
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = [title copy];
        self.titleView.titleLabel.text = title;
    }
}

@end
