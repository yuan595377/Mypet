//
//  CollectionReusableViewOfHJOfHeader.m
//  Program
//
//  Created by Jasmine on 16/5/19.
//  Copyright © 2016年 XuRui. All rights reserved.
//

#import "CollectionReusableViewOfHJOfHeader.h"

@implementation CollectionReusableViewOfHJOfHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}
- (void)config
{
    self.labelOfTittle = [[UILabel alloc]init];
    [self addSubview:_labelOfTittle];
    self.labelOfType = [[UILabel alloc]init];
    [self addSubview:_labelOfType];
    self.labelOfNumber = [[UILabel alloc]init];
    [self addSubview:_labelOfNumber];
    _labelOfNumber.textColor = [UIColor whiteColor];
    _labelOfType.textColor = [UIColor whiteColor];
    _labelOfTittle.textColor = [UIColor whiteColor];
    _labelOfTittle.font = [UIFont systemFontOfSize:17];
    _labelOfNumber.font = [UIFont systemFontOfSize:16];
    _labelOfType.font = [UIFont systemFontOfSize:16];
    self.imageView = [[UIImageView alloc]init];
    [self addSubview:_imageView];
    
    
    
}
- (void)layoutSubviews
{
    self.labelOfTittle.frame = CGRectMake(10 * SCALEWIDTH, 20 * SCALEHEIGHT, 150 * SCALEWIDTH, 25 * SCALEHEIGHT);
    self.labelOfType.frame = CGRectMake(10 * SCALEWIDTH, 43 * SCALEHEIGHT, 150 * SCALEWIDTH, 25 * SCALEHEIGHT);
    self.labelOfNumber.frame = CGRectMake(10 * SCALEWIDTH, 64 * SCALEHEIGHT, 150 * SCALEWIDTH, 25 * SCALEHEIGHT);
    self.imageView.frame = CGRectMake(360 * SCALEWIDTH, 35 * SCALEHEIGHT, 40 * SCALEWIDTH, 40 * SCALEHEIGHT);
}

@end
