//
//  PointImageView.h
//  VoteCloud
//
//  Created by ios2 on 2019/8/20.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^LoadTextCompletion)(NSString *text,BOOL isSucess);  //加载输入文字回执

typedef void(^YZCompletion)(BOOL isSucess,NSString *json);   //对验证结果进行回传


@interface PointImageView : UIImageView

//设置图片地址
@property (nonatomic,strong)NSString *url;
//加载中View 转子 菊花 ~
@property (nonatomic,strong)UIActivityIndicatorView *animationView;

//选项 id
@property (nonatomic,strong)NSString *itemId;
//验证类型
@property (nonatomic,strong)NSString *type;
//随机数字
@property (nonatomic,strong)NSString *rnd;

//加载成功的图片的宽度 --- 按照实际图片的像素写
@property(nonatomic,assign)CGFloat sucessImageWidth;

//通过外部传入图片地址进行加载
@property (nonatomic,copy)NSString * (^thumbUrlBlock)(NSString *rand);

//验证成功以后回调
@property (nonatomic,copy)void(^sucessCompletion)(NSString *rand,NSString *itemId,NSString *json);

//修改外部图片加载
/** 修改随机数字请求文字*/
@property (nonatomic,copy)void(^changeTextRequest)(NSString *rand,LoadTextCompletion completion);

//请求验证
/**
pontJson  点的json 字符串
rand        生成的随机数
 completion 验证结果的回调
 */
@property (nonatomic,copy)void(^requestYZPoint)(NSString *pontJson,NSString *rand,YZCompletion completion);

//内部调用dismiss
@property (nonatomic,copy)void(^dismissBlock)(void);

//刷新数据
-(void)refresh;
//强制刷新
-(void)reload;

@end

