//
//  ZKFunsDetailModel.h
//  ZKSport
//
//  Created by Tom on 2017/11/18.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKFunsUserModel.h"
@interface ZKFunsDetailModel : NSObject
@property (nonatomic, copy) NSString * data_id;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * ctime;
@property (nonatomic, copy) NSString * precid;
@property (nonatomic, copy) NSString * like_count;
@property (nonatomic, copy) NSString * voiceuri;
@property (nonatomic, copy) NSString * voicetime;
@property (nonatomic, copy) NSString * cmt_type;
@property (nonatomic, strong) ZKFunsUserModel * user;

@property (nonatomic, assign) CGFloat cellHeight;
@end
