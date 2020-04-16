//
//  LgPlaceHodlderView.h
//  ScrollPage
//
//  Created by ios2 on 2019/4/8.
//  Copyright © 2019 LenSky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LgPlaceholderState) {
	LgPlaceNormalState    =   0, //正常状态
	LgPlaceNonetState       =  1, //没有网络状态     //没有
	LgPlaceNoDataState     =  2,//没有数据状态     //有
	LgPlaceLoadingState     =  3, //加载中状态       //没有
	LgPlaceNoMsgState       = 4, //没有消息状态
	LgPlaceNoSearchState    = 5,  // 搜索无结果    // 没有按钮
	LgPlaceSearchSoFastState    = 6  // 搜索太快无结果
};

@interface LgPlaceHodlderView : UIView
{
	//当前占位图加载到的父视图
	__weak UIView * _bg_View;
	//点击的手势
	UITapGestureRecognizer *_tap;
}
//单独设置
@property(nonatomic,assign)CGFloat top;
@property(nonatomic,assign)CGFloat left;
@property(nonatomic,assign)CGFloat right;
@property(nonatomic,assign)CGFloat bottom;

//占位的位置
@property(nonatomic,assign)UIEdgeInsets placeEdgeInsets;
//在中心
@property(nonatomic,assign)BOOL isCenter;
//状态码 
@property(nonatomic,assign)LgPlaceholderState state;

//使用的回调
@property (nonatomic,copy)void(^actionBlock)(LgPlaceholderState state);

@property (nonatomic,strong)NSMutableDictionary *customDictionary;

//创建的时候调用
-(void)pearance;


@end

