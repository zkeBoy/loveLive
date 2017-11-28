//
//  ZKFunsTableViewCell.m
//  ZKSport
//
//  Created by Tom on 2017/11/18.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKFunsTableViewCell.h"

@implementation ZKFunsTableViewCell

- (void)setModel:(ZKFunsModel *)model {
    _model = model;
    
    NSString * name = model.name;
    self.userName.text = name;
    
    NSString * time = model.create_time;
    self.createTime.text = time;
    
    NSString * text = model.text;
    self.contentLabel.text = text;
    
    NSString * imgSrc = model.profile_image;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgSrc] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.imgView.layer.cornerRadius = 20;
        self.imgView.layer.masksToBounds = YES;
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.2];
    [self setUI];
}

- (void)setUI {
    [self.contentView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(Margin);
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-Margin);
    }];
    
    [self.mainView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.mainView).offset(Margin);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.mainView addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(Margin);
        make.top.equalTo(self.mainView).offset(Margin+4);
        make.width.height.equalTo(self.userName);
    }];
    
    [self.mainView addSubview:self.createTime];
    [self.createTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userName);
        make.bottom.equalTo(self.imgView.mas_bottom).offset(-4);
        make.width.height.equalTo(self.createTime);
    }];
    
    [self.mainView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainView).offset(Margin);
        make.right.equalTo(self.mainView).offset(-Margin);
        make.bottom.equalTo(self.mainView).offset(-Margin/2);
        make.top.equalTo(self.imgView.mas_bottom).offset(Margin);
    }];
}

#pragma mark - lazy init
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor clearColor];
    }
    return _imgView;
}

- (UILabel *)userName {
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.backgroundColor = [UIColor clearColor];
        _userName.textColor = [UIColor redColor];
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.font = [UIFont systemFontOfSize:12];
    }
    return _userName;
}

- (UILabel *)createTime {
    if (!_createTime) {
        _createTime = [[UILabel alloc] init];
        _createTime.backgroundColor = [UIColor clearColor];
        _createTime.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _createTime.textAlignment = NSTextAlignmentLeft;
        _createTime.font = [UIFont systemFontOfSize:12];
    }
    return _createTime;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _contentLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
