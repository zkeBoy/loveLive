//
//  ZKMusicViewController.m
//  ZKSport
//
//  Created by Tom on 2017/11/15.
//  Copyright © 2017年 Tom. All rights reserved.
/*
 3=欧美
 4=流行榜
 5=内地
 6=港台
 16=韩国
 17=日本
 26=热歌
 27=新歌
 28=网络歌曲
 32=音乐人
 36=K歌金曲
 */

#import "ZKMusicViewController.h"
#import "ZKMusicTableViewCell.h"
#import "ZKMusicPlayView.h"

static NSString * const cellIdentifider = @"ZKMusicTableViewCell";

@interface ZKMusicViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * listArray;
@property (nonatomic, assign) NSInteger        page;
@property (nonatomic, strong) ZKMusicPlayView* musicPlayView;
@end

@implementation ZKMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"音乐", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addTableView];
    [self.view addSubview:self.musicPlayView];
    [self.musicPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.tableView);
        make.height.mas_equalTo(60);
    }];
}

- (void)addTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, NavBarH, D_WIDTH, D_HEIGHT-NavBarH-TabBarH);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    [self.tableView registerClass:[ZKMusicTableViewCell class] forCellReuseIdentifier:cellIdentifider];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadListData)];
    [self.tableView.mj_header beginRefreshing];
    //self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreListData)];
    [self.view addSubview:self.tableView];
}

- (void)addMusicPlayView {
    [self.view addSubview:self.musicPlayView];
}

- (void)loadListData{
    if (self.listArray.count) {
        [self.listArray removeAllObjects];
        [self.tableView reloadData];
    }
    self.page = 1;
    NSString * root = @"http://route.showapi.com/213-4";
    NSDictionary * para = @{@"showapi_appid":AppID,
                            @"showapi_sign":AppSecret,
                            @"topid":@"5"};
    [[ZKNetWorkManager shareManager] requestWithType:requestTypePost urlString:root andParameters:para success:^(id responsderObj) {
        if (responsderObj) {
            NSArray * array = responsderObj[@"showapi_res_body"][@"pagebean"][@"songlist"];
            self.listArray = [ZKMusicModel mj_objectArrayWithKeyValuesArray:array];
            self.page++;
            ZKMusicModel * empty = [[ZKMusicModel alloc] init];
            [self.listArray addObject:empty];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreListData{
    NSString * root = @"";
    NSDictionary * para = @{};
    [[ZKNetWorkManager shareManager] requestWithType:requestTypePost urlString:root andParameters:para success:^(id responsderObj) {
        if (responsderObj) {
            self.page++;
        }
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError * error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZKMusicModel * model = self.listArray[indexPath.row];
    ZKMusicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifider forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZKMusicModel * model = self.listArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.musicPlayView.musicModel = model;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - lazy init
- (ZKMusicPlayView *)musicPlayView {
    if (!_musicPlayView) {
        _musicPlayView = [[ZKMusicPlayView alloc] init];
    }
    return _musicPlayView;
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
