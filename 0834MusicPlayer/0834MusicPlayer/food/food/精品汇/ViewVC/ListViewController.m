//
//  ListViewController.m
//  test
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "ListViewController.h"
#import "DoFoodCell.h"
#import "MateriaCell.h"
#import "KnowledgeCell.h"
#import "SilimarCell.h"
@interface ListViewController ()

@property(nonatomic,retain)NSArray *arr;

@end

@implementation ListViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DoFoodCell" bundle:nil] forCellReuseIdentifier:@"customCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MateriaCell" bundle:nil] forCellReuseIdentifier:@"materiaCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KnowledgeCell" bundle:nil] forCellReuseIdentifier:@"knowledgeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SilimarCell" bundle:nil] forCellReuseIdentifier:@"silimarCell"];
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

    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.title isEqualToString:@"做法"]) {
        DoFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell" forIndexPath:indexPath];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        DoFoodModel *model = _dataArray[indexPath.row];
        cell.model = model;
        return cell;
    }
    if ([self.title isEqualToString:@"材料"]) {
        MateriaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"materiaCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        MateriaModel *model = _dataArray[indexPath.row];
        cell.model = model;
        return cell;
    }
    
    if ([self.title isEqualToString:@"相关常识"]) {
        KnowledgeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"knowledgeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        KnowledgeModel *model = _dataArray[indexPath.row];
        cell.model = model;
        return cell;
    }
    if ([self.title isEqualToString:@"相宜相克"]) {
        SilimarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"silimarCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        SimilarModel *model = _dataArray[indexPath.row];
        cell.model = model;
        return cell;
    }
   
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
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
