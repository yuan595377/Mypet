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
    
    
    self.avatar = [[UIImageView alloc]init];
    [self.contentView addSubview:self.avatar];
    self.avatar.layer.cornerRadius = 20;
    self.avatar.layer.masksToBounds = YES;
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
    }];

    
    
    self.name = [[UILabel alloc]init];
    [self.name setFont:[UIFont systemFontOfSize:15]];
    self.name.textColor = [UIColor colorWithRed:0.61 green:0.70 blue:0.78 alpha:1.00];
    [self.name NightWithType:UIViewColorTypeNormal];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 150, 20));
        make.left.equalTo(self.avatar.mas_right).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(13);
    }];
    
    
    self.time = [[UILabel alloc]init];
    [self.time NightWithType:UIViewColorTypeNormal];
    [self.time setFont:[UIFont systemFontOfSize:12]];
    self.time.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 150, 20));
        make.left.equalTo(self.avatar.mas_right).with.offset(10);
        make.top.equalTo(self.name.mas_bottom).with.offset(3);
    }];
    
    
    
    self.title = [[UILabel alloc]init];
    [self.title NightWithType:UIViewColorTypeNormal];
    [self.title setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 50, 30));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.time.mas_bottom).with.offset(5);
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
    [self.contact setImage:[UIImage imageNamed:@"消息.png"] forState:UIControlStateNormal];
    [self.contact mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(self.contentView).with.offset(20);
        make.top.equalTo(self.dec_img.mas_bottom).with.offset(10);
        
    }];
    
    
    self.labelOfJudge = [[UILabel alloc]init];
    [self.labelOfJudge NightWithType:UIViewColorTypeNormal];
    [self.labelOfJudge setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:self.labelOfJudge];
    [self.labelOfJudge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.top.equalTo(self.dec_img.mas_bottom).with.offset(5);
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
    self.labelOfJudge.text = model.is_close;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholderImage:[UIImage imageNamed:@"EaseUIResource.bundle/user"]];

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
