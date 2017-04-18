//
//  CellOfMyPub.h
//  MyPet
//
//  Created by 袁立康 on 17/4/18.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PubModel;
@interface CellOfMyPub : UITableViewCell
@property (nonatomic, retain)UILabel *title;
@property (nonatomic, retain)PubModel *model;
@end
