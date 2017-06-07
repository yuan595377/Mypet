//
//  Times+CoreDataProperties.h
//  Program
//
//  Created by Jasmine on 16/5/23.
//  Copyright © 2016年 XuRui. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Times.h"

NS_ASSUME_NONNULL_BEGIN

@interface Times (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *label;
@property (nullable, nonatomic, retain) NSNumber *minutes;
@property (nullable, nonatomic, retain) NSNumber *hour;
@property (nullable, nonatomic, retain) NSString *week;
@property (nullable, nonatomic, retain) NSString *music;

@end

NS_ASSUME_NONNULL_END
