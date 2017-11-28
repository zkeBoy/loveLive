//
//  ZKCFootBallModel.h
//  ZKSport
//
//  Created by Tom on 2017/11/18.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKCFootBallModel : NSObject
@property (nonatomic, strong) NSArray  * imgextra;
@property (nonatomic, copy)   NSString * votecount;
@property (nonatomic, copy)   NSString * docid;
@property (nonatomic, copy)   NSString * lmodify;
@property (nonatomic, copy)   NSString * url_3w;
@property (nonatomic, copy)   NSString * source;
@property (nonatomic, copy)   NSString * postid;
@property (nonatomic, copy)   NSString * priority;
@property (nonatomic, copy)   NSString * title;
@property (nonatomic, copy)   NSString * mtime;
@property (nonatomic, copy)   NSString * url;
@property (nonatomic, copy)   NSString * replyCount;
@property (nonatomic, copy)   NSString * ltitle;
@property (nonatomic, copy)   NSString * subtitle;
@property (nonatomic, copy)   NSString * digest;
@property (nonatomic, copy)   NSString * boardid;
@property (nonatomic, copy)   NSString * imgsrc;
@property (nonatomic, copy)   NSString * ptime;
@property (nonatomic, copy)   NSString * daynum;

@property (nonatomic, copy)   NSString * topic_background;

@property (nonatomic, assign) CGFloat cellHeight;
@end
