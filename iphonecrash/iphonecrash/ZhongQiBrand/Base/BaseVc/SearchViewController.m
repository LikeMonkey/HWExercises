//
//  SearchViewController.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/5.
//  Copyright © 2019 CY. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UISearchBarDelegate>
{
	UIBarButtonItem *_cancelItem;
}

@property (nonatomic,strong)UIView *bgView;
@end

@implementation SearchViewController
-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self.searchBar resignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.searchBar becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self initNavView];
	_searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, -4, MAINScreenWidth-85, 40)];
	[_searchBar becomeFirstResponder];
	self.searchBar.keyboardType = UIKeyboardTypeDefault;
	self.searchBar.translucent  = YES;
	self.searchBar.showsCancelButton = NO;
	self.searchBar.delegate = self;
	self.searchBar.showsScopeBar = NO;
	_searchBar.searchBarStyle = UISearchBarStyleMinimal;
	UIImage *image = [UIImage creactImageWithColor:[UIColor clearColor] andSize:CGSizeMake(MAINScreenWidth, 60)];
		// 设置左边端盖宽度
	NSInteger leftCapWidth = image.size.width * 0.5;
		// 设置上边端盖高度
	NSInteger topCapHeight = image.size.height * 0.7;
	UIImage *newImage = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
	[self.searchBar setSearchFieldBackgroundImage:newImage forState:UIControlStateNormal];

	UIView *bgView =[UIView new];
	self.bgView = bgView;
	bgView.frame = CGRectMake(0, 0, MAINScreenWidth - 85, px_scale(60));
	bgView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
	bgView.layer.masksToBounds = YES;
	bgView.layer.cornerRadius = px_scale(60)/2.0;
	[bgView addSubview:_searchBar];
	UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:bgView];
	self.navigationItem.leftBarButtonItem =leftItem;

	_searchBar.placeholder = self.placeHoder;
	UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(cancelClicked:)];
	_cancelItem = cancelItem;
	[cancelItem setTitlePositionAdjustment:(UIOffsetMake(5, 0)) forBarMetrics:(UIBarMetricsDefault)];
	cancelItem.tintColor = [UIColor colorWithHexString:@"#18181A"];
	[self.navigationItem setRightBarButtonItem:cancelItem animated:YES];
	@try {
		UITextField*searchField = [_searchBar valueForKey:@"_searchField"];
		searchField.font = [UIFont systemFontOfSize:14];
		searchField.tintColor = ThemeColor;
		searchField.textColor= [UIColor colorWithHexString:@"#333333"];
		[searchField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
	} @catch (NSException *exception) {
		NSLog(@"不支持");
	}
	self.view.lgPlaceholder.state = LgPlaceNormalState;
	self.view.lgPlaceholder.backgroundColor = [UIColor whiteColor];
	[_searchBar becomeFirstResponder];
}

-(void)setPlaceHoder:(NSString *)placeHoder
{
	_placeHoder = placeHoder;
	_searchBar.placeholder = placeHoder;
}

-(void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
}
-(void)cancelClicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if ([[searchBar.textInputMode primaryLanguage] isEqualToString:@"emoji"]||
		![[searchBar textInputMode] primaryLanguage]) {
		return NO;
	}
	return YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
	if (searchBar.text.length <=0) {
		[self didClearSearchText];
	}
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	searchBar.text = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *searchText = searchBar.text;
	searchBar.text = [searchText disable_emoji];
	[self searchWithText:_searchBar];
}

-(void)searchWithText:(UISearchBar *)searchBar{}
-(void)didClearSearchText{}

@end
