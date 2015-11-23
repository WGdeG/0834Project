//
//  MenuVC.h
//  food
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block) ();

@interface MenuVC : UIViewController

@property (nonatomic, copy) block myBlock;

+ (UITabBarController *)shareMenu;
@end
