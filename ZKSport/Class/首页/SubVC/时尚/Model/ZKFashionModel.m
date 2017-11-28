//
//  ZKFashionModel.m
//  ZKSport
//
//  Created by Tom on 2017/11/22.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKFashionModel.h"

@implementation ZKFashionModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Template":@"template"};
}

- (CGFloat)cellHeight{
    if (self.imgextra) {
        CGSize size = CGSizeMake(D_WIDTH-Margin*2, MAXFLOAT);
        CGRect rect = [self.title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        CGFloat height = CGRectGetHeight(rect)+80+Margin*3;
        return height;
    }
    return 200;
}

@end
