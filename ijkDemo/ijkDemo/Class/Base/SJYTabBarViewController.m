//
//  SJYTabBarViewController.m
//  xizang
//
//  Created by iOSOneGpowerMobile on 16/12/7.
//  Copyright © 2016年 iOSOneGpowerMobile. All rights reserved.
//

#import "SJYTabBarViewController.h"
#import "UIImage+Extension.h"
#import "YMDNavigationController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "TopicViewController.h"
#import "MineViewController.h"

#define YMDColor(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]
#define YMDGolbalGreen YMDColor(0, 216, 200)

@interface SJYTabBarViewController ()

@property(nonatomic,assign)NSInteger currentIndex;

@end

@implementation SJYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 解决返回时tabbar的内容上移的问题
    [[UITabBar appearance] setTranslucent:NO];
    
    // 添加所有的子控制器
    [self addAllChildVcs];
}


/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs
{
    HomeViewController *home = [[HomeViewController alloc] init];
    [self addOneChlildVc:home title:@"直播" imageName:@"guang" selectedImageName:@"guang_selected"];

    MessageViewController *discover = [[MessageViewController alloc] init];
    [self addOneChlildVc:discover title:@"美图" imageName:@"ting" selectedImageName:@"ting_selected"];
    
    TopicViewController *message = [[TopicViewController alloc] init];
    [self addOneChlildVc:message title:@"话题" imageName:@"liao" selectedImageName:@"liao_selected"];
    
    MineViewController *my = [[MineViewController alloc] init];
    [self addOneChlildVc:my title:@"我的" imageName:@"wo" selectedImageName:@"wo_selected"];
    
}



/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
//    // 设置标题
//    childVc.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    childVc.tabBarItem.title = title;
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = YMDGolbalGreen;
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    YMDNavigationController *nav = [[YMDNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

- (void)dealloc
{
    //    NSLog(@"第二个控制器销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"answer"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"ask"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"bound"
                                                  object:nil];
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
