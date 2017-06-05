//
//  PubModel.h
//  MyPet
//
//  Created by 袁立康 on 17/4/18.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PubModel : NSObject
@property (nonatomic,retain)NSString *title;
@property (nonatomic, retain)NSString *objectID;
@property (nonatomic, retain)NSString *url;
@property (nonatomic, retain)NSString *PubTime;
@property (nonatomic, assign)NSNumber *closenum;
@end
