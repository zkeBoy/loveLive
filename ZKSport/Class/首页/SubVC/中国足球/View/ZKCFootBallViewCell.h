//
//  ZKCFootBallViewCell.h
//  ZKSport
//
//  Created by Tom on 2017/11/18.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKCFootBallModel.h"
@interface ZKCFootBallViewCell : UITableViewCell
@property (nonatomic, strong) UIView      * mainView;
@property (nonatomic, strong) UIImageView * imgView1;
@property (nonatomic, strong) UIImageView * imgView2;
@property (nonatomic, strong) UIImageView * imgView3;
@property (nonatomic, strong) UILabel     * titleLabel;
@property (nonatomic, strong) ZKCFootBallModel * model;
@end
