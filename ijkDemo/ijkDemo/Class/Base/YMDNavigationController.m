//
//  YMDNavigationController.m
//  盐米多
//
//  Created by iOSOneGpowerMobile on 16/6/2.
//  Copyright © 2016年 iOSOneGpowerMobile. All rights reserved.
//

#import "YMDNavigationController.h"

@interface YMDNavigationController () <UIGestureRecognizerDelegate>


@end

@implementation YMDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //清空interactivePopGestureRecognizer的delegate可以恢复因替换导航条的back按钮失去系统默认手势
    self.interactivePopGestureRecognizer.delegate = nil;
    //禁止手势冲突
//    self.interactivePopGestureRecognizer.enabled = NO;
    
    //导航栏颜色为黑色
    [UINavigationBar appearance].barTintColor = SWHBlueColor;//Color(44, 45, 46);
    //导航栏按钮颜色为白色
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    //在runtime中查到的系统tagert 和方法名 手动添加手势，调用系统的方法,这个警告看着不爽，我直接强制去掉了~
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wundeclared-selector"
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
//#pragma clang diagnostic pop
//    
//    pan.delegate = self;
//    
//    [self.view addGestureRecognizer:pan];
    
//    [bar setBackgroundImage:[UIImage imageNamed:@"tta"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    
    //统一设置导航头的字体大小
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:dict];
    
    self.navigationBar.translucent = YES;
    
}

//-(void)viewWillAppear:(BOOL)animated{
//
//    [super viewWillAppear:animated];
//    //设置导航栏下面没有灰色的分割线
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"tta"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[UIImage new]];
//    
//}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    if (self.viewControllers.count > 0) {
//        [viewController.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"tt"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forBarMetrics:UIBarMetricsDefault];
        viewController.hidesBottomBarWhenPushed = YES;
        //重新设置返回按钮
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
        leftBtn.frame = CGRectMake(0, 0, 50, 30);
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 25);
        [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        
        UIBarButtonItem *leftItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        leftItem1.width = -20;
        viewController.navigationItem.leftBarButtonItems = @[leftItem1 , leftItem];
        
        
    }
    
    [super pushViewController:viewController animated:animated];

}

//返回按钮点击事件
-(void)back{
    [self popViewControllerAnimated:YES];
}

//+ (void)initialize{
//    
//    UINavigationBar *bar = [UINavigationBar appearance];
//    [bar setBackgroundImage:[UIImage imageNamed:@"tta"] forBarMetrics:UIBarMetricsDefault];
////    [bar setShadowImage:[UIImage new]];
//    //去掉导航条的半透明
//    bar.translucent = NO;
//    
//    //统一设置导航头的字体大小
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
//    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
//    [bar setTitleTextAttributes:dict];
//}

#pragma mark - 手势代理方法
// 是否开始触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 判断下当前控制器是否是跟控制器
    return (self.topViewController != [self.viewControllers firstObject]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
