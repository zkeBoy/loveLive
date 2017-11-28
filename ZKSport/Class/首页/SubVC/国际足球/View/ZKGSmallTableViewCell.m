//
//  ZKGSmallTableViewCell.m
//  ZKSport
//
//  Created by Tom on 2017/11/17.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKGSmallTableViewCell.h"

@implementation ZKGSmallTableViewCell

- (void)setModel:(ZKGFootBallModel *)model {
    _model = model;
    
    NSString * text = model.title;
    self.titleLabel.text = text;
    
    NSString * content = model.digest;
    self.contentLabel.text = content;
    
    NSString * imgSrc3 = model.imgsrc;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgSrc3] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setUI];
}

- (void)setUI {
    [self.contentView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.mainView addSubview:self.topline];
    [self.topline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.mainView);
        make.left.equalTo(self.mainView).offset(Margin);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.mainView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.mainView).offset(Margin);
        make.bottom.equalTo(self.mainView).offset(-Margin);
        make.width.mas_equalTo(80);
    }];
    
    [self.mainView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView);
        make.left.equalTo(self.imgView.mas_right).offset(Margin);
        make.right.equalTo(self.mainView).offset(-Margin);
        make.height.equalTo(self.titleLabel);
    }];
    
    [self.mainView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgView);
        make.left.equalTo(self.imgView.mas_right).offset(Margin);
        make.right.equalTo(self.mainView).offset(-Margin);
        make.height.equalTo(self.contentLabel);
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

- (UIView *)topline {
    if (!_topline) {
        _topline = [[UIView alloc] init];
        _topline.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    return _topline;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor whiteColor];
    }
    return _imgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.9];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:10];
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
