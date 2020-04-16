//
//  BaseShareScreenCell.m
//  VoteCloud
//
//  Created by ios2 on 2019/9/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "BaseShareScreenCell.h"

@implementation BaseShareScreenCell{
	UIButton *_saveBtn;
}

-(instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
	   [self loadBottonButton];
		[self.contentView addSubview:self.bgImageView];
		[self registAutoSaveScreenNotification];
	}
	return self;
}


-(void)registAutoSaveScreenNotification
{
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(autoSaveImageNotification:) name:SaveScreenImageNotificationName object:nil];
}
-(void)autoSaveImageNotification:(NSNotification *)noti
{
	if (!_saveBtn.selected) return;
	if (!_bgImageView)return;
	UIImage *image = [self getImageViewWithView:_bgImageView];
	//存储图片
	UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
}

-(void)loadBottonButton
{
	self.backgroundColor =[UIColor whiteColor];
	self.clipsToBounds = YES;
	self.layer.cornerRadius = px_scale(20);
	NSString *names[] ={@"自动保存",@"保存图片"};
	NSString *imgNames[] = {@"xsxqshare_zdxz_btn_n",@"xsxqshare_bctp_icon"};
	NSString *imgSeletedNames[] = {@"xsxqshare_zdxz_btn_s",@"xsxqshare_bctp_icon"};
	for (int i = 0; i< 2; i++) {
		UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.contentView addSubview:saveBtn];
		if (i==0) {
			_saveBtn = saveBtn;
		}
		saveBtn.tag = 50 + i;
		[saveBtn setImage:[UIImage imageNamed:imgNames[i]] forState:UIControlStateNormal];
		[saveBtn setImage:[UIImage imageNamed:imgSeletedNames[i]] forState:UIControlStateSelected];
		[saveBtn setTitle:names[i] forState:UIControlStateNormal];
		[saveBtn setTitle:names[i] forState:UIControlStateSelected];
		[saveBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
		[saveBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateSelected];
		saveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		saveBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
		saveBtn.titleEdgeInsets = UIEdgeInsetsMake(0, px_scale(23), 0, 0);
		saveBtn.titleLabel.font  = [UIFont systemFontOfSize:14];
		[saveBtn addTarget:self action:@selector(imageActionClicked:) forControlEvents:UIControlEventTouchUpInside];
		[saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
			if (i==0) {
				make.left.mas_equalTo(px_scale(40));
			}else{
				make.right.mas_equalTo(-px_scale(15));
			}
			make.width.mas_equalTo(px_scale(186));
			make.height.mas_equalTo(px_scale(60));
			make.bottom.mas_equalTo(-px_scale(10));
		}];
	}
}
-(void)imageActionClicked:(UIButton *)button
{
	if (button.tag%2==0) {
		button.selected = !button.selected;
	}else{
		UIImage *image = [self getImageViewWithView:self.bgImageView];
		UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
	}
}
#pragma mark 获取截图
- (UIImage *)getImageViewWithView:(UIView *)view {
	CGRect bouds =  CGRectMake(0, 0, CGRectGetWidth(view.bounds)*3, CGRectGetHeight(view.bounds)*3);
	UIGraphicsBeginImageContext(bouds.size);
	[view drawViewHierarchyInRect:bouds afterScreenUpdates:YES];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}
#pragma mark 协议方法
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
	NSString *msg = nil ;
	if(error){
		msg = @"保存图片失败" ;
	}else{
		msg = @"保存图片成功" ;
	}
	SHOW_MSG(msg, 0.5);
}
-(UIImageView *)bgImageView
{
	if (!_bgImageView)
	 {
		_bgImageView = [[UIImageView alloc]init];
	 }
	return _bgImageView;
}

-(void)dealloc
{
	//移除通知监听
	[[NSNotificationCenter defaultCenter]removeObserver:self name:SaveScreenImageNotificationName object:nil];
}

//子类去实现的方法
-(void)configerShareInfo:(id)shareInfo andIndex:(NSInteger )index{}


@end
