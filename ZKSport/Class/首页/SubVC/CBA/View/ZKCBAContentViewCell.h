//
//  ZKCBAContentViewCell.h
//  ZKSport
//
//  Created by Tom on 2017/11/18.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKCBAModel.h"
@interface ZKCBAContentViewCell : UITableViewCell
@property (nonatomic, strong) UIView      * mainView;
@property (nonatomic, strong) UIView      * topline;
@property (nonatomic, strong) FLAnimatedImageView * imgView;
@property (nonatomic, strong) UILabel     * titleLabel;
@property (nonatomic, strong) UILabel     * contentLabel;
@property (nonatomic, strong) ZKCBAModel  * model;
@end
