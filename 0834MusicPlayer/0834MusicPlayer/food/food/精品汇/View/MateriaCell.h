//
//  MateriaCell.h
//  food
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MateriaModel.h"
@interface MateriaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img4pic;
@property (weak, nonatomic) IBOutlet UILabel *lab4name;

@property (nonatomic,retain) MateriaModel *model;

@end
