//
//  SilimarCell.m
//  food
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import "SilimarCell.h"
#import "UIImageView+WebCache.h"
@implementation SilimarCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(SimilarModel *)model{
    _model = model;
    [_img4pic sd_setImageWithURL:[NSURL URLWithString:model.imageName]];
    _lab4name.text = model.materialName;
    _lab4name.numberOfLines = 0;
    _lab4describe.text = model.contentDescription;
    _lab4describe.numberOfLines = 0;
}

@end
