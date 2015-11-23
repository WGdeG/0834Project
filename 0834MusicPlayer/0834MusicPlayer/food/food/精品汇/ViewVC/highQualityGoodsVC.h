//
//  highQualityGoodsVC.h
//  food
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^myblock)(id block);
@interface highQualityGoodsVC : UITableViewController

@property (nonatomic,copy) myblock block;

@end
