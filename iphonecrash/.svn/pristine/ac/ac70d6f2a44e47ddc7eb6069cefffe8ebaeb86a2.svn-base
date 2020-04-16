//
//  JoinActivityHeaderView.m
//  ZhongQiBrand
//
//  Created by iOS002 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinActivityHeaderView.h"
#import "JoinActivityItemView.h"
@interface JoinActivityHeaderView()
@property (nonatomic, strong) NSArray *authImageArray;
@property (nonatomic, strong) NSArray *brandImageArray;
@property (nonatomic, strong) NSArray *waitImageArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *childViewArray;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation JoinActivityHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layoutJoinActivityHeaderView];
    }
    return self;
}
#pragma mark - 布局
- (void)layoutJoinActivityHeaderView
{
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(10));
    }];
    
    CGFloat width = px_scale(200);
    CGFloat space = (MAINScreenWidth - width * self.titleArray.count)/2.0;
    for (int i = 0; i < self.titleArray.count; i++) {
        JoinActivityItemView *itemView = [[JoinActivityItemView alloc] init];
        [self addSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(10);
            make.left.mas_equalTo(self.mas_left).offset((width + space)*i);
            make.width.equalTo(@(width));
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
        [self.childViewArray addObject:itemView];
    }
    
    
    [self drawDottedLineWithLineX:px_scale(172)];
    [self drawDottedLineWithLineX:(MAINScreenWidth/2.0 + px_scale(50) + px_scale(22))];
}


// 绘制虚线
-(void)drawDottedLineWithLineX:(CGFloat)lineX{
    CAShapeLayer *dotteShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef dotteShapePath =  CGPathCreateMutable();
    //设置虚线颜色为blackColor
    [dotteShapeLayer setStrokeColor:[[UIColor colorWithHexString:@"#F8D2D2"] CGColor]];
    //设置虚线宽度
    dotteShapeLayer.lineWidth = 1.0f ;
    NSArray *dotteShapeArr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:3],[NSNumber numberWithInt:3], nil];
    [dotteShapeLayer setLineDashPattern:dotteShapeArr];
    CGPathMoveToPoint(dotteShapePath, NULL, lineX ,px_scale(120));
    CGPathAddLineToPoint(dotteShapePath, NULL, px_scale(130)+lineX, px_scale(120));
    [dotteShapeLayer setPath:dotteShapePath];
    CGPathRelease(dotteShapePath);
    //把绘制好的虚线添加上来
    [self.layer addSublayer:dotteShapeLayer];
}


#pragma mark - setter 方法
- (void)setProcessType:(JoinActivityProcessType)processType
{
    _processType = processType;
    NSArray *ImageArray;
    NSArray *titleColorArray;
    switch (processType) {
        case JoinActivityProcessTypeAuthentication:
        {
            ImageArray = self.authImageArray;
            titleColorArray = @[@"#333333",@"#666666",@"#666666"];
        }
            break;
        case JoinActivityProcessTypeBrandInfo:
        {
            ImageArray = self.brandImageArray;
            titleColorArray = @[@"#333333",@"#333333",@"#666666"];
        }
            break;
        case JoinActivityProcessTypeWaitExamine:
        {
            ImageArray = self.waitImageArray;
            titleColorArray = @[@"#333333",@"#333333",@"#333333"];
        }
            break;
        default:
            break;
    }
    
    [self reloadItemViewWithImageArray:ImageArray withTitleColorArray:titleColorArray];
}

- (void)reloadItemViewWithImageArray:(NSArray *)imageArray withTitleColorArray:(NSArray *)titleColor
{
    for (int i = 0; i<self.childViewArray.count; i++) {
        JoinActivityItemView *itemView = self.childViewArray[i];
        [itemView setDataWithTitle:self.titleArray[i] WithImageStr:imageArray[i] WithTitleColorStr:titleColor[i]];
    }
}

#pragma mark - getter 方法

- (NSMutableArray *)childViewArray
{
    if (!_childViewArray) {
        _childViewArray = [NSMutableArray array];
    }
    return _childViewArray;
}
- (NSArray *)authImageArray
{
    if (!_authImageArray) {
        _authImageArray = @[@"cjhd_qyzz_icon",@"cjhd_paxx_img",@"cjhd_ddsh_img"];
    }
    return _authImageArray;
}

- (NSArray *)brandImageArray
{
    if (!_brandImageArray) {
        _brandImageArray = @[@"cjhd_qyzz_icon",@"cjhd_paxx_icon",@"cjhd_ddsh_img"];
    }
    return _brandImageArray;
}

- (NSArray *)waitImageArray
{
    if (!_waitImageArray) {
        _waitImageArray = @[@"cjhd_qyzz_icon",@"cjhd_paxx_icon",@"cjhd_ddsh_icon"];
    }
    return _waitImageArray;
}

-(NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"企业资质",@"品牌信息",@"等待审核"];
    }
    return _titleArray;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    }
    return _lineView;
}

@end
