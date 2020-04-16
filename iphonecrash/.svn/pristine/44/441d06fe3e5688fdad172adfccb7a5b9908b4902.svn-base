//
//  CommonTools.m
//  AppVersionUpdate
//
//  Created by andson-zhw on 16/7/29.
//  Copyright © 2016年 andson. All rights reserved.
//

#import "CommonTools.h"
#import "PPVersonAleteView.h"

@interface CommonTools ()
{
    NSString *requestUrlStr; //请求地址
    NSData *requestData;    //请求返回的数据
    BOOL isPostRequest;//是否是post请求
    NSString *_appId;   //应用的appid
    NSString *_downUrlStr; //应用更新下载地址
	BOOL _isMust;
}
@end

@implementation CommonTools
//初始化一个单例

+(id)shareInstance{
    static dispatch_once_t once_t;
    static CommonTools *dataBlock;
    dispatch_once(&once_t, ^{
        dataBlock = [[CommonTools alloc] init];
    });
    
    return dataBlock;
}

#pragma mark - 版本更新信息查询
- (void)versionForAppid:(NSString *)appid
			  andIsMast:(BOOL)isMast
				  andBlock:(void(^)(BOOL isHaveVersion,NSString *updateUrl,NSString *updateContent))version
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //https//itunes.apple.com/cn/app/qq/id444934666?mt=8
    //当前应用商店的下载地址
    NSString *appItunesUrlStr =  [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@",appid];
        //@"https://itunes.apple.com/cn/lookup?id=%@" //如果你的app发布区域只在中国 请加/cn 否则返回数据有问题

    NSString *newUrlStr = [appItunesUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    requestUrlStr = newUrlStr;
    requestData = nil;
    isPostRequest = NO;
    
    NSURL *urlS = [NSURL URLWithString:newUrlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlS cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        if (data.length > 0) {
            //有返回数据
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:Nil];
            NSArray *results = [dic objectForKey:@"results"];
            if (results.count == 0) {
                if (version) {
                    version(NO,@"no",@"没有更新");
                }
                return ;
            }
            //appStore 版本
            NSString *newVersion = [[[dic objectForKey:@"results"] objectAtIndex:0]objectForKey:@"version"];
            NSString *updateContent = [[[dic objectForKey:@"results"] objectAtIndex:0]objectForKey:@"releaseNotes"];
            //本地版本
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            //这个拼接的连接必须是你创建应用的连接，需要应用的名称，已经应用的id,https也可以
//            _downUrlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/qq-yin-le-kua-jie-ge-wang/id414603431?mt=8",appid];
            //跳转到应用下载页面（详情页面）
            //itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@
            //itms://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@
            //itms-apps://itunes.apple.com/app/id%@
            //https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@
            
            
            //跳转到评论页面
            //itms-apps://和itms://开头的链接都可以，而此时https:// 开头的链接不可以
            //itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@
            //itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8

			self->_downUrlStr=[NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",appid];
            BOOL isNew = NO;
            if (newVersion && ([newVersion compare:currentVersion] == 1)) {
                isNew = YES;
            }
			if (version) {
				version(isNew,self->_downUrlStr,updateContent);
			}
            if (isNew) {
				self->_isMust = isMast;
				if (isMast) {
					UIWindow *window = [[UIApplication sharedApplication].delegate window];
					[window.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
						if ([obj isKindOfClass:[PPVersonAleteView class]]) {
							[obj removeFromSuperview];
						}
					}];
				PPVersonAleteView *alete = [[PPVersonAleteView alloc]initWithTitle:@"版本更新" message:updateContent delegate:self cancelButtonTitle:nil otherButtonTitles:@"立即更新", nil];
					alete.canDismiss = NO;
				}else{
				 PPVersonAleteView *alete = [[PPVersonAleteView alloc]initWithTitle:@"版本更新" message:updateContent delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"立即更新", nil];
					alete.canDismiss = YES;
				}
            }
        }else{
            //无返回数据
            NSLog(@"data 为空 connectionError %@",connectionError);
            NSString *errInfo = @"网络有问题,请检查网络";
            switch (connectionError.code) {
                case NSURLErrorNotConnectedToInternet:
                    
                    errInfo = @"无网络连接";
                    break;
                case NSURLErrorTimedOut:
                    
                    errInfo = @"网络连接超时";
                    break;
                default:
                    break;
            }
            NSDictionary *failDic = @{@"msg": errInfo};
            NSLog(@"version erro %@",failDic);
        }
    }];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	BOOL isUpDate = NO;
	if (_isMust == NO) {
		isUpDate = (buttonIndex == 0) ? NO:YES;
	}else{
		isUpDate = YES;
	}
	if (isUpDate) {
		BOOL canOpneUrl =   [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:_downUrlStr]];
		if (canOpneUrl) {
			[[UIApplication sharedApplication]openURL:[NSURL URLWithString:_downUrlStr]];
		}else{
			NSLog(@"不能够打开该地址");
		}
	}
}

@end
