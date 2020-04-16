//
//  FeedBackPictureCell.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "FeedBackPictureCell.h"
#import "UploadPicturesItemCell.h"

@interface FeedBackPictureCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *myCollectionView;

@end
@implementation FeedBackPictureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"上传图片";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15 * scaleX);
    }];
    
    UIImageView *signImg = [[UIImageView alloc]init];
    signImg.contentMode = UIViewContentModeScaleAspectFit;
    signImg.image = [UIImage imageNamed:@"xinghao_icon"];
    [self.contentView addSubview:signImg];
    [signImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(10.5 * scaleX);
        make.width.mas_equalTo(7.5 * scaleX);
        make.height.mas_equalTo(21 * scaleX);
        make.centerY.equalTo(titleLabel.mas_centerY).offset(2 * scaleX);
    }];
    
    [self.contentView addSubview:self.myCollectionView];
    [self.myCollectionView registerClass:[UploadPicturesItemCell class] forCellWithReuseIdentifier:@"UploadPicturesItemCell"];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(titleLabel.mas_bottom).offset(15 * scaleX);
        make.height.mas_equalTo(105 * scaleX);
    }];
    
    UILabel *descripLabel = [[UILabel alloc]init];
    descripLabel.text = @"(上传可以为JPG、PNG、GIF格式，大小控制在5M以内）";
    descripLabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    descripLabel.textAlignment = NSTextAlignmentLeft;
    descripLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:descripLabel];
    [descripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 * scaleX);
        make.top.equalTo(self.myCollectionView.mas_bottom).offset(15 * scaleX);
        make.height.mas_equalTo(17 * scaleX);
        make.bottom.mas_equalTo(-27.5 * scaleX);
    }];
    
    UIView *spaceView = [UIView new];
    spaceView.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    [self.contentView addSubview:spaceView];
    [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(9.5 * scaleX);
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UploadPicturesItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UploadPicturesItemCell" forIndexPath:indexPath];
   
    
    __weak typeof(self)ws = self;
    [cell setDeleteImageBlock:^(id sender) {
        [ws deleteImageWithCell:sender];
    }];
    
    if (self.thumbsDic) {
        NSString *key = [@(indexPath.row) stringValue];
        cell.cerImage = self.thumbsDic[key];
    }else{
        cell.cerImage = nil;
    }
    
    return cell;
}

-(void)deleteImageWithCell:(UICollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self.myCollectionView indexPathForCell:cell];
    !_deleteClickedCameraItem?:_deleteClickedCameraItem(indexPath.row,cell);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    !_didClickedCameraItem?:_didClickedCameraItem(indexPath.row,self); //回调打开相机
}

-(UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, px_scale(30),0, px_scale(30));
        flowLayout.itemSize = CGSizeMake(105 * scaleX, 105 * scaleX);
        flowLayout.minimumInteritemSpacing = CGFLOAT_MIN;
        flowLayout.minimumLineSpacing = 15 * scaleX;
        
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        _myCollectionView.showsVerticalScrollIndicator = NO;
        _myCollectionView.showsHorizontalScrollIndicator = NO;
        _myCollectionView.scrollEnabled = NO;
    }
    return _myCollectionView;
}

-(void)setThumbsDic:(NSDictionary *)thumbsDic
{
    _thumbsDic = thumbsDic;
    [self.myCollectionView reloadData];
}
@end
