//
//  SearchCollectionReusableView.m
//  PPWBrand
//
//  Created by ios2 on 2019/4/24.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import "SearchCollectionReusableView.h"

@implementation SearchCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)clearClicked:(id)sender {
	if (self.clearHistory) {
		self.clearHistory();
	}
}

@end
