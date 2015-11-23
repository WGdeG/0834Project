//
//  highQualityGoodsVC.m
//  food
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 xiaoqiang. All rights reserved.
//

#import "highQualityGoodsVC.h"
#import "GiFHUD.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworking.h"
#import "HighQualityGoodsCell.h"
#import "FodModel.h"
#import "DetailController.h"
#import "MJRefresh.h"
#define KMenuURL @"http://42.121.13.106:8080/HandheldKitchen/api/more/tblcalendaralertinfo!getHomePage.do?phonetype=2&page=1&pageRecord=8&user_id=&is_traditional=0"

@interface highQualityGoodsVC ()

@property(nonatomic,retain) NSMutableArray *foodsArr; //菜单数组
@property(nonatomic,assign) NSUInteger a;

@end


@implementation highQualityGoodsVC
static NSString *customCell = @"customcell";

-(NSMutableArray *)foodsArr{
    if (!_foodsArr) {
        _foodsArr = [NSMutableArray array];
    }
    return _foodsArr;
}

-(void)requstData{
    [GiFHUD show];
    if (_foodsArr) {
        [_foodsArr removeAllObjects];
    }
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:KMenuURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSString *html = operation.responseString;
            NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *array = dict[@"data"];
            for (NSDictionary *dic in array) {
                FodModel *model = [FodModel new];
                [model setValuesForKeysWithDictionary:dic];
                [self.foodsArr addObject:model];
            }
                [self.tableView reloadData];
            [GiFHUD dismiss];
            [self.tableView.mj_header endRefreshing];
            NSLog(@"成功了");
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"失败了");
        }];
}

-(void)requestDataUrlStr{
    
    _a++;
    NSString *url = [NSString stringWithFormat:@"http://42.121.13.106:8080/HandheldKitchen/api/more/tblcalendaralertinfo!getHomePage.do?phonetype=2&page=%ld&pageRecord=8&user_id=&is_traditional=0",_a];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *array = dict[@"data"];
        for (NSDictionary *dic in array) {
            FodModel *model = [FodModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.foodsArr addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"成功了");
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"失败了");
    }];

    
}
-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];
    [GiFHUD setGifWithImageName:@"pika.gif"];
    _a = 1;
    [self requstData];
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HighQualityGoodsCell" bundle:nil] forCellReuseIdentifier:customCell];
    //上啦刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requstData];
    }];
    //下拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestDataUrlStr];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _foodsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HighQualityGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:customCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FodModel *model = self.foodsArr[indexPath.row];
    cell.model = model;
   
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailController *detailVC = [DetailController new];
    FodModel *model = self.foodsArr[indexPath.row];
    detailVC.URLStr = model.vegetable_id;
    detailVC.AVUrl = model.productionProcessPath;
    detailVC.imgUrl = model.imagePathThumbnails;
    detailVC.nameStr = model.name;
    [self showDetailViewController:detailVC sender:nil];
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
