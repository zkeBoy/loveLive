//
//  ZKTopBannerView.m
//  ZKSport
//
//  Created by Tom on 2017/11/15.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKTopBannerView.h"
#define NFont 14
#define SFont 16

#define Scolor [UIColor colorWithRed:243/255.0 green:75/255.0 blue:80/255.0 alpha:1.0]
#define Ncolor [UIColor blackColor]
static CGFloat btnWidth  = 68;

@interface ZKTopBannerView ()
@property (nonatomic, strong) UIButton * selectBtn;
@end

@implementation ZKTopBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initInstance];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubViews];
}

- (void)addSubViews {
    _scrollView.contentSize = CGSizeMake(btnWidth*self.bannerNames.count, 0);
    CGFloat height = CGRectGetHeight(self.frame);
    NSInteger index = 0;
    for (NSString * name in self.bannerNames) {
        UIButton * button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor whiteColor];
        button.tag = index+100;
        button.frame = CGRectMake(btnWidth*index, 0, btnWidth, height);
        button.titleLabel.font = [UIFont systemFontOfSize:NFont];
        [button setTitle:name forState:UIControlStateNormal];
        [button setTitleColor:Ncolor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didClickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        index++;
    }
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-0.5, btnWidth*self.bannerNames.count, 0.5)];
    self.bottomLine.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self.scrollView addSubview:self.self.bottomLine];
    [self.scrollView layoutIfNeeded];
    
    //选中第一个
    self.selectBtn = (UIButton *)[self.scrollView viewWithTag:100];
    [self didClickButtonAction:self.selectBtn];
}

- (void)initInstance {
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setBannerNames:(NSMutableArray *)bannerNames{
    _bannerNames = bannerNames;
}

- (void)didClickButtonAction:(UIButton *)sender {
    self.selectBtn = sender;
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:SFont];
    [self.selectBtn setTitleColor:Scolor forState:UIControlStateNormal];
    for (UIButton * view in self.scrollView.subviews) {
        if (![view isEqual:self.selectBtn]&&[view isKindOfClass:[UIButton class]]) {
            view.titleLabel.font = [UIFont systemFontOfSize:15];
            [(UIButton *)view setTitleColor:Ncolor forState:UIControlStateNormal];
        }
    }
    [self changeScrollViewContentOffSetOfSelectBtn:sender];
}

- (void)changeScrollViewContentOffSetOfSelectBtn:(UIButton *)sender {
    CGFloat offsetX = sender.center.x - D_WIDTH/2;
    if (offsetX<0) {
        offsetX = 0;
    }
    CGFloat x = self.scrollView.contentSize.width-D_WIDTH;
    if (offsetX>x) {
        offsetX = x;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }];
    NSString * titleName = self.selectBtn.titleLabel.text;
    NSInteger index = [self.bannerNames indexOfObject:titleName];
    [self.delegate didClickBannerItem:index];
}

- (void)selectTapBannerItemWithPage:(NSInteger)page{
    self.selectBtn = (UIButton *)[self.scrollView viewWithTag:page+100];
    CGFloat offsetX = self.selectBtn.center.x - D_WIDTH/2;
    if (offsetX<0) {
        offsetX = 0;
    }
    CGFloat x = self.scrollView.contentSize.width-D_WIDTH;
    if (offsetX>x) {
        offsetX = x;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }];
    
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:SFont];
    [self.selectBtn setTitleColor:Scolor forState:UIControlStateNormal];
    for (UIButton * view in self.scrollView.subviews) {
        if (![view isEqual:self.selectBtn]&&[view isKindOfClass:[UIButton class]]) {
            view.titleLabel.font = [UIFont systemFontOfSize:NFont];
            [(UIButton *)view setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - lazy init
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.bounces = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
