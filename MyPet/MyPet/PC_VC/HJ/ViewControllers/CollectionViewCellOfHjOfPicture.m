//
//  CollectionViewCellOfHjOfPicture.m
//  Program
//
//  Created by Jasmine on 16/5/19.
//  Copyright © 2016年 XuRui. All rights reserved.
//

#import "CollectionViewCellOfHjOfPicture.h"

@implementation CollectionViewCellOfHjOfPicture
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config{
    
    self.imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_imageView];
    self.imageViewOfSelected = [[UIImageView alloc]init];
    [self.contentView addSubview:_imageViewOfSelected];
    self.labelOfSelected = [[UILabel alloc]init];
    [self.contentView addSubview:_labelOfSelected];
    _labelOfSelected.textColor = [UIColor whiteColor];
    _labelOfSelected.textAlignment = YES;
    _labelOfSelected.font = [UIFont systemFontOfSize:15];
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    
    [super applyLayoutAttributes:layoutAttributes];
    _imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    _imageViewOfSelected.frame = CGRectMake(43, 45, 25, 25);
    _labelOfSelected.frame = CGRectMake(25, 70, 60, 25);
    _imageViewOfSelected.layer.cornerRadius = 12.5;
    _imageViewOfSelected.clipsToBounds = YES;
    
}

@end
