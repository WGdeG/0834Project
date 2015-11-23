//
//  DataManger.m
//  food
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import "DataManger.h"

@implementation DataManger

static DataManger * manager = nil;
+ (DataManger *)sharedManger{
    //gcd 提供的一种单例方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [DataManger new];
     //   [manager requestData];
    });
    
    return manager;
}




@end
