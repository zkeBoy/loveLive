//
//  ZKFunsViewController.m
//  ZKSport
//
//  Created by Tom on 2017/11/15.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKFunsViewController.h"
#import "ZKFunsTableViewCell.h"
#import "ZKFunsDeailViewController.h"

static NSString * const cellIdentifider = @"ZKFunsTableViewCell";
static NSString * const linkString = @"http://api.budejie.com/api/api_open.php?a=list&c=data&type=29";

@interface ZKFunsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * listArray;
@property (nonatomic, assign) NSInteger        page;
@end

@implementation ZKFunsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"段子", nil);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    [self addTableView];
}

- (void)addTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.frame = CGRectMake(0, NavBarH, D_WIDTH, D_HEIGHT-NavBarH-TabBarH);
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadListData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreListData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    [self.tableView registerClass:[ZKFunsTableViewCell class] forCellReuseIdentifier:cellIdentifider];
}

- (void)loadListData {
    if (self.listArray.count) {
        [self.listArray removeAllObjects];
        [self.tableView reloadData];
    }
    //http://route.showapi.com/255-1?showapi_appid=50455&showapi_sign=d5b9854654de4bf9834a760b9bb750b5&type=29&title=&page=2
    self.page = 1;
    NSString * root = @"http://route.showapi.com/255-1";
    NSDictionary * para = @{@"showapi_appid":AppID,
                            @"showapi_sign":AppSecret,
                            @"type":@"29",
                            @"title":@"",
                            @"page":@(self.page)};
    
    [[ZKNetWorkManager shareManager] requestWithType:requestTypePost urlString:root andParameters:para success:^(id responsderObj) {
        if (responsderObj) {
            NSArray * array = responsderObj[@"showapi_res_body"][@"pagebean"][@"contentlist"];
            NSLog(@"%@",array);
            self.listArray = [ZKFunsModel mj_objectArrayWithKeyValuesArray:array];
            [self.tableView reloadData];
            self.page ++;
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreListData {
    NSString * root = @"http://route.showapi.com/255-1";
    NSDictionary * para = @{@"showapi_appid":AppID,
                            @"showapi_sign":AppSecret,
                            @"type":@"29",
                            @"title":@"",
                            @"page":@(self.page)};
    
    [[ZKNetWorkManager shareManager] requestWithType:requestTypePost urlString:root andParameters:para success:^(id responsderObj) {
        if (responsderObj) {
            NSArray * array = responsderObj[@"showapi_res_body"][@"pagebean"][@"contentlist"];
            NSLog(@"%@",array);
            NSArray * items = [ZKFunsModel mj_objectArrayWithKeyValuesArray:array];
            [self.listArray addObjectsFromArray:items];
            [self.tableView reloadData];
            self.page ++;
        }
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError * error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row = self.listArray.count;
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSAssert(self.listArray.count!=0, @"listArray is Empty !!!!!!");
    ZKFunsModel * model = self.listArray[indexPath.row];
    ZKFunsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifider forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZKFunsModel * model = self.listArray[indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZKFunsModel * model = self.listArray[indexPath.row];
    ZKFunsDeailViewController * detailVC = [[ZKFunsDeailViewController alloc] init];
    detailVC.model = model;
    [self.navigationController pushViewController:detailVC animated:YES];
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
