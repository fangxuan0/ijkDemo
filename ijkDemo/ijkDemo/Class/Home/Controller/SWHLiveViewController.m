//
//  SWHLiveViewController.m
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/27.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#import "SWHLiveViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "SWHLiveModel.h"
#import "SWHCreaorModel.h"
#import <UIImageView+WebCache.h>

@interface SWHLiveViewController ()

@property (nonatomic, strong)UIImageView *imgV;
@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@end

@implementation SWHLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imgV];
    
    // 设置直播占位图片
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_live.creator.portrait]];
    [imgV sd_setImageWithURL:imageUrl placeholderImage:nil];
    
    // 拉流地址
    NSURL *url = [NSURL URLWithString:_live.stream_addr];
    
    // 创建IJKFFMoviePlayerController：专门用来直播，传入拉流地址就好了
    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    
    // 准备播放
    [playerVc prepareToPlay];
    
    // 强引用，防止被销毁
    _player = playerVc;
    
    playerVc.view.frame = [UIScreen mainScreen].bounds;
    
    [self.view insertSubview:playerVc.view atIndex:1];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    // 界面消失，一定要记得停止播放，要不会内存溢出
    [_player pause];
    [_player stop];
    [_player shutdown];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
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
