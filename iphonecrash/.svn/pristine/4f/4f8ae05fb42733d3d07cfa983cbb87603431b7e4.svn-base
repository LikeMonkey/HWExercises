//
//  PlayerView.m
//  VoteCloud
//
//  Created by ios2 on 2019/7/31.
//  Copyright © 2019 CY. All rights reserved.
//

#import "PlayerView.h"

@interface PlayerView ()
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation PlayerView {
	UIImageView *_playImageView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self playerImageView];
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction:)];
		[_playImageView addGestureRecognizer:tap];
		_playImageView.userInteractionEnabled = YES;
	}
	return self;
}

-(void)onTapAction:(UITapGestureRecognizer *)tap
{
	if (tap.state == UIGestureRecognizerStateEnded) {
		self.isRun = !self.isRun;
	}
}

-(void)setPlayUrl:(NSString *)playUrl {
	if (_playUrl) {
		if ([playUrl isEqualToString:_playUrl]) return;
	}
	_playUrl = playUrl;
	_isRun = YES; //表示正在播放
	[self.playManager replaceItemWithUrlString:_playUrl];
}

-(void)setIsRun:(BOOL)isRun
{
	_isRun = isRun;
	if (_isRun) {
		[_playImageView sd_setImageWithURL:[NSURL URLWithString:_runThumb]];
		[self startTime];
		if (!self.playManager.isPlay) {
			[self.playManager  playAndPause];
			__weak typeof(self)ws = self;
			[self.playManager setIsStartPlayer:^(NSInteger index) {
				if (index == 1) {
					ws.isRun = NO;
				}
			}];
		}
	}else{
		[_playImageView sd_setImageWithURL:[NSURL URLWithString:_pasueThumb]];//修改图片
		[self stopTimer];//结束定时器
		if (self.playManager.isPlay) {//暂停播放
			[self.playManager  playAndPause];
		}
	}
}

-(void)startTime
{
	[self stopTimer];
	self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
	[_timer fire];
}
-(void)stopTimer
{
	if (_timer) {
		[_timer invalidate];
		_timer = nil;
	}
}
-(void)onTimer
{
	[UIView beginAnimations:@"rzoration" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	_playImageView.transform = CGAffineTransformRotate(_playImageView.transform, 0.2);
	[UIView commitAnimations];
}
-(void)setRunThumb:(NSString *)runThumb
{
	_runThumb = runThumb;
	[_playImageView sd_setImageWithURL:[NSURL URLWithString:_runThumb]];
}

-(void)playerImageView
{
	UIImageView *playerImageV = [UIImageView new];
	[self addSubview:playerImageV];
	playerImageV.frame = CGRectMake(0, 0, 50, 50);
	playerImageV.layer.cornerRadius = 25;
	playerImageV.layer.masksToBounds = YES;
	_playImageView = playerImageV;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
	if (!newSuperview) {
		[self stopTimer];//结束声音
	}
}
-(void)layoutSubviews {
	[super layoutSubviews];
	CGFloat w =  CGRectGetWidth(self.bounds);
	CGFloat h =  CGRectGetHeight(self.bounds);
	_playImageView.center = (CGPoint){w/2.0,h/2.0};
}

-(MusicPlayManager *)playManager
{
	if (!_playManager) {
	_playManager = [MusicPlayManager manager];
 }
	return _playManager;
}

-(void)dealloc
{
	NSLog(@"播放转圈释放");
}


@end
