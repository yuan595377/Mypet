//
//  PetCell.m
//  MyPet
//
//  Created by 袁立康 on 17/5/30.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "PetCell.h"

@implementation PetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //布局
        [self createLayOut];
        
    }
    return self;
    
    
}

- (void)createLayOut {
    self.title = [[UILabel alloc]init];
    [self.contentView addSubview:_title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 50));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
    }];
    
    
    self.add = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.add setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_add];
    [self.add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 50));
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
    }];
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
