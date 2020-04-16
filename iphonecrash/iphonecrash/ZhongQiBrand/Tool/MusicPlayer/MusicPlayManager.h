//
//  MusicPlayManager.h
//  VoteCloud
//
//  Created by ios2 on 2019/7/31.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MusicPlayManager : NSObject
/*播放器*/
@property (nonatomic, strong) AVPlayer *player;

/*是不是正在播放*/
@property (nonatomic, assign) BOOL isPlay;

//音乐缓存OK 可以播放
@property (nonatomic,copy)void(^cacheCanPlay)(void);

/*开始播放*/
@property (nonatomic,copy)void(^isStartPlayer)(NSInteger index);//0是开始 1 暂停
@property (nonatomic,readonly)NSString *currentUrl;



+(instancetype)manager;

/*播放和暂停*/
- (void)playAndPause;

/*当前播放项*/
- (void)replaceItemWithUrlString:(NSString *)urlString;
/*声音*/
- (void)playerVolumeWithVolumeFloat:(CGFloat)volumeFloat;
/*进度条*/
- (void)playerProgressWithProgressFloat:(CGFloat)progressFloat;


@end

