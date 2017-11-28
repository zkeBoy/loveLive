//
//  ZKCFootBallViewController.m
//  ZKSport
//
//  Created by Tom on 2017/11/15.
//  Copyright © 2017年 Tom. All rights reserved.
//  T1348649503389

#import "ZKCFootBallViewController.h"
#import "ZKCFootBallContentViewCell.h"
#import "ZKCFootBallViewCell.h"

static NSString * const cellCHeaderIdentifider  = @"ZKCFootBallContentViewCell";
static NSString * const cellCContentIdentifider = @"ZKCFootBallViewCell";
static NSString * const linkString = @"http://c.m.163.com//nc/article/headline/T1348649503389/0-20.html";

@interface ZKCFootBallViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * listArray;
@end

@implementation ZKCFootBallViewController

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
    [self.tableView registerClass:[ZKCFootBallViewCell class] forCellReuseIdentifier:cellCHeaderIdentifider];
    [self.tableView registerClass:[ZKCFootBallContentViewCell class] forCellReuseIdentifier:cellCContentIdentifider];
    [self.view addSubview:self.tableView];
}

- (void)loadListData {
    if (self.listArray.count) {
        [self.listArray removeAllObjects];
        [self.tableView reloadData];
    }
    [[ZKNetWorkManager shareManager] requestWithType:requestTypeGet urlString:linkString andParameters:nil success:^(NSDictionary * responsderObj) {
        if (responsderObj) {
            NSString * key = responsderObj.keyEnumerator.nextObject;
            NSArray * array = responsderObj[key];
            self.listArray = [ZKCFootBallModel mj_objectArrayWithKeyValuesArray:array];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadMoreListData {
    
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZKCFootBallModel * model = self.listArray[indexPath.row];
    if (model.imgextra) {
        ZKCFootBallViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellCHeaderIdentifider forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else{
        ZKCFootBallContentViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellCContentIdentifider forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZKCFootBallModel * model = self.listArray[indexPath.row];
    return model.cellHeight;
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
