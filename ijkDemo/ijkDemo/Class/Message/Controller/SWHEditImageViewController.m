//
//  SWHEditImageViewController.m
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/27.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#define kWidth 50
#define kHeight 68

#import "SWHEditImageViewController.h"
#import "SWHButton.h"
#import "SWHAutoBeautyViewController.h"
#import "SWHColorListViewController.h"
#import "SWHFiltersViewController.h"

@interface SWHEditImageViewController (){
    UIColor *highlightedTextColor;
}

@property (nonatomic, strong)UIScrollView *scrollView;

@end

@implementation SWHEditImageViewController

- (id)initWithImage:(UIImage *)image
{
    if (self = [super init]) {
        self.image = image;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑图片";
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    imgV.height -= kHeight;
    imgV.image = self.image;
    [self.view addSubview:imgV];
    
    SWHButton *modeView = [SWHButton buttonWithType:UIButtonTypeCustom];
    [modeView setTitle:@"去美容" forState:UIControlStateNormal];
    [modeView setImage:[UIImage imageNamed:@"ic_function_meirong_a"] forState:UIControlStateNormal];
    [modeView setImage:[UIImage imageNamed:@"ic_function_meirong_b"] forState:UIControlStateHighlighted];
    [modeView setBackgroundColor:[UIColor clearColor]];
    [modeView.titleLabel setFont:[UIFont systemFontOfSize:10]];
    CGFloat beginY = SCREEN_HEIGHT - kHeight;
    modeView.frame = CGRectMake(SCREEN_WIDTH - kWidth, beginY + 3.5, kWidth, kHeight - 7);
    highlightedTextColor = [UIColor colorWithRed:19 / 255.0 green:105 / 255.0 blue:240 / 255.0 alpha:1.0];
    modeView.highlightedTextColor = highlightedTextColor;
    modeView.topPading = 3;
    [modeView addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - kWidth - 1, SCREEN_HEIGHT - kHeight + 9, 1, 50)];
    lineV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:modeView];
    [self.view addSubview:lineV];
    
    [self initScrolleView];
}

- (void)initScrolleView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kHeight, SCREEN_WIDTH - kWidth - 1, kHeight)];
    self.scrollView.contentSize = CGSizeMake(580, kHeight - 10);
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    NSArray *normalImageViewImageArr = [NSArray arrayWithObjects:@"icon_function_autoBeauty_a",
                                        @"icon_function_edit_a", @"icon_function_color_a", @"icon_function_stylize_a", @"icon_function_bokeh_a", @"icon_function_mohuanbi_a", @"icon_function_mosaic_a",
                                        @"icon_function_text_a", @"icon_function_border_a",
                                        nil];
    NSArray *hightlightedImageViewImageArr = [NSArray arrayWithObjects:@"icon_function_autoBeauty_b",
                                              @"icon_function_edit_b", @"icon_function_color_b", @"icon_function_stylize_b",  @"icon_function_bokeh_b",          @"icon_function_mohuanbi_b", @"icon_function_mosaic_b",
                                              @"icon_function_text_b", @"icon_function_border_b",
                                              nil];
    NSArray *textArr = [NSArray arrayWithObjects:@"智能优化", @"编辑", @"增强", @"特效", @"背景虚化", @"魔幻笔", @"马赛克", @"文字", @"边框", nil];
    
    //ox 4 pad 15
    SWHButton *btFunction = nil;
    int viewSpace = 15;
    int begainX = 4;
    for (int i = 0; i < 9; i++) {
        btFunction = [SWHButton buttonWithType:UIButtonTypeCustom];
        
        [btFunction setTitle:[textArr objectAtIndex:i] forState:UIControlStateNormal];
        [btFunction setImage:[UIImage imageNamed:[normalImageViewImageArr objectAtIndex:i]] forState:UIControlStateNormal];
        [btFunction setImage:[UIImage imageNamed:[hightlightedImageViewImageArr objectAtIndex:i]] forState:UIControlStateHighlighted];
        [btFunction setBackgroundColor:[UIColor clearColor]];
        [btFunction.titleLabel setFont:[UIFont systemFontOfSize:10]];
        btFunction.frame = CGRectMake(begainX + (kWidth + viewSpace) * i, 3.5, kWidth, kHeight - 7);
        highlightedTextColor = [UIColor colorWithRed:19 / 255.0 green:105 / 255.0 blue:240 / 255.0 alpha:1.0];
        btFunction.highlightedTextColor = highlightedTextColor;
        btFunction.topPading = 3;
        [btFunction addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btFunction];
    }
}

- (void)btnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *text = [btn titleLabel].text;
    
    if ([text isEqualToString:@"智能优化"])
    {
        SWHAutoBeautyViewController *vc = [[SWHAutoBeautyViewController alloc] initWithImage:self.image];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([text isEqualToString:@"增强"])
    {
        SWHColorListViewController *vc = [[SWHColorListViewController alloc] initWithImage:self.image];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([text isEqualToString:@"编辑"])
    {
//        FWEditViewController *vc = [[FWEditViewController alloc] initWithImage:self.image];
//        [self presentViewController:vc animated:YES completion:^{
//        }];
        
    }
    else if ([text isEqualToString:@"特效"])
    {
        SWHFiltersViewController *vc = [[SWHFiltersViewController alloc] initWithImage:self.image];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([text isEqualToString:@"边框"])
    {
//        FWBorderViewController *vc = [[FWBorderViewController alloc] initWithImage:self.image];
//        [self presentViewController:vc animated:YES completion:^{
//        }];
    }
    else if ([text isEqualToString:@"背景虚化"])
    {
//        FWBlurViewController *vc = [[FWBlurViewController alloc] initWithImage:self.image];
//        [self presentViewController:vc animated:YES completion:^{
//        }];
    }else{
        NSLog(@"去美容");
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
