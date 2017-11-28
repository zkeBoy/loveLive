//
//  ZKGBigTableViewCell.h
//  ZKSport
//
//  Created by Tom on 2017/11/17.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKGFootBallModel.h"
@interface ZKGBigTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView      * mainView;
@property (nonatomic, strong) UILabel     * titleLabel;
@property (nonatomic, strong) UIImageView * imgView1;
@property (nonatomic, strong) UIImageView * imgView2;
@property (nonatomic, strong) UIImageView * imgView3;
@property (nonatomic, strong) ZKGFootBallModel * model;
@end
