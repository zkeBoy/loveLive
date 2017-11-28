//
//  ZKLiveViewController.m
//  ZKSport
//
//  Created by Tom on 2017/11/22.
//  Copyright © 2017年 Tom. All rights reserved.
//

#import "ZKLiveViewController.h"

@interface ZKLiveViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>
@property (nonatomic, strong) UITableView        * tableView;
@property (nonatomic, strong) UISearchController * searchController;
@property (nonatomic, strong) NSMutableArray     * listArray;

@end

@implementation ZKLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpNavBarItem];
    [self setUpTableView];
    [self setUpSearchController];
}

- (void)setUpNavBarItem {
    UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = left;
    [left setImageInsets:UIEdgeInsetsMake(4, -4, 4, 0)];
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, NavBarH, D_WIDTH, D_HEIGHT-NavBarH);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    /*
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadLiveData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreLiveData)];
     */
}

- (void)setUpSearchController{
    UISearchController *search = [[UISearchController alloc] initWithSearchResultsController:nil];
    search.searchResultsUpdater = self;
    search.dimsBackgroundDuringPresentation = NO;
    self.searchController = search;
    self.tableView.tableHeaderView = search.searchBar;
    self.definesPresentationContext = YES;
}

- (void)loadLiveData {
    if (self.listArray.count) {
        [self.listArray removeAllObjects];
    }
    NSString * root = @"http://route.showapi.com/1164-1";
    NSDictionary * para = @{};
    [[ZKNetWorkManager shareManager] requestWithType:requestTypePost urlString:root andParameters:para success:^(id responsderObj) {
        if (responsderObj) {
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreLiveData {
    
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    //NSString *inputStr = searchController.searchBar.text;
    
    /*
    for (NSString *str in self.datas) {
        
        if ([str.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
            
            
        }
    }*/
    
    [self.tableView reloadData];
}

#pragma mark - Private Method
- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"ZKLiveViewController dealloc !!!!!!");
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
