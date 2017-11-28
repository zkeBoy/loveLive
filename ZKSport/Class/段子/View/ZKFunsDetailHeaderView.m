
//
//  ZKFunsDetailHeaderView.m
//  ZKSport
//
//  Created by Tom on 2017/11/18.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKFunsDetailHeaderView.h"

@interface ZKFunsDetailHeaderView ()
@property (nonatomic, strong) UIView      * mainView;
@property (nonatomic, strong) UIImageView * headIconView;
@property (nonatomic, strong) UIImageView * sexImgView;
@property (nonatomic, strong) UILabel     * userNameLabel;
@property (nonatomic, strong) UILabel     * createTimeLabel;
@property (nonatomic, strong) UILabel     * contentLabel;

@end

@implementation ZKFunsDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setModel:(ZKFunsModel *)model {
    _model = model;
    
    NSString * name = model.name;
    self.userNameLabel.text = name;
    
    NSString * time = model.create_time;
    self.createTimeLabel.text = time;
    
    NSString * text = model.text;
    self.contentLabel.text = text;
    
    NSString * imgSrc = model.profile_image;
    [self.headIconView sd_setImageWithURL:[NSURL URLWithString:imgSrc] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.headIconView.layer.cornerRadius = 20;
        self.headIconView.layer.masksToBounds = YES;
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setUI];
}

- (void)setUI {
    [self addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.mainView addSubview:self.headIconView];
    [self.headIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(Margin);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.mainView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView).offset(Margin+2);
        make.left.equalTo(self.headIconView.mas_right).offset(Margin);
        make.width.height.equalTo(self.userNameLabel);
    }];
    
    [self.mainView addSubview:self.createTimeLabel];
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headIconView).offset(-2);
        make.left.equalTo(self.headIconView.mas_right).offset(Margin);
        make.width.height.equalTo(self.createTimeLabel);
    }];
    
    [self.mainView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainView).offset(Margin);
        make.right.equalTo(self.mainView).offset(-Margin);
        make.top.equalTo(self.headIconView.mas_bottom).offset(Margin/2);
        make.height.equalTo(self.contentLabel);
    }];
}

#pragma mark -
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

- (UIImageView *)headIconView {
    if (!_headIconView) {
        _headIconView = [[UIImageView alloc] init];
        _headIconView.backgroundColor = [UIColor clearColor];
    }
    return _headIconView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.backgroundColor = [UIColor clearColor];
        _userNameLabel.textColor = [UIColor redColor];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        _userNameLabel.font = [UIFont systemFontOfSize:12];
    }
    return _userNameLabel;
}

- (UILabel *)createTimeLabel {
    if (!_createTimeLabel) {
        _createTimeLabel = [[UILabel alloc] init];
        _createTimeLabel.backgroundColor = [UIColor clearColor];
        _createTimeLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
        _createTimeLabel.textAlignment = NSTextAlignmentLeft;
        _createTimeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _createTimeLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _contentLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
