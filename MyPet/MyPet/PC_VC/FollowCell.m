//
//  FollowCell.m
//  MyPet
//
//  Created by 袁立康 on 17/5/28.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "FollowCell.h"

@implementation FollowCell

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
    self.username = [[UILabel alloc]init];
    [self.username NightWithType:UIViewColorTypeClear];
    [self.username setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:self.username];
    [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 150, 60));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
    }];
    
}


- (void)setModel:(followModel *)model {
    self.username.text = model.username;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
