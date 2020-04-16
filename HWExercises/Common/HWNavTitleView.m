//
//  HWNavTitleView.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/5/22.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "HWNavTitleView.h"

@implementation HWNavTitleView

- (id)initWithString:(NSString *)str frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        label.textColor = KWhiteColor;
        label.text = str;
        label.font = [UIFont boldSystemFontOfSize:18.0f];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    
    return self;
}

@end
