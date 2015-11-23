//
//  HighQualityGoodsCell.m
//  food
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import "HighQualityGoodsCell.h"
#import "UIImageView+WebCache.h"
@interface HighQualityGoodsCell() 
@property (weak, nonatomic) IBOutlet UIImageView *img4Pic;
@property (weak, nonatomic) IBOutlet UILabel *lab4Foodname;
@property (weak, nonatomic) IBOutlet UILabel *lab4Role;

@end
@implementation HighQualityGoodsCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(FodModel *)model{
    _model = model;
    NSLog(@"%@", model.name);
    _lab4Foodname.text = model.name;
    _lab4Role.text = model.effect;
    [_img4Pic sd_setImageWithURL:[NSURL URLWithString:model.imagePathThumbnails]];
}

@end
