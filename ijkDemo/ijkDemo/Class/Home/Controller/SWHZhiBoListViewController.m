//
//  SWHZhiBoListViewController.m
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/27.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#import "SWHZhiBoListViewController.h"
#import <AFNetworking.h>
#import "SWHLiveModel.h"
#import <MJExtension.h>
#import "YZLiveCell.h"
#import "SWHLiveViewController.h"

static NSString * const ID = @"cell";
@interface SWHZhiBoListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

/** 直播 */
@property(nonatomic, strong) NSMutableArray *lives;

@end

@implementation SWHZhiBoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"直播列表";
    
    [self loadData];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YZLiveCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadData
{
    // 映客数据url
    NSString *urlStr = @"https://service.inke.cn/api/live/infos?id=1545991380050828%2C1545988369194163%2C1545994215334621%2C1545992879546384%2C1545963017246920&multiaddr=1&lc=0000000000000125&cc=TG0001&cv=IK7.0.01_Iphone&proto=13&idfa=AA1C6DA3-3219-47FA-952C-F19A8489A40A&idfv=378B2C1F-F7C2-49B2-9DF6-767D1C9D073C&devi=4ccb9895a6ef535300a1d4193ca177e5e546fba8&osversion=ios_12.100000&ua=iPhone8_1&imei=&imsi=&uid=716622970&sid=20T7xvzX6uXKufYYZ11wlqLXMoKSbzEHy3nQpljbJTqNsi0UaTxEhgi3&conn=WiFi&mtid=d41d8cd98f00b204e9800998ecf8427e&mtxid=&logid=270,213,226,243,10001,10206,30001&smid=D2jwoEeJWn%2FVWcdnd50oZX%2F9weGBPbS5cGUG7BadHTvZ4X6c&ndid=&ast=1&s_sg=89032a41cac906c1c3d05558ff8a1767&s_sc=100&s_st=1545994864";
    
    // 请求数据
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    __weak typeof(self) weakSelf = self;
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        weakSelf.lives = [SWHLiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lives.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.live = _lives[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWHLiveViewController *liveVc = [[SWHLiveViewController alloc] init];
    liveVc.live = _lives[indexPath.row];
    [self.navigationController pushViewController:liveVc animated:YES];

//    [self presentViewController:liveVc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 430;
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
