//
//  ZKFashionViewController.m
//  ZKSport
//
//  Created by Tom on 2017/11/15.
//  Copyright © 2017年 Tom. All rights reserved.
//  T1348650593803
//  http://c.m.163.com//nc/article/headline/T1348650593803/0-20.html

/*
 NSString *str = [photosetID substringFromIndex:4];     // 0001|107920
 NSArray *arr = [str componentsSeparatedByString:@"|"]; // @[@"0001", @"107920"]
 NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json", arr[0], arr[1]];
 */

#import "ZKFashionViewController.h"
#import "ZKFashionSmallViewCell.h"
#import "ZKFashionViewCell.h"
#import "ZKPictureDetailViewController.h"

static NSString * const cellIdentifider = @"ZKFashionViewCell";
static NSString * const cellSmallIdentifider = @"ZKFashionSmallViewCell";

@interface ZKFashionViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * listArray;
@end

@implementation ZKFashionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"时尚", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpTableView];
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, NavBarH, D_WIDTH, D_HEIGHT-NavBarH-TabBarH);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadListData)];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView registerClass:[ZKFashionSmallViewCell class] forCellReuseIdentifier:cellSmallIdentifider];
    [self.tableView registerClass:[ZKFashionViewCell class] forCellReuseIdentifier:cellIdentifider];
}

- (void)loadListData {
    if (self.listArray.count) {
        [self.listArray removeAllObjects];
        [self.tableView reloadData];
    }
    NSString * linkString = @"http://c.m.163.com//nc/article/headline/T1348650593803/0-20.html";
    [[ZKNetWorkManager shareManager] requestWithType:requestTypeGet urlString:linkString andParameters:nil success:^(NSDictionary * responsderObj) {
        if (responsderObj) {
            NSString * key = [responsderObj.keyEnumerator nextObject];
            NSArray * array = responsderObj[key];
            self.listArray = [ZKFashionModel mj_objectArrayWithKeyValuesArray:array];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZKFashionModel * model = self.listArray[indexPath.row];
    if (model.imgextra) {
        ZKFashionViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifider forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else{
        ZKFashionSmallViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellSmallIdentifider forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ZKFashionModel * model = self.listArray[indexPath.row];
    NSString * photosetID = model.photosetID;
    if (photosetID) {
        NSString *str = [photosetID substringFromIndex:4]; // 0001|107920
        NSArray *arr = [str componentsSeparatedByString:@"|"]; // @[@"0001", @"107920"]
        NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json", arr[0], arr[1]];
        ZKPictureDetailViewController * pictureVC = [[ZKPictureDetailViewController alloc] init];
        pictureVC.jsonString = urlString;
        [self.navigationController pushViewController:pictureVC animated:YES];
    }else{
        NSString * src = model.url?model.url:model.url_3w;
        ZKWebViewController * webVC = [[ZKWebViewController alloc] initWithLinkURL:src];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:webVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZKFashionModel * model = self.listArray[indexPath.row];
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
