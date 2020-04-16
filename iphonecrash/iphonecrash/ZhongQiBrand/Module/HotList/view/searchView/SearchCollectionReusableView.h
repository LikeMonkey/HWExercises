//
//  SearchCollectionReusableView.h
//  PPWBrand
//
//  Created by ios2 on 2019/4/24.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIButton *clearBtn;

@property (nonatomic,copy)void(^clearHistory)(void);


@end
