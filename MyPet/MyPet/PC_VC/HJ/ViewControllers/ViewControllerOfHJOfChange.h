//
//  ViewControllerOfHJOfChange.h
//  Program
//
//  Created by Jasmine on 16/5/19.
//  Copyright © 2016年 XuRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerOfHJOfChange : UIViewController
@property (nonatomic, strong)void(^passValue )(NSString *);
@property (nonatomic, strong)void(^passImage )(UIImage *);
@end
