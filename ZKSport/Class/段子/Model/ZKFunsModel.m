//
//  ZKFunsModel.m
//  ZKSport
//
//  Created by Tom on 2017/11/18.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKFunsModel.h"

@implementation ZKFunsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

- (CGFloat)cellHeight {
    CGSize size = CGSizeMake(D_WIDTH-Margin*4, MAXFLOAT);
    CGRect frame = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    CGFloat height = CGRectGetHeight(frame);
    height = height+Margin*3+40+10;
    return height;
}

@end
