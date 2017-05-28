//
//  CellOfMyPub.h
//  MyPet
//
//  Created by 袁立康 on 17/4/18.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mybutton.h"
@class PubModel;
@interface CellOfMyPub : UITableViewCell
@property (nonatomic, retain)UILabel *title;
@property (nonatomic, retain)PubModel *model;
@property (nonatomic, retain)Mybutton *bu;
@property (nonatomic, retain)NSString *objectID;
@property (nonatomic, retain)UIImageView *Img;
@property (nonatomic, assign)NSNumber *closenum;

@end
