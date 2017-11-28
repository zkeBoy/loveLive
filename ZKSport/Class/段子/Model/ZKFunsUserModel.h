//
//  ZKFunsUserModel.h
//  ZKSport
//
//  Created by Tom on 2017/11/18.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKFunsUserModel : NSObject
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * sex;
@property (nonatomic, copy) NSString * profile_image;
@property (nonatomic, copy) NSString * weibo_uid;
@property (nonatomic, copy) NSString * qq_uid;
@property (nonatomic, copy) NSString * qzone_uid;
@property (nonatomic, copy) NSString * is_vip;
@property (nonatomic, copy) NSString * personal_page;
@property (nonatomic, copy) NSString * total_cmt_like_count;

@end
