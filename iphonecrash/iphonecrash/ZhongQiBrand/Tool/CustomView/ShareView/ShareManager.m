//
//  ShareManager.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "ShareManager.h"
@implementation ShareManager
+(void)shareWithType:(UMSocialPlatformType)platformType andImage:(id)image
	   andShareTitle:(NSString *)shareTitle
		 andShareUrl:(NSString *)shareUrl
		andShareDesc:(NSString *)shareDesc
	   andCompletion:(void(^)(BOOL isSuccess))completion
{
    
	UMShareWebpageObject *shareObject_web = [UMShareWebpageObject shareObjectWithTitle:shareTitle  descr: shareDesc thumImage:image];
		//设置网页地址
	shareObject_web.webpageUrl = shareUrl;
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
		//分享消息对象设置分享内容对象
	messageObject.shareObject = shareObject_web;
	[[UMSocialManager defaultManager] shareToPlatform:platformType
										messageObject:messageObject
								currentViewController:nil completion:^(id result, NSError *error) {
									if (!error) {
										!completion?:completion(NO);
									}else{
										!completion?:completion(YES);
									}
	}];


}
@end
