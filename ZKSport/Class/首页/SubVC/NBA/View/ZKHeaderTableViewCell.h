//
//  ZKHeaderTableViewCell.h
//  ZKSport
//
//  Created by Tom on 2017/11/16.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKNBAModel.h"
@interface ZKHeaderTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView      * mainView;
@property (nonatomic, strong) UILabel     * titleLabel;
@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) ZKNBAModel  * model;
@end
