//
//  ZKFunsDeailViewController.m
//  ZKSport
//
//  Created by Tom on 2017/11/18.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKFunsDeailViewController.h"
#import "ZKFunsDetailViewCell.h"

static NSString * const cellIdentifider = @"ZKFunsDetailViewCell";

@interface ZKFunsDeailViewController ()
@property (nonatomic, strong) NSMutableArray         * listArray;
@property (nonatomic, strong) ZKFunsDetailHeaderView * headerView;
@end

@implementation ZKFunsDeailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
}

- (void)setTableView {
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    self.headerView.frame = CGRectMake(0, 0, D_WIDTH, self.model.cellHeight);
    self.headerView.model = self.model;
    [self.tableView registerClass:[ZKFunsDetailViewCell class] forCellReuseIdentifier:cellIdentifider];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadListData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadListData {
    if (self.listArray.count) {
        [self.listArray removeAllObjects];
    }
    NSString * linkString = [NSString stringWithFormat:@"http://api.budejie.com/api/api_open.php?a=dataList&c=comment&data_id=%@&hot=1",self.model.ID];
    [[ZKNetWorkManager shareManager] requestWithType:requestTypeGet urlString:linkString andParameters:nil success:^(id responsderObj) {
        if (responsderObj) {
            NSArray * hot = [ZKFunsDetailModel mj_objectArrayWithKeyValuesArray:responsderObj[@"hot"]];
            self.listArray = [NSMutableArray arrayWithArray:hot];
            
            NSArray * data = [ZKFunsDetailModel mj_objectArrayWithKeyValuesArray:responsderObj[@"data"]];
            [self.listArray addObjectsFromArray:data];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreListData {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZKFunsDetailModel * model = self.listArray[indexPath.row];
    ZKFunsDetailViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifider forIndexPath:indexPath];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZKFunsDetailModel * model = self.listArray[indexPath.row];
    return model.cellHeight;
}

#pragma mark - lazy init
- (ZKFunsDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[ZKFunsDetailHeaderView alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

#pragma mark - dealloc
- (void)dealloc {
    NSLog(@"ZKFunsDetailViewController dealloc !!!!!!");
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
