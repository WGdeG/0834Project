//
//  RepeatPicCollectionView.m
//  Project
//
//  Created by dllo on 15/9/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "RepeatPicCollectionView.h"
#import "ImageCell.h"
#import "NSTimer+Pausing.h"
#import "UIImageView+WebCache.h"
@implementation RepeatPicCollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self)
    {

        self.backgroundColor = [UIColor whiteColor];
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.picturesViewArr = [NSMutableArray array];

    }
    return self;
}

//  根据图片数组和时间间隔改变图片
- (void)showPicWithPicArr:(NSMutableArray *)picArr interval:(NSTimeInterval)interval
{


    self.picturesViewArr = picArr;

    self.contentOffset = CGPointMake(self.bounds.size.width * 1, 0);

    //  每隔interval执行一次改变图片方法
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(changePicture) userInfo:nil repeats:YES];


}

//  改变图片方法
- (void)changePicture
{

//    [self setContentOffset:CGPointMake(self.contentOffset.x + 375, 0) animated:YES];
    NSInteger currentPage = self.contentOffset.x / self.bounds.size.width;
    [self setContentOffset:CGPointMake((currentPage + 1) * self.bounds.size.width, 0) animated:YES];

}

//  点击时暂停计时器
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.timer pause];
}
//  松开后恢复计时器
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.timer resume];
}





@end
