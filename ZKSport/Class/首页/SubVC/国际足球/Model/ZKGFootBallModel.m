//
//  ZKGFootBallModel.m
//  ZKSport
//
//  Created by Tom on 2017/11/17.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKGFootBallModel.h"

@implementation ZKGFootBallModel

- (CGFloat)cellHeight{
    if (self.imgextra) {
        CGSize size = CGSizeMake(D_WIDTH-Margin*2, MAXFLOAT);
        CGRect rect = [self.title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        CGFloat height = CGRectGetHeight(rect)+80+Margin*3;
        return height;
    }
    return 100;
}

@end
