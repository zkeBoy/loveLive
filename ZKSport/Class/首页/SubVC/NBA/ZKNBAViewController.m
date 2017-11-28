//
//  ZKNBAViewController.m
//  ZKSport
//
//  Created by Tom on 2017/11/15.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKNBAViewController.h"
#import "ZKHeaderTableViewCell.h"
#import "ZKContentTableViewCell.h"

static NSString * const linkString = @"http://c.m.163.com//nc/article/headline/T1348649145984/0-20.html";

@interface ZKNBAViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIView         * mainView;
@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * listArray;
@property (nonatomic, assign) NSInteger        page;
@end

static NSString * const cellHeaderIdentifider = @"ZKHeaderTableViewCell";
static NSString * const cellContentIdentifider = @"ZKContentTableViewCell";

@implementation ZKNBAViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"首页", nil);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
}

- (void)setTableView {
    self.mainView = [[UIView alloc] init];
    self.mainView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.mainView];
    self.mainView.frame = CGRectMake(0, NavBarH, D_WIDTH, D_HEIGHT-NavBarH-TabBarH);
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, D_WIDTH, CGRectGetHeight(self.mainView.frame));
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainView addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadListData];
    }];
    [self.tableView.mj_header beginRefreshing];
    /*
     self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
         [self loadMoreListData];
     }];
     */
    [self.tableView registerClass:[ZKHeaderTableViewCell class] forCellReuseIdentifier:cellHeaderIdentifider];
    [self.tableView registerClass:[ZKContentTableViewCell class] forCellReuseIdentifier:cellContentIdentifider];
}

- (void)loadListData{
    if (self.listArray.count) { //上啦到最上面,重新加载数据
        [self.listArray removeAllObjects];
        [self.tableView reloadData];
    }
    [[ZKNetWorkManager shareManager] requestWithType:requestTypeGet urlString:linkString andParameters:nil success:^(NSDictionary * responseObject) {
        if (responseObject) {
            NSString *key = [responseObject.keyEnumerator nextObject];
            NSArray  *temArray = responseObject[key];
            self.listArray = [ZKNBAModel mj_objectArrayWithKeyValuesArray:temArray];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreListData{
    
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZKNBAModel * NBA = [self.listArray objectAtIndex:indexPath.row];
    if (NBA.hasHead) { //头
        ZKHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellHeaderIdentifider forIndexPath:indexPath];
        cell.model = NBA;
        return cell;
    }else{
        ZKContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellContentIdentifider forIndexPath:indexPath];
        cell.model = NBA;
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegete
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ZKNBAModel * NBA = self.listArray[indexPath.row];
    NSString * src = NBA.url?NBA.url:NBA.url_3w;
    ZKWebViewController * webVC = [[ZKWebViewController alloc] initWithLinkURL:src];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:webVC];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZKNBAModel * NBA = [self.listArray objectAtIndex:indexPath.row];
    return NBA.cellHeight;;
}

#pragma mark -
- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
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
