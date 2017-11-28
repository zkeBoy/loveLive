//
//  ZKContentTableViewCell.h
//  ZKSport
//
//  Created by Tom on 2017/11/16.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKNBAModel.h"
@interface ZKContentTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView      * mainView;
@property (nonatomic, strong) UIView      * topline;
@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UILabel     * titleLabel;
@property (nonatomic, strong) UILabel     * contentLabel;
@property (nonatomic, strong) ZKNBAModel  * model;
@end
