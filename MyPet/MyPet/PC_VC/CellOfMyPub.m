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
    //设置标题
    self.title = [[UILabel alloc]init];
    [self.title NightWithType:UIViewColorTypeClear];
    [self.title setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 150, 60));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
    }];
    
    
    _bu = [Mybutton buttonWithType:UIButtonTypeCustom];
    [_bu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_bu setTitle:@"关闭接单" forState:UIControlStateNormal];
    [self.contentView addSubview:_bu];
    [_bu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.right.equalTo(self.title).with.offset(30);
        make.top.equalTo(self.contentView.mas_top).with.offset(30);
        
    }];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(PubModel *)model {
    self.title.text = model.title;
    self.objectID = model.objectID;

}

@end
