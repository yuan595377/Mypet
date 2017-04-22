//
//  CellOfInfo.h
//  MyPet
//
//  Created by 袁立康 on 17/4/18.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellOfInfo : UITableViewCell
@property (nonatomic, retain)UILabel *title;
@property (nonatomic, retain)InfoModel *model;
@property (nonatomic, retain)UILabel *name;
@property (nonatomic, retain)UIButton *contact;

@property (nonatomic, retain)UILabel *time;

@end
