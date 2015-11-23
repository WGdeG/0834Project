//
//  KnowledgeModel.m
//  food
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import "KnowledgeModel.h"

@implementation KnowledgeModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@",_nutritionAnalysis];
}

@end
