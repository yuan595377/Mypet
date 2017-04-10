//
//  NewCell.m
//  MyPet
//
//  Created by 袁立康 on 17/4/10.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "NewCell.h"
#import "NewModel.h"
@implementation NewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//重写init
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //布局
        [self createLayOut];
        
    }
    return self;
}

-(void)createLayOut {
    //设置标题
    self.title = [[UILabel alloc]init];
    [self.title setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 150, 60));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
    }];
    
    //设置时间
    self.pub_time = [[UILabel alloc]init];
    [self.pub_time setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:self.pub_time];
    [self.pub_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.left.equalTo(self.contentView).with.offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
        
    }];
    
    
    self.imageView1 = [[UIImageView alloc]init];
    [self.contentView addSubview:self.imageView1];
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 100));
        make.left.equalTo(self.title.mas_right).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
    }];
    
    self.bottomBack = [[UIImageView alloc]init];
    [self.contentView addSubview:self.bottomBack];
    self.bottomBack.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [self.bottomBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 10));
        make.left.equalTo(self.contentView).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
    }];
    

}



- (void)setTitle:(NSString *)title imageView1:(UIImageView *)imageView1 pub_time:(NSString *)pub_time{
    self.title.text = title;
    self.pub_time.text = pub_time;
    self.imageView1 = imageView1;


}


- (void)setModel:(NewModel *)model {
    
    _pub_time.text = model.edittime;
    _title.text = model.title;
    [_imageView1 sd_setImageWithURL:[NSURL URLWithString:model.thumb]];

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
