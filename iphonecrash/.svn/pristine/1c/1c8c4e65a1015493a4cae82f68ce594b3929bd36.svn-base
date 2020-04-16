//
//  QrScanViewController.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "QrScanViewController.h"
#import "TZImagePickerController.h"
#import <ImageIO/ImageIO.h>

#import "ScanView.h"

#import "NSURL+Params.h"

@interface QrScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,
AVCaptureVideoDataOutputSampleBufferDelegate,UIGestureRecognizerDelegate,TZImagePickerControllerDelegate>
{
	AVCaptureSession *_session;
	AVCaptureVideoPreviewLayer *_layer;
	CGFloat _lastBrightnessValue;
	AVCaptureDevice  *_device;
	CGRect _cropRect;      //可以扫描的位置
	UIView *_scanView;
	UILabel * _titleLable;
	UIView *_focusView;//对焦View
	UIImageView *_bgImgView;
}
//缩放参数
@property(nonatomic,assign)CGFloat currentZoomFactor;
@property(nonatomic,assign)CGFloat maxZoomFactor;
@property(nonatomic,assign)CGFloat minZoomFactor;

@end

@implementation QrScanViewController
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	LightStatusBar;
	[self runQrScan];
}
-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self stopRun];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self initNavView];
	self.lineView.hidden = YES;
	[self initBackNavItem];
	self.navView.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.5];

	self.view.backgroundColor = [UIColor blackColor];
	self.maxZoomFactor = 6.5;
	self.minZoomFactor = 1.0;
	self.currentZoomFactor = 1.0;
	CGFloat scanW = CGRectGetWidth([UIScreen mainScreen].bounds)*3/5.0;
	CGSize scaleSize = (CGSize){
		CGRectGetWidth([UIScreen mainScreen].bounds) - 20*2,
		scanW
	};

	if ([self isPhoneX]) {
		_cropRect = (CGRect){20,44+44 + px_scale(266),scaleSize};
	}else{
		_cropRect = (CGRect){20,20+44 + px_scale(266),scaleSize};
	}

	CGFloat x =  CGRectGetMidX(_cropRect);
	CGFloat y =  CGRectGetMidY(_cropRect);
	ScanView *scanView = [ScanView new];
	scanView.bounds = CGRectMake(0, 0, px_scale(450), px_scale(450));
	scanView.center = (CGPoint){x,y};
	[self.view addSubview:scanView];
	[scanView startScanAnimation]; //开始执行动画
	scanView.rect_color = [UIColor colorWithHexString:@"#FE9B0E"];
	_scanView = scanView;

	[self initScan];
	if (_device) {
		[self addMoreGesture];
	}
	UILabel *titleLable = [UILabel new];
	titleLable.text = @"请扫描活动二维码";
	titleLable.font =[UIFont systemFontOfSize:15];
	[self.view addSubview:titleLable];
	titleLable.textColor = [UIColor whiteColor];
	[titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(scanView.mas_bottom).offset(px_scale(60));
		make.centerX.mas_equalTo(0);
		make.height.mas_equalTo(px_scale(30));
	}];
	UIBarButtonItem *albumItem = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(openAlbum:)];
	albumItem.tintColor = [UIColor whiteColor];
	self.navigationItem.rightBarButtonItem = albumItem;

}

- (void)initScan {
	BOOL canScan = [self requestAuth];
	if (!canScan) {
		return;
	}
		//获取摄像设备
	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	_device = device;
	if ([device lockForConfiguration:nil]) {
			//使用自动对焦
		if ([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
			[device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
		}
			//自动曝光
		if ([device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
			[device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
		}
		[device unlockForConfiguration];
	}

		//创建输入流
	AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
		//创建输出流
	AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];

		//设置代理 在主线程里刷新
	[output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

		//设置光感代理输出
	AVCaptureVideoDataOutput *respondOutput = [[AVCaptureVideoDataOutput alloc] init];
	[respondOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
		//初始化链接对象
	if (_session) {
		[_session stopRunning];
	}
	_session = [[AVCaptureSession alloc] init];
		//设置扫描有效区域
	CGSize size = self.view.bounds.size;
	CGRect cropRect = _cropRect;
	CGFloat point_w = 1920.;
	CGFloat point_h = 1080.;
		//高质量采集率
	if (@available(iOS 9.0,*)) {
			//使用超大输出来满足极小二维码 扫描 ==========
		if ([_session canSetSessionPreset:AVCaptureSessionPreset1920x1080]) {
			[_session setSessionPreset:AVCaptureSessionPreset1920x1080];
			point_w = 1920.;
			point_h = 1080.;
		}else{
			if ([_session canSetSessionPreset:AVCaptureSessionPreset1920x1080]) {
				[_session setSessionPreset:AVCaptureSessionPreset1920x1080];
			}else{
				if ([_session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
					[_session setSessionPreset:AVCaptureSessionPreset1280x720];
					point_w = 1280.;
					point_h = 720.;
				}else if ([_session canSetSessionPreset:AVCaptureSessionPreset640x480]){
					[_session setSessionPreset:AVCaptureSessionPreset640x480];
					point_w = 640.;
					point_h = 480.;
				}
			}
		}
	}else{
		if ([_session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
			[_session setSessionPreset:AVCaptureSessionPreset1280x720];
			point_w = 1280.;
			point_h = 720.;
		}else if ([_session canSetSessionPreset:AVCaptureSessionPreset640x480]){
			[_session setSessionPreset:AVCaptureSessionPreset640x480];
			point_w = 640.;
			point_h = 480.;
		}
	}

		//https://blog.cnbluebox.com/blog/2014/08/26/ioser-wei-ma-sao-miao/

	CGFloat p1 = size.height/size.width;
	CGFloat p2 = point_w/point_h;  //使用了 1080p \ 2160p 的图像输出
	if (p1 < p2) {
		CGFloat fixHeight = size.width * point_w / point_h;
		CGFloat fixPadding = (fixHeight - size.height)/2;
		output.rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,
										   cropRect.origin.x/size.width,
										   cropRect.size.height/fixHeight,
										   cropRect.size.width/size.width);
	} else {
		CGFloat fixWidth = size.height * point_h / point_w;
		CGFloat fixPadding = (fixWidth - size.width)/2;
		output.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
										   (cropRect.origin.x + fixPadding)/fixWidth,
										   cropRect.size.height/size.height,
										   cropRect.size.width/fixWidth);
	}

	if ([_session canAddInput:input]) [_session addInput:input];
	if ([_session canAddOutput:output]) [_session addOutput:output];
	if ([_session canAddOutput:respondOutput]) [_session addOutput:respondOutput];
	[_session commitConfiguration];

		//设置扫码支持的编码格式
	output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code];

	_layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
	_layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	_layer.frame = self.view.frame;
	[self.view.layer insertSublayer:_layer atIndex:0];

		// ================ 使用黑色区域 ================
	UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointZero];
	[path addLineToPoint:_scanView.frame.origin];
	[path addLineToPoint:CGPointMake(CGRectGetMaxX(_scanView.frame), _scanView.frame.origin.y)];
	[path addLineToPoint:CGPointMake(CGRectGetMaxX(_scanView.frame), CGRectGetMaxY(_scanView.frame))];
	[path addLineToPoint:CGPointMake(_scanView.frame.origin.x, CGRectGetMaxY(_scanView.frame))];
	[path addLineToPoint:_scanView.frame.origin];
	[path addLineToPoint:CGPointZero];
	[path addLineToPoint:CGPointMake(0, CGRectGetHeight(self.view.frame))];
	[path addLineToPoint:CGPointMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
	[path addLineToPoint:CGPointMake(CGRectGetWidth(self.view.frame), 0)];
	[path addLineToPoint:CGPointZero];
	[path closePath];
	CAShapeLayer *rectLayer = [CAShapeLayer layer];
	rectLayer.path = path.CGPath;
	rectLayer.fillColor = [[UIColor blackColor]colorWithAlphaComponent:0.4].CGColor;
	[_layer addSublayer:rectLayer];
}
-(void)openAlbum:(id)sender
{
	[self openPhotoLibary];
}
-(void)openPhotoLibary
{
	TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1  delegate:self];
	imagePickerVc.allowTakePicture = NO;
	imagePickerVc.naviBgColor = [UIColor whiteColor];
	imagePickerVc.naviTitleColor = [UIColor blackColor];
	imagePickerVc.needShowStatusBar = YES;
	imagePickerVc.barItemTextColor = [UIColor blackColor];
	imagePickerVc.allowPickingOriginalPhoto = NO;
	imagePickerVc.allowPickingVideo = NO;
	imagePickerVc.allowCrop = NO;
	imagePickerVc.allowPreview = YES;
	[self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)scanResultWithStringValue:(NSString *)response
{
//	if ([response containsString:@"520wtp.com"]) {
		NSURL *url =  [NSURL URLWithString:response];
		NSDictionary *dic =  url.parameter;
		NSString *sid = dic[@"v"];
		if (sid) {
			UIViewController *voteVc = [[NSClassFromString(@"MainVoteViewController") alloc]init];
			if (voteVc) {
				[voteVc setValue:sid forKey:@"voteId"];
				[self.navigationController pushViewController:voteVc animated:YES];
			}
		}else{
            SHOW_MSG(@"识别失败，请检查是否为正确的活动二维码", 1.0);
            //GCD延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self runQrScan];
            });
            
		}
//	}else{
//		SHOW_MSG(@"请扫描活动二维码", 1.0);
//		[self runQrScan];
//	}
	NSLog(@"输出结果:|%@",response);
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
	UIImage *image = photos.firstObject;
	if (image) {
		__weak typeof(self)ws = self;
		[self scanQrImage:image andCompletion:^(id responder) {
			if (responder) {
				[ws scanResultWithStringValue:responder];
			}else{
				SHOW_MSG(@"未检测到二维码", 0.5);
				[ws runQrScan];
			}
		}];
	}
}
-(void)runQrScan
{
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
			// 处理耗时操作的代码块...
		[self->_session startRunning];
	});
}
-(void)stopRun
{
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
			// 处理耗时操作的代码块...
		[self->_session stopRunning];
	});
}
#pragma mark - scan request auth
- (BOOL)requestAuth {
	AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
	if (status == AVAuthorizationStatusDenied) {
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请在设置->隐私中允许该软件访问摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
		__weak typeof(self)ws = self;
		UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
			[ws openSystemSetting];
		}];
		[alert addAction:action];
		[self presentViewController:alert animated:YES completion:nil];
		return NO;
	}
	if (status == AVAuthorizationStatusRestricted) {
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"设备不支持" preferredStyle:(UIAlertControllerStyleAlert)];
		UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
		}];
		[alert addAction:action];
		[self presentViewController:alert animated:YES completion:nil];
		return NO;
	}
	if (![UIImagePickerController isSourceTypeAvailable:
		  UIImagePickerControllerSourceTypeCamera]) {
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"模拟器不支持该功能" preferredStyle:(UIAlertControllerStyleAlert)];
		UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
		}];
		[alert addAction:action];
		[self presentViewController:alert animated:YES completion:nil];
		return NO;
	}
	return YES;
}
#pragma mark —————— 跳转设置 ——————
-(void)openSystemSetting {
	if (@available(iOS 10.0,*)) {
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
		}];
	}else{
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
	}
}
	//添加缩放手势&双击手势
-(void)addMoreGesture {
	UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(zoomChangePinchGestureRecognizerClick:)];
	pinch.delegate = self;
	[self.view addGestureRecognizer:pinch];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scaleTapAction:)];
	tap.numberOfTapsRequired = 2;
	[self.view addGestureRecognizer:tap];
}
	//双击手势 ---------- 缩放到最大或最小
-(void)scaleTapAction:(UITapGestureRecognizer *)tap {
	/**
	 图像的视觉线性缩放
	 rampToVideoZoomFactor:(CGFloat)factor withRate:(float)rate
	 factor 缩放的大小
	 rate 缩放的速率
	 [_device  rampToVideoZoomFactor:4.0 withRate:8];
	 */
	if (tap.state == UIGestureRecognizerStateEnded) {
		if (!_session.isRunning) return;
		NSError *error = nil;
		if ([_device lockForConfiguration:&error] ) {
			if (_device.videoZoomFactor < self.maxZoomFactor) {
				[_device  rampToVideoZoomFactor:self.maxZoomFactor withRate:8];
			}else{
				[_device  rampToVideoZoomFactor:self.minZoomFactor withRate:8];
			}
			[_device unlockForConfiguration];
		}
	}
}
	//捏合之前记录当前焦距 -------- 视频缩放因子
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
	if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]){
		self.currentZoomFactor = _device.videoZoomFactor;
	}
	return YES;
}
	//捏合手势 缩放焦距-- 视频缩放因子
- (void)zoomChangePinchGestureRecognizerClick:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
	if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan ||
		pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
		if (!_session.isRunning) return;
		CGFloat currentZoomFactor = self.currentZoomFactor*pinchGestureRecognizer.scale;
		if (currentZoomFactor < self.maxZoomFactor &&
			currentZoomFactor > self.minZoomFactor){
			NSError *error = nil;
			if ([_device lockForConfiguration:&error] ) {
				_device.videoZoomFactor = currentZoomFactor;
				[_device unlockForConfiguration];
			}
			else {
				NSLog( @"Could not lock device for configuration: %@", error );
			}
		}
	}
}
	//感光元件进行输出 ------------------------ 光线强度代理
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {

	CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
	NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
	CFRelease(metadataDict);
	NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
		// 该值在 -5~12 之间
	float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
	_lastBrightnessValue = brightnessValue;
}
	//扫描结果出现 ============
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
	if (metadataObjects.count > 0) {
		[_session stopRunning];
		AVMetadataMachineReadableCodeObject *metaDataObject = [metadataObjects objectAtIndex:0];
		for (AVMetadataMachineReadableCodeObject * metaData in metadataObjects) {
			if ([metaData.stringValue hasPrefix:@"v="]) {
				metaDataObject = metaData;
				break;
			}
		}
		if (![metaDataObject.stringValue hasPrefix:@"v="]) {
			for (AVMetadataMachineReadableCodeObject * metaData in metadataObjects) {
				if ([metaData.stringValue hasPrefix:@"http"]) {
					metaDataObject = metaData;
					break;
				}
			}
		}
		NSString *stringValue = metaDataObject.stringValue;
		//结果 ===========
		[self playSound];
		[self scanResultWithStringValue:stringValue];
	}
}
#pragma mark —————— 播放 ——————— 嘀声
-(void)playSound {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	NSString *path = [[NSBundle mainBundle ] pathForResource:@"sucessVoce" ofType:@"mp3"];
	if (!path) return;
	SystemSoundID soundID;
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
		// 添加有结果的声音
	AudioServicesPlaySystemSound (soundID);
}

-(void)scanQrImage:(UIImage *)image
	 andCompletion:(void(^)(id responder))completion {
	image = [self imageByInsetEdge:UIEdgeInsetsMake(-20, -20, -20, -20) withColor:[UIColor lightGrayColor] withImage:image];

	dispatch_async(dispatch_get_global_queue(0, 0), ^{
			// 处理耗时操作的代码块...
		[self->_session stopRunning];
		CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{}];
		NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
			//通知主线程刷新
		dispatch_async(dispatch_get_main_queue(), ^{
				//回调或者说是通知主线程刷新，
			if (features.count >= 1) {
				CIQRCodeFeature *feature = [features objectAtIndex:0];
				NSString *msg = feature.messageString;
					//扫描二维码
				if (completion) {
					completion(msg);
				}
			}else{
				if (completion) {
					completion(nil);
				}
			}
		});
	});
}

- (UIImage *)imageByInsetEdge:(UIEdgeInsets)insets withColor:(UIColor *)color withImage:(UIImage *)image
{
	CGSize size = image.size;
	size.width -= insets.left + insets.right;
	size.height -= insets.top + insets.bottom;
	if (size.width <= 0 || size.height <= 0) {
		return nil;
	}
	CGRect rect = CGRectMake(-insets.left, -insets.top, image.size.width, image.size.height);
	UIGraphicsBeginImageContextWithOptions(size, NO, image.scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	if (color) {
		CGContextSetFillColorWithColor(context, color.CGColor);
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
		CGPathAddRect(path, NULL, rect);
		CGContextAddPath(context, path);
		CGContextEOFillPath(context);
		CGPathRelease(path);
	}
	[image drawInRect:rect];
	UIImage *insetEdgedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return insetEdgedImage;
}



-(void)initBackNavItem
{
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[[UIImage imageNamed:@"all_fahuia_btn"] imageWithColor:[UIColor whiteColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(backClicked:)];
	self.navigationItem.leftBarButtonItem = backItem;
}

- (BOOL)isPhoneX {
	BOOL iPhoneX = NO;
	if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
			//判断是否是手机
		return iPhoneX;
	}
	if (@available(iOS 11.0, *)) {
		UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
		if (mainWindow.safeAreaInsets.bottom > 0.0) {
			iPhoneX = YES;
		}
	}
	return iPhoneX;
}
#pragma mark 读取Url中的参数
-(NSDictionary *) parameterWithURL:(NSURL *) url {

	NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
		//传入url创建url组件类
	NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
		//回调遍历所有参数，添加入字典
	[urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[parm setObject:obj.value forKey:obj.name];
	}];
	return parm;
}
-(void)backClicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
