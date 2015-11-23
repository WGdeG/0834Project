//
//  KnowledgeCell.h
//  food
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KnowledgeModel.h"
@interface KnowledgeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img4pic;
@property (weak, nonatomic) IBOutlet UILabel *lab4name;
@property (nonatomic,retain) KnowledgeModel *model;

@end
