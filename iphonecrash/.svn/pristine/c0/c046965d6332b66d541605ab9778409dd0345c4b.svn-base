//
//  MusicPlayManager.m
//  VoteCloud
//
//  Created by ios2 on 2019/7/31.
//  Copyright © 2019 CY. All rights reserved.
//
//http://www.voteyun.com/file/upload/music/201804081158417432495.mp3  测试连接
#import "MusicPlayManager.h"

@interface MusicPlayManager()

@property (nonatomic,strong)AVPlayerItem *playerItem;

@end

@implementation MusicPlayManager {
	NSString *_playUrl;
}

+(instancetype)manager
{
	MusicPlayManager *_playerManager = nil;
	_playerManager = [[MusicPlayManager alloc]init];
	return _playerManager;
}
/*初始化播放器*/
- (instancetype)init {
	if (self = [super init]) {
		_player = [[AVPlayer alloc] init];
		if (@available(iOS 10.0, *)) {
			self.player.automaticallyWaitsToMinimizeStalling = NO;
		}
		AVAudioSession *session = [AVAudioSession sharedInstance];
		[session  setCategory:AVAudioSessionCategoryPlayback error:nil];
		[session setActive:YES error:nil];
		//监听播放结束的通知
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
		[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playTimeEnd:) name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
	}
	return self;
}

-(void)PlayDidEnd:(NSNotification *)noti {
	if (self.isPlay) {
		if (noti.object ==self.player.currentItem) {
			[self playerProgressWithProgressFloat:0.0];
		}
	}
}
-(void)playTimeEnd:(NSNotification *)noti
{
	//播放超时
	_isPlay = NO;
	self.isStartPlayer(1);
}

// 播放
- (void)playerPlay {
	[_player play];
	_isPlay = YES;
}
//暂停
- (void)playerPause {
	[_player pause];
	_isPlay = NO;
}
//播放和暂停
- (void)playAndPause
{
	if (self.isPlay) {
		[self playerPause];
	}else{
		[self playerPlay];
	}
}
//音量
- (void)playerVolumeWithVolumeFloat:(CGFloat)volumeFloat
{
	self.player.volume = volumeFloat;
}
	//进度
- (void)playerProgressWithProgressFloat:(CGFloat)progressFloat
{
	[self.player seekToTime:CMTimeMakeWithSeconds(progressFloat, 1) completionHandler:^(BOOL finished) {
		[self playerPlay];
	}];
}
//当前播放
- (void)replaceItemWithUrlString:(NSString *)urlString
{
	_playUrl = urlString;
	AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlString]];
	[self.player replaceCurrentItemWithPlayerItem:item];
	if (self.playerItem) {
		[self removeObserVer];
	}
	self.playerItem = item;
	if (@available(iOS 9.0, *)) {
		self.playerItem.canUseNetworkResourcesForLiveStreamingWhilePaused = NO; //暂停以后不进行缓存
	}
	[self addObserVer];
	[self playerPlay];
}
//移除监听
-(void)removeObserVer
{
	[self.playerItem removeObserver:self forKeyPath:@"status"];
	[self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
	[self.playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
}
//添加监听
-(void)addObserVer {
	// 监听播放状态
	[self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
	// 监听缓冲进度
	[self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];

	[self.playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
}
	// KVO 方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
	if ([keyPath isEqualToString:@"status"]) {
		AVPlayerStatus status = [[change objectForKey:@"new"] integerValue];
		if (status == AVPlayerStatusReadyToPlay) {
			NSLog(@"缓存成功可以播放了");
			if (self.isPlay) {
				if (self.cacheCanPlay) {
					self.cacheCanPlay();
				}
			}
		} else if (status == AVPlayerStatusFailed) {
			NSLog(@"播放失败！");
			return;
		} else if (status == AVPlayerStatusUnknown) {
			NSLog(@"位置状态");
		}
	} else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
			// 处理缓冲进度条
	} else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
		//处理是否有缓存 buffer 的监听
	}
}
-(NSString *)currentUrl
{
	return _playUrl;
}
//移除监听以及KVO
-(void)dealloc
{
	[[NSNotificationCenter defaultCenter]removeObserver:self];
	[self removeObserVer];
}


@end
