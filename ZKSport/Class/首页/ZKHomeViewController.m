//
//  ZKHomeViewController.m
//  ZKSport
//
//  Created by Tom on 2017/11/15.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKHomeViewController.h"
#import "ZKTopBannerView.h"

@interface ZKHomeViewController ()<ZKTopBannerViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) ZKTopBannerView * topBannerView;
@property (nonatomic, strong) UIScrollView    * scrollView;
@end

@implementation ZKHomeViewController

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = NSLocalizedString(@"首页", nil);
    [self addTopBannerView];
    [self addScrollView];
    [self addChildViewControllers];
}

- (void)addTopBannerView{
    NSArray * titles = @[@"NBA",@"国际足球",@"CBA",@"中国足球",@"科技",@"手机",@"时尚"];
    self.topBannerView = [[ZKTopBannerView alloc] init];
    self.topBannerView.backgroundColor = [UIColor whiteColor];
    self.topBannerView.delegate = self;
    self.topBannerView.bannerNames = [NSMutableArray arrayWithArray:titles];
    self.topBannerView.frame = CGRectMake(0, NavBarH, D_WIDTH, 30);
    [self.view addSubview:self.topBannerView];
}

- (void)addScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, NavBarH+30, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-NavBarH-TabBarH-30);
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*5, 0);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    if (@available(iOS 11.0, *)){}
}

- (void)addChildViewControllers{
    NSArray * viewControllers = @[@"ZKNBAViewController",
                                  @"ZKGFootBallViewController",
                                  @"ZKCBAViewController",
                                  @"ZKCFootBallViewController",
                                  @"ZKTechViewController",
                                  @"ZKPhoneViewController",
                                  @"ZKFashionViewController"];
    NSInteger count = viewControllers.count;
    self.scrollView.contentSize = CGSizeMake(D_WIDTH*count, 0);
    NSInteger idx = 0;
    for (NSString * className in viewControllers) {
        UIViewController * viewController = (UIViewController *)[[NSClassFromString(className) alloc] init];
        viewController.view.frame = CGRectMake(idx*D_WIDTH, 0, D_WIDTH, CGRectGetHeight(self.scrollView.frame));
        idx++;
        [self.scrollView addSubview:viewController.view];
    }
}

#pragma mark - ZKTopBannerViewDelegate
- (void)didClickBannerItem:(NSInteger)page {
    CGFloat offsetX = page * D_WIDTH;
    [UIView animateWithDuration:0.25 animations:^{
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView { //滑动结束时调用
    NSInteger page = scrollView.contentOffset.x / D_WIDTH;
    [self.topBannerView selectTapBannerItemWithPage:page];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
