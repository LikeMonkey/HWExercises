//
//  UploadCertificateCell.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadCertificateCell : UITableViewCell

//字典赋值
@property (nonatomic,strong)NSDictionary *thumbsDic;

//点击相机
@property (nonatomic,copy)void(^didClickedCameraItem)(NSInteger index,id sender);

//点击删除
@property (nonatomic,copy)void(^deleteClickedCameraItem)(NSInteger index,id sender);

@end

NS_ASSUME_NONNULL_END
