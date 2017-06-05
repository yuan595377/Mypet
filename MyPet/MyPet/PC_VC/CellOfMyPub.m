//
//  CellOfMyPub.m
//  MyPet
//
//  Created by 袁立康 on 17/4/18.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "CellOfMyPub.h"

@implementation CellOfMyPub

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
    
    self.avatar = [[UIImageView alloc]init];
    [self.contentView addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
    }];
    self.avatar.layer.cornerRadius = 15;
    self.avatar.layer.masksToBounds = YES;
    BmobUser *user = [BmobUser currentUser];
    NSString *str = [NSString stringWithFormat:@"%@",[user objectForKey:@"petavatar"]];
    NSLog(@"%@",str);
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"EaseUIResource.bundle/user"]];
    
    
    self.nickName = [[UILabel alloc]init];
    [self.contentView addSubview:self.nickName];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 20));
        make.left.equalTo(self.avatar.mas_right).with.offset(5);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);

    }];
    
    self.nickName.text = user.username;
    [self.nickName setFont:[UIFont systemFontOfSize:13]];
    self.nickName.textColor = [UIColor colorWithRed:0.61 green:0.70 blue:0.78 alpha:1.00];
    
    self.dec = [[UILabel alloc]init];
    [self.contentView addSubview:self.dec];
    [self.dec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 20));
        make.left.equalTo(self.nickName.mas_right).with.offset(0);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        
    }];
    self.dec.text = @"发布动态:";
    [self.dec setFont:[UIFont systemFontOfSize:13]];

    
    self.pubTime = [[UILabel alloc]init];
    [self.contentView addSubview:self.pubTime];
    [self.pubTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.left.equalTo(self.avatar.mas_right).with.offset(5);
        make.top.equalTo(self.nickName.mas_bottom).with.offset(2);
        
    }];
    [self.pubTime setFont:[UIFont systemFontOfSize:12]];
    [self.pubTime setTextColor:[UIColor grayColor]];
    
    
    //设置标题
    self.title = [[UILabel alloc]init];
    [self.title NightWithType:UIViewColorTypeClear];
    [self.title setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 150, 30));
        make.left.equalTo(self.contentView).with.offset(45);
        make.top.equalTo(self.pubTime.mas_bottom).with.offset(5);
    }];
    
    
    
    
    
    self.Img = [[UIImageView alloc]init];
    [self.contentView addSubview:self.Img];
    [self.Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, 200));
        make.left.equalTo(self.contentView).with.offset(45);
        make.top.equalTo(self.title.mas_bottom).with.offset(5);
    }];
    
    
    _bu = [Mybutton buttonWithType:UIButtonTypeCustom];
    [_bu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_bu setTitle:@"关闭接单" forState:UIControlStateNormal];
    [_bu setFont:[UIFont systemFontOfSize:13]];
    _bu.layer.borderWidth = 1;
    [self.contentView addSubview:_bu];
    [_bu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.top.equalTo(self.Img.mas_bottom).with.offset(10);
        
    }];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(PubModel *)model {
    
    self.title.text = model.title;
    self.objectID = model.objectID;
    [self.Img sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:nil];
    self.closenum = model.closenum;
    if ([self.closenum isEqual:@1]) {
        [self.bu setTitle:@"已接单" forState:UIControlStateNormal];
    }else {
        [self.bu setTitle:@"关闭接单" forState:UIControlStateNormal];
    }
    self.pubTime.text = model.PubTime;
}

@end
