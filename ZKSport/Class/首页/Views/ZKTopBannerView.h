//
//  ZKTopBannerView.h
//  ZKSport
//
//  Created by Tom on 2017/11/15.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZKTopBannerViewDelegate;
@interface ZKTopBannerView : UIView
@property (nonatomic, strong) UIScrollView   * scrollView;
@property (nonatomic, strong) NSMutableArray * bannerNames;
@property (nonatomic, strong) UIView         * bottomLine;
@property (nonatomic,   weak) id <ZKTopBannerViewDelegate> delegate;

- (void)selectTapBannerItemWithPage:(NSInteger)page;
@end

@protocol ZKTopBannerViewDelegate <NSObject>
@optional
- (void)didClickBannerItem:(NSInteger)page;

@end
