//
//  ViewController.m
//  PopupController
//
//  Created by zhucuirong on 15/9/16.
//  Copyright (c) 2015年 SINOFAKE SINEP. All rights reserved.
//

#import "ViewController.h"
#import "eLongPopupController.h"
#import "eLongPopupDefine.h"
#import "SharePopupController.h"

@interface ViewController ()<eLongPopupControllerDataSource, eLongPopupControllerDelegate>
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, strong) eLongPopupController *tablePopupController;
@property (nonatomic, strong) eLongPopupController *pickerPopupController;
@property (nonatomic, strong) eLongPopupController *customPopupController1;
@property (nonatomic, strong) SharePopupController *customPopupController2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArray = @[@"忘了是怎么开始",
                       @"也许就是对你一种感觉",
                       @"忽然间发现自己",
                       @"已深深爱上你真的很简单",
                       @"爱的地暗天黑都已无所谓",
                       @"是是非非无法抉择",
                       @"没有后悔为爱日夜去跟随",
                       @"那个疯狂的人是我",
                       @"I love you",
                       @"无法不爱着你",
                       @"baby",
                       @"说你也爱我喔～"];
    self.selectedRow = 0;
}

- (IBAction)popupTableView:(id)sender {
    self.tablePopupController.selectedRow = self.selectedRow;
    [self.tablePopupController presentPopupControllerInView:self.view animated:YES];
}

- (IBAction)popupPickerView:(id)sender {
    self.pickerPopupController.selectedRow = self.selectedRow;
    [self.pickerPopupController presentPopupControllerAnimated:YES];
}

- (IBAction)popupCustomView:(id)sender {
    [self.customPopupController1 presentPopupControllerAnimated:YES];
}

- (IBAction)popupCustomView2:(id)sender {
    [self.customPopupController2 presentPopupControllerAnimated:YES];
}

#pragma mark - eLongPopupControllerDataSource
- (NSInteger)numberOfRowInELongPopupController:(eLongPopupController *)popupController {
    return self.dataArray.count;
}

- (NSString *)eLongPopupController:(eLongPopupController *)popupController titleForRow:(NSInteger)row {
    return self.dataArray[row];
}


#pragma mark - eLongPopupControllerDelegate
- (void)eLongPopupController:(eLongPopupController *)popupController actionWithType:(eLongPopupActionType)type {
    [popupController dismissPopupControllerAnimated:YES];
    if (type == eLongPopupActionTypeLeftButtonClick) {
        return;
    }
    if (popupController == _pickerPopupController) {
        self.selectedRow = popupController.selectedRow;
    }
}

- (void)eLongPopupController:(eLongPopupController *)popupController didSelectRow:(NSInteger)row {
    if (popupController == _tablePopupController) {
        self.selectedRow = row;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [popupController dismissPopupControllerAnimated:YES];
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (eLongPopupController *)tablePopupController {
    if (!_tablePopupController) {
        _tablePopupController = [[eLongPopupController alloc] initWithStyle:eLongPopupStyleTable contentHeight:400.f];
        _tablePopupController.title = @"Table Style";
        _tablePopupController.dataSource = self;
        _tablePopupController.delegate = self;
    }
    return _tablePopupController;
}

- (eLongPopupController *)pickerPopupController {
    if (!_pickerPopupController) {
        _pickerPopupController = [[eLongPopupController alloc] initWithStyle:eLongPopupStylePicker];
        _pickerPopupController.title = @"Picker Style";
        _pickerPopupController.dataSource = self;
        _pickerPopupController.delegate = self;
    }
    return _pickerPopupController;
}

- (eLongPopupController *)customPopupController1 {
    if (!_customPopupController1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SS_SCREEN_WIDTH, 216.f)];
        label.backgroundColor = [UIColor orangeColor];
        label.text = @"CustomPopupController1";
        label.textAlignment = NSTextAlignmentCenter;
        
        _customPopupController1 = [[eLongPopupController alloc] initWithContentView:label];
        _customPopupController1.title = @"Custom Popup1";
        _customPopupController1.delegate = self;
    }
    return _customPopupController1;
}

- (SharePopupController *)customPopupController2 {
    if (!_customPopupController2) {
        _customPopupController2 = [[SharePopupController alloc] init];
        //_customPopupController2.delegate = self;
    }
    return _customPopupController2;
}


@end