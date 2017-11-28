//
//  ZKFunsDetailModel.m
//  ZKSport
//
//  Created by Tom on 2017/11/18.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKFunsDetailModel.h"

@implementation ZKFunsDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"user":[ZKFunsUserModel class]};
}

- (CGFloat)cellHeight {
    CGSize size = CGSizeMake(D_WIDTH-80, MAXFLOAT);
    CGRect rect = [self.content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    _cellHeight = Margin*2 +20 + CGRectGetHeight(rect);
    return _cellHeight;
}

@end
