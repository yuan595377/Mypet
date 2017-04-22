//
//  CellOfInfo.m
//  MyPet
//
//  Created by 袁立康 on 17/4/18.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "CellOfInfo.h"

@implementation CellOfInfo

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
    //设置标题
    
    
    self.name = [[UILabel alloc]init];
    [self.name setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 150, 20));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
    }];
    
    
    self.time = [[UILabel alloc]init];
    [self.time setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 150, 20));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.name.mas_bottom).with.offset(6);
    }];
    
    
    
    self.title = [[UILabel alloc]init];
    [self.title setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 150, 30));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.time.mas_bottom).with.offset(10);
    }];
    
    
    self.contact = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.contact];
    [self.contact setTitle:@"联系他" forState:UIControlStateNormal];
    [self.contact setImage:[UIImage imageNamed:@"chat.png"] forState:UIControlStateNormal];
    [self.contact mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.title.mas_bottom).with.offset(10);
        
    }];
    
    
     
    
}

- (void)setModel:(InfoModel *)model {
    self.title.text = model.title;
    self.name.text = model.name;
    self.time.text = model.time;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
