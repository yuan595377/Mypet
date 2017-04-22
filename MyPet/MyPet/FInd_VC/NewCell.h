//
//  NewCell.h
//  MyPet
//
//  Created by 袁立康 on 17/4/10.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewModel.h"
@interface NewCell : UITableViewCell
@property (nonatomic, retain)UILabel *title;
@property (nonatomic, retain)UIImageView *imageView1;
@property (nonatomic, retain)UILabel *pub_time;
@property (nonatomic, retain)UIImageView *bottomBack;
@property (nonatomic, retain)NewModel *model;
@property (nonatomic, assign)NSInteger IDD;


- (void)setTitle:(NSString *)title imageView1:(UIImageView *)imageView1 pub_time:(NSString *)pub_time;

@end
