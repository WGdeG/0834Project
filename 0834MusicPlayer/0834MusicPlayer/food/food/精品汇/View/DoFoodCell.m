//
//  DoFoodCell.m
//  food
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import "DoFoodCell.h"
#import "UIImageView+WebCache.h"
@interface DoFoodCell()
@property (weak, nonatomic) IBOutlet UIImageView *img4do;
@property (weak, nonatomic) IBOutlet UILabel *lab4say;

@end

@implementation DoFoodCell

-(void)setModel:(DoFoodModel *)model{
    _model = model;
    [_img4do sd_setImageWithURL:[NSURL URLWithString:model.imagePath]];
    _lab4say.text = model.describe;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
