//
//  ZKNBAModel.m
//  ZKSport
//
//  Created by Tom on 2017/11/16.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKNBAModel.h"

#define Margin 10

@implementation ZKNBAModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Templete":@"templete"};
}

- (CGFloat)cellHeight {
    if (self.hasHead) {
        CGSize size = CGSizeMake(D_WIDTH-Margin*2, MAXFLOAT);
        CGRect rect = [self.ltitle boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        CGFloat height = CGRectGetHeight(rect)+220+Margin*2;
        return height;
    }
    return 120;
}

@end
