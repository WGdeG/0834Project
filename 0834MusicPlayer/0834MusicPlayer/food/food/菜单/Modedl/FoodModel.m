//
//  FoodModel.m
//  food
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _imagePathThumbnails];
}


@end
