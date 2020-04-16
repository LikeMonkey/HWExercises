//
//  UITableView+LgCategory.m
//  PPWBrand
//
//  Created by ios2 on 2019/6/14.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import "UITableView+LgCategory.h"

static char lg_data_key = '\0';
static char lg_page_key = '\0';
@implementation UITableView (LgCategory)

-(void)setLg_data:(NSMutableArray *)lg_data {
	[self willChangeValueForKey:@"lg_data"];
	objc_setAssociatedObject(self, &lg_data_key, lg_data, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	[self didChangeValueForKey:@"lg_data"];
}

-(NSMutableArray *)lg_data {
	NSMutableArray *temArray = objc_getAssociatedObject(self, &lg_data_key);
	if (!temArray) {
		temArray = [NSMutableArray array];
		self.lg_data = temArray;
	}
	return objc_getAssociatedObject(self, &lg_data_key);
}

-(void)setLg_page:(NSInteger)lg_page {
	[self willChangeValueForKey:@"lg_page"];
	objc_setAssociatedObject(self, &lg_page_key, @(lg_page), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	[self didChangeValueForKey:@"lg_page"];
}
-(NSInteger)lg_page {
	NSNumber *num = objc_getAssociatedObject(self, &lg_page_key);
	if (!num) {
		self.lg_page = 1;
		return 1;
	}
	return [num integerValue];
}

@end
