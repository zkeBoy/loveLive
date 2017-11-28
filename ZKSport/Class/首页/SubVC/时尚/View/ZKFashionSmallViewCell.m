//
//  ZKFashionSmallViewCell.m
//  ZKSport
//
//  Created by Tom on 2017/11/22.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKFashionSmallViewCell.h"

@interface ZKFashionSmallViewCell()
@property (nonatomic, strong) UIView      * mainView;
@property (nonatomic, strong) UILabel     * titleLabel;
@property (nonatomic, strong) UIImageView * imgView;
@end

@implementation ZKFashionSmallViewCell

- (void)setModel:(ZKFashionModel *)model {
    _model = model;
    
    NSString * title = model.title;
    self.titleLabel.text = title;
    
    NSString * imgsrc = model.imgsrc;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgsrc] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageProgressiveDownload completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
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
    CGRect rect = [_model.title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    self.titleLabel.frame = CGRectMake(Margin, Margin, D_WIDTH-Margin*2, CGRectGetHeight(rect));
    
    [self.mainView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainView).offset(Margin);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Margin);
        make.bottom.right.equalTo(self.mainView).offset(-Margin);
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
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor whiteColor];
    }
    return _imgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
