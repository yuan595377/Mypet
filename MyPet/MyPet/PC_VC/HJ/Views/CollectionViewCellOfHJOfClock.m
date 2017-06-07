//
//  CollectionViewCellOfHJOfClock.m
//  Program
//
//  Created by Jasmine on 16/5/21.
//  Copyright © 2016年 XuRui. All rights reserved.
//

#import "CollectionViewCellOfHJOfClock.h"

@implementation CollectionViewCellOfHJOfClock
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self congig];
    }
    return self;
}
- (void)congig{
    self.labelOfWeek = [[UILabel alloc]init];
    [self.contentView addSubview:_labelOfWeek];
    _labelOfWeek.textAlignment = YES;
    _labelOfWeek.textColor = [UIColor whiteColor];
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    _labelOfWeek.frame = self.contentView.bounds;
}
@end
