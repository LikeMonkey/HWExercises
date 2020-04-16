//
//  PointImageView.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/20.
//  Copyright © 2019 CY. All rights reserved.
//

#import "PointImageView.h"
#import "PointItem.h"
#import "UIImageView+WebCache.h"

#define MAX_WORDS 100

@interface PointImageView()
{
	id <SDWebImageOperation>_imageLoadingTask;
	UITapGestureRecognizer *_tap;
}

@property (nonatomic,assign)BOOL canPoint;

@property (nonatomic,strong)NSMutableArray *pointItems;

@property(nonatomic,assign)BOOL isLoading;
//字数
@property(nonatomic,assign)NSInteger textCount;

@end

@implementation PointImageView

-(instancetype)init
{
	self = [super init];
	if (self) {
		self.textCount = MAX_WORDS;
		self.sucessImageWidth = 250;
		self.animationView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];

		self.animationView.color = [UIColor colorWithRed:0xcf/255.0 green:0x04/255.0 blue:0x05/255.0 alpha:1];;
		[self addSubview:self.animationView];

		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
		[self addGestureRecognizer:tap];
		_tap = tap;

		self.backgroundColor =  [UIColor colorWithRed:0xff/255.0 green:0xff/255.0 blue:0xff/255.0 alpha:1];
		self.userInteractionEnabled = YES;

		for (int i = 0; i<MAX_WORDS; i++) {
			PointItem *item = [[PointItem alloc]init];
			item.hidden = YES;
			item.number = [NSString stringWithFormat:@"%d",i+1];
			[self.pointItems addObject:item];
			[self addSubview:item];
			__weak typeof(self)ws = self;
			[item setDidClickedBlock:^(id sender) {
				[ws didClickedItem:sender];
			}];
		}
	}
	return self;
}

-(void)onTap:(UITapGestureRecognizer *)tap
{
	if (tap.state == UIGestureRecognizerStateEnded) {
		if (!_canPoint) {
			//刷新数据
			[self refresh];
			return;
		}
		CGPoint point = [tap locationInView:self];
		PointItem *pointItem = [self foundPointItem];
		if (pointItem) {
			pointItem.hidden = NO;
			pointItem.itemPoint = point;
			[self checkPointItemCount];
		}
	}
}

-(void)checkPointItemCount
{
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"hidden = NO"];
	NSArray *array =  [self.pointItems filteredArrayUsingPredicate:pred];
	if (array.count >= self.textCount) {
		if (_tap.enabled) {
			[self getAllPointMessage:YES];
		}
		_tap.enabled = NO;
	}else{
		_tap.enabled = YES;
	}
}

-(void)configerRandText
{
	NSInteger randNum = 0;
	NSInteger randMax = 6 + arc4random() %4;
	for (int i = 0; i< randMax; i++) {
		NSInteger rand = (arc4random()%9 + 1);
		randNum += rand * pow(10, i);
	}
	self.rnd = [@(randNum) stringValue];
	NSString *url =[NSString stringWithFormat:@"http://xxxxx.mlicapthp?rand=%@",self.rnd];
	if (self.thumbUrlBlock) {
		url = self.thumbUrlBlock(self.rnd);
	}
	self.url = url;
	NSLog(@"输出生成的随机数:|%@",@(randNum));
}
//是否是最后一个
-(void)getAllPointMessage:(BOOL)isMax
{
	NSMutableArray *centers = [NSMutableArray array];
	for (int i = 0; i<self.pointItems.count; i++) {
		PointItem *pointItem = self.pointItems[i];
		CGPoint point = pointItem.itemPoint;
		CGFloat x = point.x * self.sucessImageWidth/CGRectGetWidth(self.bounds);
		CGFloat y = point.y *self.sucessImageWidth/CGRectGetWidth(self.bounds);
		NSValue *value = [NSValue valueWithCGPoint:(CGPoint){x,y}];
		if (i<(self.textCount -1)) {
			[centers addObject:value];
		}else{
			break; //跳出循环
		}
	}
	[self yzAllPoint:centers andIsMax:isMax];
}

-(void)yzAllPoint:(NSArray *)pointArray andIsMax:(BOOL)isMax
{
	[self requestYz:pointArray andIsMax:isMax];
}

-(void)requestYz:(NSArray *)pointArray andIsMax:(BOOL)isMax
{
	NSString *rand = [self.rnd copy];
	NSMutableArray *temArray = [NSMutableArray array];
	for (int i  =0; i< pointArray.count; i++) {
		NSValue *pointValue = pointArray[i];
		CGPoint point = [pointValue CGPointValue];
		NSDictionary *pointDic = @{@"t":[@((i+1)) stringValue],@"x":@(point.x),@"y":@(point.y)};
		[temArray addObject:pointDic];
	}
	NSString *json =[self jsonStringCompactFormatForNSArray:temArray];
	__weak typeof(self)ws = self;
	
	YZCompletion block = ^(BOOL isSucess,NSString *json){
		if (isSucess) {
			[ws yzSucessAction:json]; //进行验证通过
		}else{
			[ws reload];
		}
	};
	!_requestYZPoint?:_requestYZPoint(json,rand,block);
}

-(void)yzSucessAction:(NSString *)json
{
	!_sucessCompletion?:_sucessCompletion(self.rnd,self.itemId,json);
	[self dismiss];
}

- (NSString *)jsonStringCompactFormatForNSArray:(NSArray *)arrJson {

	if (![arrJson isKindOfClass:[NSArray class]] || ![NSJSONSerialization isValidJSONObject:arrJson]) {
		return nil;
	}
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrJson options:0 error:nil];

	NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
	return strJson;
}
-(PointItem *)foundPointItem
{
	PointItem *item = nil;
	for (int i = 0; i<self.pointItems.count; i++) {
		PointItem *aItem = self.pointItems[i];
		if (aItem.hidden) {
			item = aItem;
			break;
		}
	}
	return item;
}

-(void)didClickedItem:(PointItem *)item
{
	[self checkPointItemCount]; //往回
}
-(void)refresh
{
	if (self.isLoading)return;
	self.isLoading = YES;

	//重置随机数
	[self configerRandText];

	//隐藏所有的点
	[self.pointItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		PointItem *pointV = obj;
		pointV.itemPoint = CGPointZero;
		pointV.hidden = YES;
	}];


	__weak typeof(self)ws = self;
	self.canPoint = NO;        //不能加点
	self.isLoading = YES;     //开始加载
	self.image= nil;              //图片置空

	if (_imageLoadingTask) {
		[_imageLoadingTask cancel];  //取消图片的下载任务
	}

	LoadTextCompletion block =^(NSString *text,BOOL isSucess) {
		if (isSucess) {
			[ws loadImageWithText:text];
		}else{
			UIImage *failImge =  [UIImage imageNamed:@"loadFaill"];
			ws.isLoading = NO;
			[ws loadImage:failImge];
		}
	};

	!_changeTextRequest?:_changeTextRequest(self.rnd,block);
}

-(void)loadImageWithText:(NSString *)text
{
	__weak typeof(self)ws = self;
	self.textCount = text.length;
	
	_imageLoadingTask = [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:_url] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
	} completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
		if (image) {
			[ws loadImage:image];
		}
		ws.isLoading = NO;
	}];
}

-(void)reload
{
	self.isLoading = NO;
	[self refresh];
}
-(void)setIsLoading:(BOOL)isLoading
{
	_isLoading = isLoading;
	if (_isLoading) {
		[self.animationView startAnimating];
	}else{
		[self.animationView stopAnimating];
	}
	[self checkPointItemCount]; //往回
}

-(void)loadImage:(UIImage *)image
{
	self.image = image;
	if (image) {
		CGSize imgSize = image.size;
		CGFloat scale =  [UIScreen mainScreen].scale;
		if (imgSize.width*scale <= (self.sucessImageWidth + 10)) {
			self.canPoint = YES;
		}else{
			self.canPoint = NO;
		}
	}
}
-(void)layoutSubviews
{
	[super layoutSubviews];
	self.animationView.bounds = CGRectMake(0, 0, 30, 30);
	self.animationView.center = CGPointMake(CGRectGetWidth(self.bounds)/2.0, CGRectGetHeight(self.bounds)/2.0);
}

-(void)dismiss
{
	!_dismissBlock?:_dismissBlock();
}

#pragma mark - Getter
-(NSMutableArray *)pointItems
{
	if (!_pointItems) {
		_pointItems = [[NSMutableArray alloc]init];
	 }
	return _pointItems;
}

//点击事件 超出部分的限制
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
		return nil;
	}
	UIView *result = [super hitTest:point withEvent:event];
		// 如果事件发生在 图片内部 里面直接返回
	if (result) {
		return result;
	}
		// 这里遍历那些超出的部分就可以了，不过这么写比较通用。
	for (UIView *subview in self.subviews) {
			// 把这个坐标从tabbar的坐标系转为 subview 的坐标系
		CGPoint subPoint = [subview convertPoint:point fromView:self];
		result = [subview hitTest:subPoint withEvent:event];
			// 如果事件发生在 subView 里就返回
		if (result) {
			return result;
		}
	}
	return nil;
}

@end
