//
//  ZKMusicModel.h
//  ZKSport
//
//  Created by Tom on 2017/11/21.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKMusicModel : NSObject
@property (nonatomic, copy) NSString * songname;
@property (nonatomic, copy) NSString * seconds;
@property (nonatomic, copy) NSString * albummid;
@property (nonatomic, copy) NSString * songid;
@property (nonatomic, copy) NSString * singerid;
@property (nonatomic, copy) NSString * albumpic_big;
@property (nonatomic, copy) NSString * albumpic_small;
@property (nonatomic, copy) NSString * downUrl;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * singername;
@property (nonatomic, copy) NSString * albumid;


/*
 -- albumid     String     452381     专辑id
 -- albumname     String     海阔天空     专辑名称
 -- albumpic_big     String     http://imgcache.qq.com/music/photo/album_300/60/300_albumpic_62660_0.jpg     专辑大图片，高宽300
 -- albumpic_small     String     http://imgcache.qq.com/music/photo/album/60/90_albumpic_62660_0.jpg     专辑小图片，高宽90
 -- downUrl     String     http://stream10.qqmusic.qq.com/34833285.mp3     mp3下载链接
 -- m4a     String     http://ws.stream.qqmusic.qq.com/4833285.m4a?fromtag=46     流媒体地址
 -- singerid     String     123     歌手id
 -- singername     String     BEYOND     歌手名
 -- songid     String     4833285     歌曲id
 -- songname     String     海阔天空     歌曲名称
 */

@end
