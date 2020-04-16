//
//  PlayerView.h
//  VoteCloud
//
//  Created by ios2 on 2019/7/31.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicPlayManager.h"
@interface PlayerView : UIView

@property(nonatomic,strong)MusicPlayManager * playManager;

@property (nonatomic,strong)NSString *playUrl; //播放地址

@property (nonatomic,strong)NSString *runThumb; //运行的图片地址

@property (nonatomic,strong)NSString *pasueThumb; //暂停的图片地址


@property(nonatomic,assign)BOOL isRun;

@end

