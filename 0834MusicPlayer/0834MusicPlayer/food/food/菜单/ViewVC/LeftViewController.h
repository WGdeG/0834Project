//
//  LeftViewController.h
//  food
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
@interface LeftViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, RESideMenuDelegate>

+ (LeftViewController *)shareLeft;
@end
