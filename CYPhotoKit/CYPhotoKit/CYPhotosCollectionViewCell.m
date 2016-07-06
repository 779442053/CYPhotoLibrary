//
//  CYPhotosCollectionViewCell.m
//  CYPhotoKit
//
//  Created by 董招兵 on 16/7/6.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import "CYPhotosCollectionViewCell.h"

@interface CYPhotosCollectionViewCell ()
@property (nonatomic,strong) UIView *coverView;
@property (nonatomic,strong) UIButton *selectButton;
@end

@implementation CYPhotosCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imageView.contentMode   = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.backgroundColor         = [UIColor whiteColor];

    [self.contentView addSubview:self.coverView];
    [self.coverView addSubview:self.selectButton];
    
    
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView                 = [[UIView alloc] init];
        _coverView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.30f];
    }
    return _coverView;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton                        = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"AssetsPickerChecked"] forState:UIControlStateNormal];
        _selectButton.userInteractionEnabled = NO;
    }
    return _selectButton;
}

- (void)setPhotosAsset:(PHAsset *)photosAsset {
    _photosAsset    = photosAsset;
   
    __weak typeof(self)weakSelf = self;
    
    [self.imageManager requestImageForAsset:_photosAsset
                                 targetSize:CGSizeMake(150.0f, 150.0f)
                                contentMode:PHImageContentModeDefault
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  __strong typeof(weakSelf)strongSelf = weakSelf;
                                  strongSelf.imageView.image = result;
                              }];
    
    
}

- (void)setSelectItem:(BOOL)selectItem {
    _selectItem           = selectItem;
    
    self.coverView.hidden = !_selectItem;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.coverView.frame    = self.contentView.bounds;
    self.selectButton.frame = CGRectMake(self.contentView.frame.size.width-30.0f, self.contentView.frame.size.height-30.0f, 25.0f, 25.0f);
    
}

- (void)dealloc {
    
//    NSLog(@"-- %s ---",__func__);

    
}
@end
