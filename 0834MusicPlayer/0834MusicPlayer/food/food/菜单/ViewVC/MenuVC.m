//
//  MenuVC.m
//  food
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import "MenuVC.h"
#import "GiFHUD.h"
#import "AFNetworking.h"
#import "FoodModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "RepeatPicCollectionView.h"
#import "ImageCell.h"
#import "UIImageView+WebCache.h"
#import "DetailController.h"
#define KMenuURL @"http://42.121.13.106:8080/HandheldKitchen/api/more/tblcalendaralertinfo!getHomePage.do?phonetype=2&page=1&pageRecord=8&user_id=&is_traditional=0"
#define kWidth self.view.bounds.size.width*1
#define kHigh self.view.bounds.size.height -108

@interface MenuVC ()<UIScrollViewDelegate>
@property(nonatomic,retain) UIScrollView *scollView;
@property(nonatomic,retain)UIPageControl *pageController;
@property(nonatomic,retain) NSMutableArray *foodsArr; //菜单数组
@property(nonatomic,retain) NSMutableArray *imgArr; //轮播图图片数组
@property(nonatomic,retain) UICollectionView *repeatCV; //集合视图
@property(nonatomic,retain)UIImageView *imgView;
@property (nonatomic, retain) NSTimer *timer;
@property(nonatomic,assign)NSUInteger index;
@property(nonatomic,retain)UILabel *lab4Name;
@end

@implementation MenuVC

static  UITabBarController*menuNav = nil;

+ (UITabBarController *)shareMenu{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        menuNav =[sb instantiateViewControllerWithIdentifier:@"tabBar"];
    });
    return menuNav;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.timer invalidate];
    self.timer = nil;
    
    self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(roop:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    
    self.view.backgroundColor = [UIColor redColor];
    [GiFHUD setGifWithImageName:@"pika.gif"];
    [self requstData];
    [self customScroll];
    
}

- (void)customScroll{

    _lab4Name = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/5, 100, self.view.bounds.size.width*3/5, 40)];
    _lab4Name.backgroundColor = [UIColor clearColor];
    _lab4Name.textColor = [UIColor greenColor];
    _lab4Name.textAlignment = NSTextAlignmentCenter;
    self.scollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHigh)];
    self.scollView.contentSize = CGSizeMake(kWidth * 8, kHigh);
    self.scollView.pagingEnabled = YES;
    self.scollView.delegate = self;
    
    UIPageControl *page = [[UIPageControl alloc]initWithFrame:CGRectMake(kWidth/3, self.view.bounds.size.height-74, kWidth*2/3, 20)];
    self.pageController = page;
    page.numberOfPages = 8;
    page.pageIndicatorTintColor = [UIColor blackColor];
    page.currentPageIndicatorTintColor = [UIColor redColor];
    
    __weak typeof (self)temp = self;
    self.myBlock = ^(){
        
    [GiFHUD dismiss];

    for (int i = 0; i < 8; i ++) {
        UIImage *image = [UIImage imageNamed:@"place"];
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth * i), 0, kWidth , kHigh)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:temp action:@selector(tapNext:)];
        tap.numberOfTapsRequired = 1;
        [temp.scollView addGestureRecognizer:tap];
        temp.imgView.image = image;
       // temp.imgView.tag = 1000+i;
        FoodModel *food = temp.foodsArr[i];
        [temp.imgView sd_setImageWithURL:[NSURL URLWithString:food.imagePathThumbnails]];
      //  temp.lab4Name.text = food.name;
        [temp.scollView addSubview:temp.imgView];
        
    }
    [temp.view addSubview:temp.scollView];
    [temp.view addSubview:temp.lab4Name];
    [temp.view addSubview:page];
    };
}

- (void)roop:(UIPageControl *)sender{
    NSInteger page = _pageController.currentPage;
    page ++;
    if (page == 8) {
        page = 0;
        _scollView.contentOffset = CGPointMake(0, 0);
    }
    _index = page;
    [_scollView setContentOffset:CGPointMake(375 * page, 0) animated:YES];
    FoodModel *model = _foodsArr[_index];
    _lab4Name.text = model.name;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = _scollView.contentOffset.x/375 + 0;
    _pageController.currentPage =  page;
    
}


-(void)requstData{
    
    [GiFHUD show];
    
    NSURL *url = [NSURL URLWithString:KMenuURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *array = dict[@"data"];
        for (NSDictionary *dic in array) {
            FoodModel *model = [FoodModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.imgArr addObject:model.imagePathThumbnails];
            [self.foodsArr addObject:model];
            
            for (int i=0; i<_foodsArr.count; i++) {
                NSLog(@"%@",model);
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
             self.myBlock();
        });
       
        NSLog(@"🐟%@",_imgArr);
      
    }];
    
    [task resume];
}

-(void)tapNext:(UIGestureRecognizer *)sender{

    DetailController *detailVC = [DetailController new];
    FoodModel *model = self.foodsArr[_index];
    detailVC.URLStr = model.vegetable_id;
    detailVC.titleStr = model.name;
    detailVC.imgUrl = model.imagePathThumbnails;
    detailVC.AVUrl = model.materialVideoPath;
    [self showViewController:detailVC sender:nil];
    [self.timer invalidate];
}


-(NSMutableArray *)foodsArr{
    if (!_foodsArr) {
        _foodsArr = [NSMutableArray array];
    }
    return _foodsArr;
}
-(NSMutableArray *)imgArr{
    if (!_imgArr) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
