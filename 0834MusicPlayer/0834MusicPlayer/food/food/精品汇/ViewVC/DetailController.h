//
//  DetailController.h
//  food
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
#import "SUNSlideSwitchView.h"
typedef void (^myBlock)(id block);

@interface DetailController : UIViewController
@property(nonatomic,retain)NSString *nameStr;
@property(nonatomic,retain)NSString *imgUrl;
@property(nonatomic,retain)NSString *AVUrl;
@property (nonatomic,retain) NSString *URLStr;
@property (nonatomic,retain) NSString *titleStr;
@property (nonatomic, retain)SUNSlideSwitchView *slideSwitchView;

@property (nonatomic, strong) ListViewController *vc1;
@property (nonatomic, strong) ListViewController *vc2;
@property (nonatomic, strong) ListViewController *vc3;
@property (nonatomic, strong) ListViewController *vc4;
@property (nonatomic, strong) ListViewController *vc5;
@property (nonatomic, strong) ListViewController *vc6;

@property(nonatomic,retain)NSMutableArray *foodArr;
@property(nonatomic,retain)NSMutableArray *materiaArr;
@property(nonatomic,retain)NSMutableArray *knowArr;
@property(nonatomic,retain)NSMutableArray *similarArr;

//block
@property(nonatomic,copy) myBlock block;

@end
