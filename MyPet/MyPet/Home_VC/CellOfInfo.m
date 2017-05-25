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
        [self.contentView NightWithType:UIViewColorTypeNormal];
        [self createLayOut];
        
    }
    return self;


}

- (void)createLayOut {
    //设置标题
    
    
    self.name = [[UILabel alloc]init];
    [self.name setFont:[UIFont systemFontOfSize:15]];
    [self.name NightWithType:UIViewColorTypeNormal];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 150, 20));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
    }];
    
    
    self.time = [[UILabel alloc]init];
    [self.time NightWithType:UIViewColorTypeNormal];
    [self.time setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 150, 20));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.name.mas_bottom).with.offset(6);
    }];
    
    
    
    self.title = [[UILabel alloc]init];
    [self.title NightWithType:UIViewColorTypeNormal];
    [self.title setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 150, 30));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.time.mas_bottom).with.offset(10);
    }];
    
    
    self.dec_img = [[UIImageView alloc]init];
    [self.contentView addSubview:self.dec_img];
    [self.dec_img mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 300));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.title.mas_bottom).with.offset(6);
        
    }];
    
    
    
    self.contact = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.contact];
    [self.contact setTitle:@"联系他" forState:UIControlStateNormal];
    [self.contact setImage:[UIImage imageNamed:@"chat.png"] forState:UIControlStateNormal];
    [self.contact mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.dec_img.mas_bottom).with.offset(10);
        
    }];
    
    self.follow = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.follow];
    [self.follow setFont:[UIFont systemFontOfSize:13]];
    [self.follow setTitle:@"举报" forState:UIControlStateNormal];
    [self.follow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 20));
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        
    }];
    [self.follow.layer setBorderWidth:3];
    [self.follow.layer setMasksToBounds:YES];
    [self.follow.layer setCornerRadius:10.0];
    self.follow.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);
    [self.follow setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
     
    
}

- (NSUInteger)noRepeatNumberFrom:(NSMutableArray *)numberArray
{
    if (!numberArray) {
        numberArray = [[NSMutableArray alloc] initWithCapacity:14];
        for (int i = 1; i <= 14; i ++) {
            [numberArray addObject:@(i)];
        }
    }
    
    NSUInteger count = numberArray.count;
    
    int index = arc4random() % count;
    
    NSUInteger number = [numberArray[index] integerValue];
    
    [numberArray removeObjectAtIndex:index];
    
    return number;
}


- (void)setModel:(InfoModel *)model {
    self.title.text = model.title;
    self.name.text = model.name;
    self.time.text = model.time;
    [self.dec_img sd_setImageWithURL:[NSURL  URLWithString:model.url]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
