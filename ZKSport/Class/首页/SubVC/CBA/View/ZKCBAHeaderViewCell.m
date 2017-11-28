//
//  ZKCBAHeaderViewCell.m
//  ZKSport
//
//  Created by Tom on 2017/11/18.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKCBAHeaderViewCell.h"

#define I_W (D_WIDTH-Margin*4)/3

@implementation ZKCBAHeaderViewCell

- (void)setModel:(ZKCBAModel *)model {
    _model = model;
    
    NSString * text = model.title;
    self.titleLabel.text = text;
    
    NSString * imgSrc1 = model.imgextra[0][@"imgsrc"];
    [self.imgView1 sd_setImageWithURL:[NSURL URLWithString:imgSrc1] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    NSString * imgSrc2 = model.imgextra[1][@"imgsrc"];
    [self.imgView2 sd_setImageWithURL:[NSURL URLWithString:imgSrc2] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    NSString * imgSrc3 = model.imgsrc;
    [self.imgView3 sd_setImageWithURL:[NSURL URLWithString:imgSrc3] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
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
    
    [self.mainView addSubview:self.titleLabel];
    CGSize size = CGSizeMake(D_WIDTH-Margin*2, MAXFLOAT);
    CGRect frame = [_model.title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    CGFloat height = CGRectGetHeight(frame);
    self.titleLabel.frame = CGRectMake(Margin, Margin, D_WIDTH-Margin*2, height);
    
    [self.mainView addSubview:self.imgView1];
    [self.imgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Margin);
        make.left.equalTo(self.titleLabel);
        make.width.mas_equalTo(I_W);
        make.bottom.equalTo(self.mainView).offset(-Margin);
    }];
    
    [self.mainView addSubview:self.imgView2];
    [self.imgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Margin);
        make.left.equalTo(self.imgView1.mas_right).offset(Margin);
        make.bottom.equalTo(self.mainView).offset(-Margin);
        make.width.mas_equalTo(I_W);
    }];
    
    [self.mainView addSubview:self.imgView3];
    [self.imgView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Margin);
        make.left.equalTo(self.imgView2.mas_right).offset(Margin);
        make.bottom.equalTo(self.mainView).offset(-Margin);
        make.width.mas_equalTo(I_W);
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

- (UIImageView *)imgView1 {
    if (!_imgView1) {
        _imgView1 = [[UIImageView alloc] init];
        _imgView1.backgroundColor = [UIColor clearColor];
    }
    return _imgView1;
}

- (UIImageView *)imgView2 {
    if (!_imgView2) {
        _imgView2 = [[UIImageView alloc] init];
        _imgView2.backgroundColor = [UIColor clearColor];
    }
    return _imgView2;
}

- (UIImageView *)imgView3 {
    if (!_imgView3) {
        _imgView3 = [[UIImageView alloc] init];
        _imgView3.backgroundColor = [UIColor clearColor];
    }
    return _imgView3;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
