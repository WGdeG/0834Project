//
//  DoFoodModel.h
//  food
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoFoodModel : NSObject
@property (nonatomic,retain) NSString *order_id;//订单id
@property (nonatomic,retain) NSString *describe;//描述
@property (nonatomic,retain) NSString *imagePath;//图片路径
@property (nonatomic,retain) NSString *productionProcessPath; //视频

@property (nonatomic,retain) NSMutableArray *name; //调料材料名
//@property (nonatomic,assign) int orderld; //编号
@property (nonatomic,retain) NSMutableArray *materialName; //主材料


@end
