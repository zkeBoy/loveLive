//
//  ZKHeaderTableViewCell.m
//  ZKSport
//
//  Created by Tom on 2017/11/16.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKHeaderTableViewCell.h"

@implementation ZKHeaderTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setUI];
}

- (void)setModel:(ZKNBAModel *)model {
    _model = model;
    NSString * text = model.ltitle;
    self.titleLabel.text = text;
    
    NSString * imgsrc = model.imgsrc;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgsrc] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (void)setUI {
    [self.contentView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.mainView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.mainView).offset(Margin);
        make.right.equalTo(self.mainView).offset(-Margin);
        make.height.equalTo(self.titleLabel);
    }];
    
    [self.mainView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mainView).offset(-6);
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Margin);
        make.bottom.equalTo(self.mainView.mas_bottom).offset(-1);
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _titleLabel;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor clearColor];
    }
    return _imgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
