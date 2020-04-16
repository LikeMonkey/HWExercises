//
//  text.h
//  giftDemo
//
//  Created by ios 001 on 2019/10/11.
//  Copyright © 2019 flymanshow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic) NSUInteger itemCountPerRow;
// 一页显示多少行
@property (nonatomic) NSUInteger rowCount;
@property (strong, nonatomic) NSMutableArray *allAttributes;

@end
