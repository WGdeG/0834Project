//
//  ImageCell.m
//  UI21_UICollectionView
//
//  Created by lanou3g on 15/10/20.
//  Copyright (c) 2015年 xiaoqiang. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addCustomView];
        
        
    }
    return self;
}

//添加控件
-(void)addCustomView{
    self.imgView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    //添加到内容视图
    [self.contentView addSubview:_imgView];

}

@end
