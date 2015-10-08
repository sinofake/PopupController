//
//  eLongPopupTableViewCell.m
//  PopupController
//
//  Created by zhucuirong on 15/9/16.
//  Copyright (c) 2015年 SINOFAKE SINEP. All rights reserved.
//

#import "SSPopupTableViewCell.h"
#import "SSPopupDefine.h"

@interface SSPopupTableViewCell ()
@property (nonatomic, strong) UIView *splitView;
@property (nonatomic, strong) UIImageView *checkImgView;

@end

@implementation SSPopupTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.backgroundColor	= [UIColor clearColor];
    nameLabel.font				= [UIFont systemFontOfSize:15.f];
    nameLabel.textColor = [UIColor colorWithRed:52/255.f green:52/255.f blue:52/255.f alpha:1];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UIImageView *checkImgView = [[UIImageView alloc] initWithImage:SS_BundleImageWithName(@"cell_choose_icon")];
    checkImgView.backgroundColor = [UIColor clearColor];
    checkImgView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:checkImgView];
    self.checkImgView = checkImgView;
    
    self.splitView = [UIView new];
    self.splitView.backgroundColor = [UIColor colorWithRed:200/255.f green:200/255.f blue:200/255.f alpha:1];
    [self.contentView addSubview:self.splitView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat itemHeight = CGRectGetHeight(self.contentView.frame) - SS_SCREEN_SCALE;
    self.nameLabel.frame = CGRectMake(20, 0, CGRectGetWidth(self.frame) - (20 + itemHeight), itemHeight);
    self.checkImgView.frame = CGRectMake(CGRectGetWidth(self.frame) - itemHeight, 0, itemHeight, itemHeight);
    self.splitView.frame = CGRectMake(0, itemHeight, CGRectGetWidth(self.frame), SS_SCREEN_SCALE);
}

- (void)setChecked:(BOOL)checked {
    if (_checked == checked) {
        return;
    }
    _checked = checked;
    if (checked) {
        self.checkImgView.image = SS_BundleImageWithName(@"cell_choose_icon_h");
    }
    else {
        self.checkImgView.image = SS_BundleImageWithName(@"cell_choose_icon");
    }
}


@end
