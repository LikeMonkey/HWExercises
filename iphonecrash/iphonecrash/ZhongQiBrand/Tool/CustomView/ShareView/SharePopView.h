//
//  SharePopView.h
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/24.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ShareInfoModel;

typedef enum : NSUInteger {
    WXShareType = 1,
    WXCircleShareType = 2,
    QQShareType = 3,
    QQZoneType = 4,
} ShareType;
  
@interface SharePopView : UIView
{
    UIView *_shareV;
}
//是否关闭当前页面
@property(nonatomic,assign)BOOL isNotClose;

@property (nonatomic,copy)void(^shareAction)(ShareType type,_Nullable id shareImge);
//获取分享页面
+(instancetype)showShare;
@end

@interface ShareInfoModel: NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *sharename;
@end

NS_ASSUME_NONNULL_END
