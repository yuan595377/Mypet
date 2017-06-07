//
//  TableViewCellOfHJClock.m
//  Program
//
//  Created by Jasmine on 16/5/22.
//  Copyright © 2016年 XuRui. All rights reserved.
//

#import "TableViewCellOfHJClock.h"

@implementation TableViewCellOfHJClock
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config
{
    self.viewOfBack = [[UIView alloc]init];
    [self.contentView addSubview:self.viewOfBack];
    self.labelOfTime = [[UILabel alloc]init];
    [self.viewOfBack addSubview:_labelOfTime];
    self.labelOfWeek = [[UILabel alloc]init];
    [self.viewOfBack addSubview:_labelOfWeek];
    self.labelOfLabel = [[UILabel alloc]init];
    [self.viewOfBack addSubview:_labelOfLabel];
    self.imageViewOfFire = [[UIImageView alloc]init];
    [self.viewOfBack addSubview:_imageViewOfFire];
    self.labelOfTime.textColor = [UIColor whiteColor];
    self.labelOfWeek.textColor = [UIColor whiteColor];
    self.labelOfLabel.textColor = [UIColor whiteColor];
    self.labelOfTime.textAlignment = YES;
    self.imageViewOfFire.image = [UIImage imageNamed:@"6666"];
    self.viewOfBack.layer.borderWidth = 1;
    self.viewOfBack.layer.borderColor = [UIColor whiteColor].CGColor;
    
//    self.labelOfLabel.backgroundColor = [UIColor orangeColor];
//    self.labelOfWeek.backgroundColor = [UIColor yellowColor];
//    self.labelOfTime.backgroundColor = [UIColor blueColor];
//    self.imageViewOfFire.backgroundColor = [UIColor redColor];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.labelOfTime.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelOfWeek.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelOfLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageViewOfFire.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewOfBack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.viewOfBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(5);
        make.right.bottom.equalTo(self.contentView).offset(-5);
    }];
    self.viewOfBack.layer.cornerRadius = 25;
    self.viewOfBack.clipsToBounds = YES;
    [self.labelOfTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.viewOfBack).offset(5);
        make.width.mas_offset(50);
        make.height.mas_offset(30);
    }];
    [self.labelOfWeek mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewOfBack).offset(5);
        make.left.equalTo(self.labelOfTime.mas_right).offset(5);
        make.width.mas_offset(200);
        make.height.mas_offset(30);
    }];
    [self.imageViewOfFire mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewOfBack).offset(5);
        make.bottom.right.equalTo(self.viewOfBack).offset(-10);
        make.width.mas_offset(40);
    }];
    [self.labelOfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelOfTime.mas_bottom).offset(3);
        make.left.equalTo(self.viewOfBack).offset(10);
        make.bottom.equalTo(self.viewOfBack).offset(-5);
        make.right.equalTo(self.imageViewOfFire.mas_left).offset(-5);
    }];
    
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
