//
//  ZKGFootBallViewController.m
//  ZKSport
//
//  Created by Tom on 2017/11/15.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKGFootBallViewController.h"
#import "ZKGBigTableViewCell.h"
#import "ZKGSmallTableViewCell.h"
static NSString * const linkString = @"http://c.m.163.com//nc/article/headline/T1348649176279/0-20.html";
@interface ZKGFootBallViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * listArray;
@property (nonatomic, assign) NSInteger        page;
@end

static NSString * const bigCellIdentifider   = @"ZKGBigTableViewCell";
static NSString * const smallCellIdentifider = @"ZKGSmallTableViewCell";

@implementation ZKGFootBallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addTableView];
}

- (void)addTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, D_WIDTH, D_HEIGHT-NavBarH-TabBarH-30);
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadListData];
    }];
    [self.tableView.mj_header beginRefreshing];
    /*
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreListData];
    }];
     */
    [self.tableView registerClass:[ZKGBigTableViewCell class] forCellReuseIdentifier:bigCellIdentifider];
    [self.tableView registerClass:[ZKGSmallTableViewCell class] forCellReuseIdentifier:smallCellIdentifider];
    [self.view addSubview:self.tableView];
}

#pragma mark - loadListData
- (void)loadListData {
    [[ZKNetWorkManager shareManager] requestWithType:requestTypeGet urlString:linkString andParameters:nil success:^(NSDictionary * responderObj) {
        if (responderObj) {
            NSString * key = [responderObj.keyEnumerator nextObject];
            NSArray * array = responderObj[key];
            self.listArray = [ZKGFootBallModel mj_objectArrayWithKeyValuesArray:array];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreListData {
    
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZKGFootBallModel * footModel = self.listArray[indexPath.row];
    if (footModel.imgextra) {
        ZKGBigTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:bigCellIdentifider forIndexPath:indexPath];
        cell.model = footModel;
        return cell;
    }else {
        ZKGSmallTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:smallCellIdentifider forIndexPath:indexPath];
        cell.model = footModel;
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZKGFootBallModel * footModel = self.listArray[indexPath.row];
    return footModel.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZKGFootBallModel * footModel = self.listArray[indexPath.row];
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
