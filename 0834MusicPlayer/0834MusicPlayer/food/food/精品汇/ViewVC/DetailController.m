//
//  DetailController.m
//  food
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import "DetailController.h"
#import "GiFHUD.h"
#import <AVFoundation/AVFoundation.h>
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "DoFoodModel.h"
#import "MateriaModel.h"
#import "KnowledgeModel.h"
#import "SimilarModel.h"
#import "UIImageView+WebCache.h"
#define kURLA @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getIntelligentChoice.do?vegetable_id=%@&type=2&phonetype=0&is_traditional=0"
#define kURLB @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getIntelligentChoice.do?vegetable_id=%@&type=1&phonetype=0&is_traditional=0"
#define kURLC @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getIntelligentChoice.do?vegetable_id=%@&type=4&phonetype=0&is_traditional=0"
#define kURLD @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getIntelligentChoice.do?vegetable_id=%@&type=3&phonetype=0&is_traditional=0"
@interface DetailController ()<SUNSlideSwitchViewDelegate>
@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,retain) UIButton *btn1;
@property(nonatomic,retain) UIView *view1;
@property(nonatomic,retain) UIImageView *imgV;
@property(nonatomic,retain) UILabel *lab4Name;
@end

@implementation DetailController

-(NSMutableArray *)foodArr{
    if (!_foodArr) {
        _foodArr = [NSMutableArray array];
    }
    return _foodArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [GiFHUD setGifWithImageName:@"pika.gif"];
    
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height*2/5)];
    _view1.backgroundColor = [UIColor redColor];
    
    _imgV = [[UIImageView alloc] initWithFrame:_view1.bounds];
    [_imgV sd_setImageWithURL:[NSURL URLWithString:_imgUrl]];
    //创建一个item
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"]];
    //初始化播放器
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    //获取播放器的layer
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
    //设置播放器的layer
    playerLayer.frame = _view1.frame;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    playerLayer.backgroundColor = [[UIColor blackColor] CGColor];
    //讲layer添加到当期页面的layer层中
    [_view1.layer addSublayer:playerLayer];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10, 20, 40, 30);
    btn.userInteractionEnabled = YES;
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(backPage:) forControlEvents:UIControlEventTouchUpInside];
    
    _lab4Name = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*1/5, 20, self.view.bounds.size.width*3/5, 30)];
    _lab4Name.backgroundColor = [UIColor clearColor];
    _lab4Name.textColor = [UIColor greenColor];
    _lab4Name.textAlignment = NSTextAlignmentCenter;
    _lab4Name.text = _nameStr;
    _btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn1.frame = CGRectMake(_view1.frame.size.width/2 - 20, _view1.frame.size.height/2 - 20, 40, 40);
    _btn1.backgroundColor = [UIColor clearColor];
    [_btn1 setTitle:@"播放" forState:UIControlStateNormal];
    [_btn1 addTarget:self action:@selector(startPage:) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:_imgV];
    [_view1 addSubview:_btn1];
    [_view1 addSubview:_lab4Name];
    [_view1 addSubview:btn];
    [self.view addSubview:_view1];
    [self slideView];
    
    
}
-(void)slideView{
    self.slideSwitchView = [[SUNSlideSwitchView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height*2/5, self.view.bounds.size.width, self.view.bounds.size.height*3/5)];
    
    _slideSwitchView.slideSwitchViewDelegate = self;
    
    [self.view addSubview:self.slideSwitchView];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = _titleStr;
    //self.title = @"滑动切换视图";
    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    
    self.vc1 = [[ListViewController alloc] init];
    self.vc1.title = @"做法";
    
    self.vc2 = [[ListViewController alloc] init];
    self.vc2.title = @"材料";
    
    self.vc3 = [[ListViewController alloc] init];
    self.vc3.title = @"相关常识";
    
    self.vc4 = [[ListViewController alloc] init];
    self.vc4.title = @"相宜相克";
    [self.slideSwitchView buildUI];
}

#pragma mark -delegate

- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return 4;
}

- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.vc1;
    } else if (number == 1) {
        return self.vc2;
    } else if (number == 2) {
        return self.vc3;
    } else if (number == 3) {
        return self.vc4;
    } else {
        return nil;
    }
}

- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    ListViewController *vc = nil;
    if (number == 0) {
        vc = self.vc1;
        NSString *str = [NSString stringWithFormat:kURLA,_URLStr];
        [self dataWithVC:vc Url:str];

    } else if (number == 1) {
        vc = self.vc2;
        NSString *str = [NSString stringWithFormat:kURLB,_URLStr];
        [self dataWithVC1:vc Url:str];
        
    } else if (number == 2) {
        vc = self.vc3;
        NSString *str = [NSString stringWithFormat:kURLC,_URLStr];
        [self dataWithVC2:vc Url:str];
    } else if (number == 3) {
        vc = self.vc4;
        NSString *str = [NSString stringWithFormat:kURLD,_URLStr];
        [self dataWithVC3:vc Url:str];
    }
    
}

- (void)dataWithVC:(ListViewController *)listVC Url:(NSString *)url{
    [GiFHUD show];
    
    if (listVC.dataArray.count) {
        [listVC.dataArray removeAllObjects];
    }
    [self dataWithURL:url block:^(id block) {
        NSDictionary *dic = (NSDictionary *)block;
        NSArray *array = dic[@"data"];
        for (NSDictionary *dic1 in array) {
       
            DoFoodModel *food = [DoFoodModel new];
            [food setValuesForKeysWithDictionary:dic1];
            [listVC.dataArray addObject:food];
        }
        [listVC.tableView reloadData];
        [GiFHUD dismiss];
    }];
}
- (void)dataWithVC1:(ListViewController *)listVC Url:(NSString *)url{
    
    [GiFHUD show];
    if (listVC.dataArray.count) {
        [listVC.dataArray removeAllObjects];
    }
    [self dataWithURL:url block:^(id block) {
        NSDictionary *dic = (NSDictionary *)block;
        NSArray *array = dic[@"data"];
        NSArray *arr = [NSArray array];
        for (NSDictionary *dic1 in array) {
             arr = dic1[@"TblSeasoning"];
            for (NSDictionary *dict in arr) {
                MateriaModel *model = [MateriaModel new];
                [model setValuesForKeysWithDictionary:dict];
                [listVC.dataArray addObject:model];
            }
        }
        
        [listVC.tableView reloadData];
        [GiFHUD dismiss];
    }];
}
- (void)dataWithVC2:(ListViewController *)listVC Url:(NSString *)url{
    
    [GiFHUD show];
    if (listVC.dataArray.count) {
        [listVC.dataArray removeAllObjects];
    }
    [self dataWithURL:url block:^(id block) {
        NSDictionary *dic = (NSDictionary *)block;
        NSArray *array = dic[@"data"];
        for (NSDictionary *dic1 in array) {
            
            KnowledgeModel *model = [KnowledgeModel new];
            [model setValuesForKeysWithDictionary:dic1];
            [listVC.dataArray addObject:model];
        }
        [listVC.tableView reloadData];
        [GiFHUD dismiss];
    }];
}
- (void)dataWithVC3:(ListViewController *)listVC Url:(NSString *)url{
    
    [GiFHUD show];
    if (listVC.dataArray.count) {
        [listVC.dataArray removeAllObjects];
    }
    [self dataWithURL:url block:^(id block) {
        NSDictionary *dic = (NSDictionary *)block;
        NSArray *array = dic[@"data"];
        NSArray *arr = [NSArray array];
        for (NSDictionary *dic1 in array) {
            arr = dic1[@"Fitting"];
            for (NSDictionary *dict in arr) {
                SimilarModel *model = [SimilarModel new];
                [model setValuesForKeysWithDictionary:dict];
                [listVC.dataArray addObject:model];
            }
        }
        
        [listVC.tableView reloadData];
        [GiFHUD dismiss];
    }];
}

/*

- (void)dataWithVC3:(ListViewController *)listVC Url:(NSString *)url{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSString *html = operation.responseString;
            NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *array = dict[@"data"];
            for (NSDictionary *dic in array) {
                KnowledgeModel *model = [KnowledgeModel new];
                [model setValuesForKeysWithDictionary:dic];
                [self.knowArr addObject:model];
                NSLog(@"----%@",model);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [listVC.tableView reloadData];
            });
            
            NSLog(@"成功了");
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"失败了");
        }];
    });
    
}

- (void)dataWithVC4:(ListViewController *)listVC Url:(NSString *)url{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSString *html = operation.responseString;
            NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *array = dict[@"data"];
            for (NSDictionary *dic in array) {
                KnowledgeModel *model = [KnowledgeModel new];
                [model setValuesForKeysWithDictionary:dic];
                [self.knowArr addObject:model];
                NSLog(@"----%@",model);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [listVC.tableView reloadData];
            });
            
            NSLog(@"成功了");
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"失败了");
        }];
    });
    
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)materiaArr{
    if (!_materiaArr) {
        _materiaArr = [NSMutableArray array];
    }
    return _materiaArr;
}
-(NSMutableArray *)knowArr{
    if (!_knowArr) {
        _knowArr = [NSMutableArray array];
    }
    return _knowArr;
}
-(NSMutableArray *)similarArr{
    if (!_similarArr) {
        _similarArr = [NSMutableArray array];
    }
    return _similarArr;
}

- (void)backPage:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)startPage:(UIButton *)sender{
    //播发器开始播放
    [self.player play];
    _btn1.hidden = YES;
    _imgV.hidden = YES;
}

- (void)dataWithURL:(NSString *)url block:(myBlock)block{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        block(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        block(nil);
    }];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
