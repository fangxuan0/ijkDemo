//
//  HomeViewController.m
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/26.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#import "HomeViewController.h"
#import "SWHZhiBoListViewController.h"
#import "SWHCaptureViewController.h"
#import "GPUImageFilterViewController.h"
#import "SWHBeautifyFilterViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"直播";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIButton *ListBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width - 100, 40)];
    ListBtn.tag = 1;
    ListBtn.backgroundColor = [UIColor orangeColor];
    [ListBtn setTitle:@"直播列表" forState:UIControlStateNormal];
    ListBtn.layer.cornerRadius = 5;
    [ListBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ListBtn];
    
    UIButton *ListBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(ListBtn.frame) + 30, [UIScreen mainScreen].bounds.size.width - 100, 40)];
    ListBtn2.tag = 2;
    ListBtn2.backgroundColor = [UIColor orangeColor];
    [ListBtn2 setTitle:@"录制视频" forState:UIControlStateNormal];
    ListBtn2.layer.cornerRadius = 5;
    [ListBtn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ListBtn2];
    
    UIButton *ListBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(ListBtn2.frame) + 30, [UIScreen mainScreen].bounds.size.width - 100, 40)];
    ListBtn3.tag = 3;
    ListBtn3.backgroundColor = [UIColor orangeColor];
    [ListBtn3 setTitle:@"GPUImage原生美颜" forState:UIControlStateNormal];
    ListBtn3.layer.cornerRadius = 5;
    [ListBtn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ListBtn3];
    
    UIButton *ListBtn4 = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(ListBtn3.frame) + 30, [UIScreen mainScreen].bounds.size.width - 100, 40)];
    ListBtn4.tag = 4;
    ListBtn4.backgroundColor = [UIColor orangeColor];
    [ListBtn4 setTitle:@"利用美颜滤镜美颜" forState:UIControlStateNormal];
    ListBtn4.layer.cornerRadius = 5;
    [ListBtn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ListBtn4];
}

-(void)btnClick:(UIButton *)sender{
    if (1 == sender.tag) {
        SWHZhiBoListViewController *listV = [[SWHZhiBoListViewController alloc] init];
        listV.view.backgroundColor = [UIColor brownColor];
        [self.navigationController pushViewController:listV animated:YES];
    }else if(2 == sender.tag){
        SWHCaptureViewController *capV = [[SWHCaptureViewController alloc] init];
        [self.navigationController pushViewController:capV animated:YES];
    }else if (3 == sender.tag){
        NSLog(@"原生美颜");
        GPUImageFilterViewController *gpuImgV = [[GPUImageFilterViewController alloc] init];
        [self.navigationController pushViewController:gpuImgV animated:YES];
    }else if (4 == sender.tag){
        NSLog(@"美颜滤镜美颜");
        SWHBeautifyFilterViewController *beauV = [[SWHBeautifyFilterViewController alloc] init];
        [self.navigationController pushViewController:beauV animated:YES];
    }
    
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
