//
//  RepeatPicCollectionView.h
//  Project
//
//  Created by dllo on 15/9/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepeatPicCollectionView : UICollectionView


@property (nonatomic, retain) NSMutableArray *picturesViewArr;

@property (nonatomic, retain) NSTimer *timer;

- (void)showPicWithPicArr:(NSMutableArray *)picArr interval:(NSTimeInterval)interval;

@end
