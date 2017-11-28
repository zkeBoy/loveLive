//
//  ZKMusicTableViewCell.m
//  ZKSport
//
//  Created by Tom on 2017/11/21.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKMusicTableViewCell.h"

@interface ZKMusicTableViewCell()
@property (nonatomic, strong) UIView      * mainView;
@property (nonatomic, strong) UIImageView * iconImgView;
@property (nonatomic, strong) UILabel     * singerLabel;
@property (nonatomic, strong) UILabel     * songLabel;
@property (nonatomic, strong) UIImageView * moreImgView;
@property (nonatomic, strong) UIView      * bottonline;
@end

@implementation ZKMusicTableViewCell

- (void)setModel:(ZKMusicModel *)model {
    _model = model;
    
    NSString * icon = model.albumpic_small;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached];
    
    NSString * songName = model.songname;
    self.songLabel.text = songName;
    
    NSString * singer = model.singername;
    self.singerLabel.text = singer;
    
    if (!songName) {
        [self.bottonline setHidden:YES];
    }
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
    
    [self.mainView addSubview:self.iconImgView];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(self.mainView);
        make.width.equalTo(self.iconImgView.mas_height);
    }];
    
    [self.mainView addSubview:self.songLabel];
    [self.songLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView).offset(Margin);
        make.width.height.equalTo(self.songLabel);
        make.left.equalTo(self.iconImgView.mas_right).offset(Margin);
    }];
    
    [self.mainView addSubview:self.singerLabel];
    [self.singerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgView.mas_right).offset(Margin);
        make.bottom.equalTo(self.mainView).offset(-Margin);
        make.width.height.equalTo(self.singerLabel);
    }];
    
    [self.mainView addSubview:self.bottonline];
    [self.bottonline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgView.mas_right);
        make.bottom.right.equalTo(self.mainView);
        make.height.equalTo(@0.5);
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

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.backgroundColor = [UIColor clearColor];
    }
    return _iconImgView;
}

- (UILabel *)songLabel {
    if (!_songLabel) {
        _songLabel = [[UILabel alloc] init];
        _songLabel.backgroundColor = [UIColor clearColor];
        _songLabel.textColor = [UIColor blackColor];
        _songLabel.textAlignment = NSTextAlignmentLeft;
        _songLabel.font = [UIFont systemFontOfSize:13];
    }
    return _songLabel;
}

- (UILabel *)singerLabel {
    if (!_singerLabel) {
        _singerLabel = [[UILabel alloc] init];
        _singerLabel.backgroundColor = [UIColor clearColor];
        _singerLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
        _singerLabel.textAlignment = NSTextAlignmentLeft;
        _singerLabel.font = [UIFont systemFontOfSize:11];
    }
    return _singerLabel;
}

- (UIImageView *)moreImgView {
    if (!_moreImgView) {
        _moreImgView = [[UIImageView alloc] init];
        _moreImgView.backgroundColor = [UIColor clearColor];
    }
    return _moreImgView;
}

- (UIView *)bottonline {
    if (!_bottonline) {
        _bottonline = [[UIView alloc] init];
        _bottonline.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }
    return _bottonline;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
