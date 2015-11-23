//
//  MateriaCell.m
//  food
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import "MateriaCell.h"
#import "UIImageView+WebCache.h"
@implementation MateriaCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(MateriaModel *)model{
    _model = model;
    [_img4pic sd_setImageWithURL:[NSURL URLWithString:model.imagePath]];
    _lab4name.text = model.name;
 
}

@end
