//
//  ZKMusicPlayView.m
//  ZKSport
//
//  Created by Tom on 2017/11/21.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKMusicPlayView.h"

@interface ZKMusicPlayView ()
@property (nonatomic, strong) AVPlayer     * musicPlayer;
@property (nonatomic, strong) UIImageView  * iconImgView;
@property (nonatomic, strong) UIButton     * pauseBtn;
@property (nonatomic, strong) UISlider     * sliderView;
@property (nonatomic, strong) UILabel      * timeLabel;
@property (nonatomic, strong) NSTimer      * playTimer; //播放计时器
@end

static NSString * const playerStatus = @"status";

@implementation ZKMusicPlayView
- (void)setMusicModel:(ZKMusicModel *)musicModel {
    _musicModel = musicModel;
    
    [self playMusicFinish];
    
    NSString * icon = musicModel.albumpic_small;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    NSString * link = _musicModel.url;
    [self addMusicPlayerWithlink:link];
}

#pragma mark - init AVPlayer
- (void)addMusicPlayerWithlink:(NSString *)link {
    if (!self.musicPlayer) {
        self.musicPlayer = [[AVPlayer alloc] init];
    }
    AVPlayerItem * item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:link]];
    [self.musicPlayer replaceCurrentItemWithPlayerItem:item];
    [self.musicPlayer play];
    [self.musicPlayer addObserver:self forKeyPath:playerStatus options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(musicPlayFinish:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:playerStatus]) {
        AVPlayerItem *item = (AVPlayerItem *)object;
        if (item.status == AVPlayerItemStatusReadyToPlay) { //开始播放
            //开启进度计时器
            [self startTimer];
            self.pauseBtn.enabled = YES;
            self.pauseBtn.selected = YES;
        }
    }
}

- (void)musicPlayFinish:(NSNotification *)not {
    [self playMusicFinish];
}

#pragma mark - Fire NSTimer
- (void)startTimer {
    if (!self.playTimer) {
        self.playTimer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(updateTimerProgress) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.playTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)pauseTimer{
    if (self.playTimer) {
        [self.playTimer setFireDate:[NSDate distantFuture]];
    }
}

- (void)continueTimer {
    if (self.playTimer) {
        [self.playTimer setFireDate:[NSDate date]];
    }
}

- (void)stopTimer {
    if (self.playTimer) {
        [self.playTimer invalidate];
        self.playTimer = nil;
    }
}

- (void)updateTimerProgress{
    NSTimeInterval currentTime = CMTimeGetSeconds(self.musicPlayer.currentTime);
    NSTimeInterval duration = CMTimeGetSeconds(self.musicPlayer.currentItem.duration);
    if (currentTime>=duration) {//播放结束
        
    }else{ //更新进度
        self.sliderView.value = currentTime/duration;
        self.timeLabel.text = [NSString stringWithCurrentTime:currentTime duration:duration];
    }
}

#pragma mark - Music Method
- (void)playMusicFinish {
    [self.musicPlayer removeObserver:self forKeyPath:playerStatus];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stopTimer];
    self.sliderView.value = 0.0f;
    self.timeLabel.text = [NSString stringWithCurrentTime:0.0f duration:0.0f];
    self.iconImgView.image = [UIImage imageNamed:@"icons8_music_record"];
    self.pauseBtn.enabled = NO;
    self.pauseBtn.selected = YES;
    
    if (self.musicPlayer) {
        self.musicPlayer = nil;
    }
}

- (void)pauseMusicByBtn:(UIButton *)btn {
    self.pauseBtn.selected = !btn.selected;
    if (self.pauseBtn.selected) {
        [self continueTimer];
        [self.musicPlayer play];
    }else{
        [self pauseTimer];
        [self.musicPlayer pause];
    }
}

#pragma mark - Private Method
- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
    [self setUI];
}

- (void)setUI {
    [self addSubview:self.iconImgView];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(4);
        make.bottom.equalTo(self).offset(-4);
        make.width.equalTo(self.iconImgView.mas_height);
    }];
    
    [self addSubview:self.pauseBtn];
    [self.pauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-4);
        make.width.height.mas_equalTo(43);
    }];
    
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.height.equalTo(self.timeLabel);
        make.right.equalTo(self.pauseBtn.mas_left).offset(-4);
    }];
    
    [self addSubview:self.sliderView];
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.iconImgView.mas_right).offset(4);
        make.right.equalTo(self.timeLabel.mas_left).offset(-4);
    }];
}

#pragma mark - lazy init
- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.backgroundColor = [UIColor clearColor];
        _iconImgView.image = [UIImage imageNamed:@"icons8_music_record"];
    }
    return _iconImgView;
}

- (UIButton *)pauseBtn {
    if (!_pauseBtn) {
        _pauseBtn = [[UIButton alloc] init];
        _pauseBtn.backgroundColor = [UIColor clearColor];
        [_pauseBtn setImage:[UIImage imageNamed:@"play_btn"] forState:UIControlStateNormal];
        [_pauseBtn setImage:[UIImage imageNamed:@"pause_btn"] forState:UIControlStateSelected];
        [_pauseBtn addTarget:self action:@selector(pauseMusicByBtn:) forControlEvents:UIControlEventTouchUpInside];
        _pauseBtn.enabled = NO;
    }
    return _pauseBtn;
}

- (UISlider *)sliderView {
    if (!_sliderView) {
        _sliderView = [[UISlider alloc] init];
        _sliderView.maximumValue = 1.0f;
        _sliderView.minimumValue = 0.0f;
        _sliderView.value = 0.0f;
        [_sliderView setThumbImage:[UIImage imageNamed:@"music_thumb_Image"] forState:UIControlStateNormal];
        _sliderView.minimumTrackTintColor = [UIColor whiteColor]; //走过的颜色
        _sliderView.maximumTrackTintColor = [UIColor redColor];   //剩余的颜色
        _sliderView.enabled = NO; //不可滑动
    }
    return _sliderView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.text = [NSString stringWithCurrentTime:0.0f duration:0.0f];
    }
    return _timeLabel;
}

- (void)dealloc {
    NSLog(@"ZKMusicPlayView dealloc !!!!!!");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
