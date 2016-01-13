//
//  ViewController.m
//  AFNetWorkingTool
//
//  Created by Apple on 16/1/14.
//  Copyright © 2016年 Apple. All rights reserved.
//
#define DOWNLOADURL @"http://iappfree.candou.com:8080/free/applications/limited?currency=rmb&page=0"
#import "ViewController.h"
#import "AFNetworking.h"
#import "HTTPRequestTool.h"
#import "model.h"
#import "UIImageView+WebCache.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [HTTPRequestTool GET:DOWNLOADURL parameters:nil success:^(id responseObject) {
        
        NSMutableArray *dataArr = [HTTPRequestTool ModelTransformationWithResponseObject:responseObject modelClass:[model class]];
        [self.dataArray addObjectsFromArray:dataArr];
        
        [tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
#pragma mark --- tableView  代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellIndeti";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    model *mo = [self.dataArray objectAtIndex:indexPath.row];
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:mo.iconUrl] placeholderImage:nil];
    cell.textLabel.text = mo.name;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:mo.iconUrl]];
    return cell;
}



@end
