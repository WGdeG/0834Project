//
//  FoodModel.h
//  food
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodModel : NSObject

@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *productionProcessPath; //烹饪工艺 路径
@property (nonatomic,retain) NSString *method;//方法
@property (nonatomic,retain) NSString *materialVideoPath;//材料视频路径
@property (nonatomic,retain) NSString *imagePathThumbnails;//图片缩略图路径
@property (nonatomic,retain) NSString *imagePathPortrait;//图片路径的肖像
@property (nonatomic,retain) NSString *imagePathLandscape;//背景图像 路径
@property (nonatomic,retain) NSString *fittingRestriction;//合适的限制
@property (nonatomic,retain) NSString *fittingCrowd;//合适的人群
@property (nonatomic,retain) NSString *effect;//作用
@property (nonatomic,retain) NSString *vegetable_id; // 传值id
@end
