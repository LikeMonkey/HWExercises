//
//  SnowDownView.m
//  DownSnow
//
//  Created by ios2 on 2019/7/24.
//  Copyright © 2019 ayou. All rights reserved.
//

#import "SnowDownView.h"

@interface SnowDownView() {
	UIImage *_image;
}

@property (nonatomic,strong)NSMutableArray *snowArray;

@property (nonatomic,strong)NSTimer *timer;

@end

@implementation SnowDownView

-(instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.userInteractionEnabled = NO;
		self.clipsToBounds = YES;
		for (int i = 0; i<20; i++) {
			UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
			imgView.alpha = 0;
			[self addSubview:imgView];
			[self.snowArray addObject:imgView];
		}
	}
	return self;
}
-(void)stop {
	_isStart = NO;
	[self stopTimer];
}

-(void)startUrl:(NSString *)url
{
	UIImageView *imgV = [self findImageView];
	
	if (!imgV) {
		imgV = [self.snowArray lastObject];
	}
	__weak typeof(self)ws = self;
	[imgV sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
		if (image) {
			[ws startSnowWithImages:@[image]];
		}
	}];
}

-(void)startSnowWithImages:(NSArray *)images
{
	_isStart = YES;
	_image = images.lastObject;
	[self startTimer];
}

-(void)startTimer
{
	[self stopTimer];
	self.timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
	[_timer fire];
}

-(void)onTimer
{
	UIImageView *imgV =  [self findImageView]; //查找已经下落的图片
	if (imgV) {
		imgV.alpha = 1.0;
		imgV.image = _image;

		CGFloat imgScale = _image.size.width/_image.size.height;

		CGFloat width = arc4random()%10 + 30; //随机图片宽度
		NSInteger maxX = MAINScreenWidth - width; //保证在屏幕内
		imgV.x = arc4random()%maxX; //随机X值

		imgV.size = CGSizeMake(width, width/imgScale); //根据图片大小修改 下落的图片的尺寸

		imgV.y = -(width/imgScale);

		imgV.transform =  CGAffineTransformMakeScale(1.0, 1.0); //修改缩放比例为 1.0

		NSInteger delay =  arc4random()%2; //设置延时和不延时 打乱下落顺序

		[UIView animateWithDuration:6 delay:delay options:(UIViewAnimationOptionCurveEaseOut) animations:^{
			imgV.y = MAINScreenHeight;
			imgV.alpha = 0.01;
			imgV.transform =  CGAffineTransformMakeScale(1.5, 1.5);
		} completion:^(BOOL finished) {
			imgV.alpha = 0;
		}];
	}
}
-(UIImageView *)findImageView
{
	for (UIImageView *imgView in self.snowArray) {
		if (imgView.alpha == 0) {
			return imgView;
		}
	}
	return nil;
}

-(void)stopTimer
{
	if (_timer) {
		[_timer invalidate];
		_timer = nil;
	}
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
	if (!newSuperview) {
		[self stopTimer];
	}
}
-(NSMutableArray *)snowArray
{
	if (!_snowArray) {
	_snowArray = [[NSMutableArray alloc]init];
 }
	return _snowArray;
}

-(void)dealloc
{
	NSLog(@"内存释放了");
}


@end
