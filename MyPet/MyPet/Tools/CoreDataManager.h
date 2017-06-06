//
//  CoreDataManager.h
//  Projiect_01_CoreData
//
//  Created by 姜欢 on 16/5/16.
//  Copyright © 2016年 姜欢. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataManager : NSObject
+ (CoreDataManager *)shareManager;
// 数据管理类(被管理的上下文): 对NSManagedObject(实体管理类, 相当于数据库的某个表的某条数据)进行数据的增删改查操作
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
// 数据模型器 管理数据库中的各种表格
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
// 数据连接器(持久化存储助理) 实现从下层获取数据 向上层提供数据
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;// 持久化存储
- (NSURL *)applicationDocumentsDirectory; // 获取Document路径

@end
