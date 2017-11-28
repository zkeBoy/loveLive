//
//  ZKFunsTableViewCell.h
//  ZKSport
//
//  Created by Tom on 2017/11/18.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKFunsModel.h"
@interface ZKFunsTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView * mainView;
@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UILabel * userName;
@property (nonatomic, strong) UILabel * createTime;
@property (nonatomic, strong) UILabel * contentLabel;

@property (nonatomic, strong) ZKFunsModel * model;
@end
