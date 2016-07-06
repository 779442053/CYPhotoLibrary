//
//  CYCollectionViewCell.m
//  CYPhotoKit
//
//  Created by dongzb on 16/3/20.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import "CYCollectionViewCell.h"

@implementation CYCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        self.imageView.contentMode   = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        
    }
    return self;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
    
}
@end
