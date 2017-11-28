//
//  ZKContentTableViewCell.m
//  ZKSport
//
//  Created by Tom on 2017/11/16.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKContentTableViewCell.h"

@implementation ZKContentTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setUI];
}

- (void)setModel:(ZKNBAModel *)model {
    _model = model;
    
    NSString * imgSrc = model.imgsrc;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgSrc] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    NSString * title = model.ltitle?model.ltitle:model.title;
    self.titleLabel.text = title;
    
    NSString * content = model.digest;
    self.contentLabel.text = content;
}

- (void)setUI {
    [self.contentView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.mainView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.mainView).offset(Margin);
        make.bottom.equalTo(self.mainView).offset(-Margin);
        make.width.mas_equalTo(110);
    }];
    
    [self.mainView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView).offset(Margin);
        make.left.equalTo(self.imgView.mas_right).offset(Margin);
        make.right.equalTo(self.mainView).offset(-Margin);
        make.height.equalTo(self.titleLabel);
    }];
    
    [self.mainView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Margin);
        make.bottom.equalTo(self.mainView).offset(-Margin);
        make.left.equalTo(self.imgView.mas_right).offset(Margin);
        make.right.equalTo(self.mainView).offset(-Margin);
    }];
    
    [self.mainView addSubview:self.topline];
    [self.topline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView);
        make.left.equalTo(self.mainView).offset(Margin);
        make.right.equalTo(self.mainView);
        make.height.mas_equalTo(0.5);
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _contentLabel.numberOfLines = 0;
        //结尾部分的内容以……方式省略，显示头的文字内
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _contentLabel;
}

- (UIView *)topline {
    if (!_topline) {
        _topline = [[UIView alloc] init];
        _topline.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    return _topline;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
