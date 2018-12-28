//
//  SWHFiltersViewController.m
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/28.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#define kWidth 50
#define kHeight 70
#define kSpace 22

#import "SWHFiltersViewController.h"
#import "SWHEffectBar.h"
#import "SWHEffectBarItem.h"
#import "FWApplyFilter.h"
#import "UIImage+ImageScale.h"

@interface SWHFiltersViewController ()<SWHEffectBarDelegate>

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, strong) UIImage *currentImage;
@property (nonatomic, strong) SWHEffectBar *filterStyleBar;

@property BOOL isBlurActivate;
@property BOOL isDarkCornerActivate;

@end

@implementation SWHFiltersViewController

- (instancetype)initWithImage:(UIImage *)image
{
    if (self = [super init])
    {
        if (image.imageOrientation == UIImageOrientationUp) {
            self.image = image;
        }else{
            UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
            [image drawInRect:(CGRect){0, 0, image.size}];
            UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            self.image = normalizedImage;
        }
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self initView];
}

-(void)initView{
    //显示图片
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 120);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.imageView.image = self.image;
    [self.view addSubview:self.imageView];
    
    //保存与取消按钮的添加
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClose.tag = 100;
    [btnClose setImage:[UIImage imageNamed:@"btn_cancel_a"] forState:UIControlStateNormal];
    btnClose.frame = CGRectMake(20, SCREEN_HEIGHT - SureBtnWH - 10, SureBtnWH, SureBtnWH);
    [btnClose addTarget:self action:@selector(btnCancelOrSaveClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnClose];
    
    UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSave.tag = 101;
    [btnSave setImage:[UIImage imageNamed:@"btn_ok_a"] forState:UIControlStateNormal];
    btnSave.frame = CGRectMake(SCREEN_WIDTH - SureBtnWH - 20, SCREEN_HEIGHT - SureBtnWH - 10, SureBtnWH, SureBtnWH);
    [self.view addSubview:btnSave];
    [btnSave addTarget:self action:@selector(btnCancelOrSaveClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    SWHEffectBar *styleBar = [[SWHEffectBar alloc] initWithFrame:CGRectMake(SureBtnWH + 40, btnSave.y, SCREEN_WIDTH - SureBtnWH * 2 - 80, SureBtnWH)];
    NSArray *textArr = @[@"LOMO", @"美颜", @"格调", @"艺术"];
    styleBar.tag = 104;
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < [textArr count]; i++)
    {
        SWHEffectBarItem *item = [[SWHEffectBarItem alloc] initWithFrame:CGRectZero];
        item.title = [textArr objectAtIndex:i];
        [items addObject:item];
    }
    styleBar.items = items;
    styleBar.effectBarDelegate = self;
    [styleBar setSelectedItem:[styleBar.items objectAtIndex:0]];
    [self effectBar:styleBar didSelectItemAtIndex:0];
    [self.view addSubview:styleBar];
    
    UIButton * btnBlur = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBlur setImage:[UIImage imageNamed:@"blur_deactivated"] forState:UIControlStateNormal];
    self.isBlurActivate = NO;
    btnBlur.frame = CGRectMake(10, SCREEN_HEIGHT - 45 - 70, 25, 25);
    [btnBlur addTarget:self action:@selector(btnBlurClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnBlur.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnBlur];
    
    UIButton * btnDark = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDark setImage:[UIImage imageNamed:@"dark_corner_deactivated"] forState:UIControlStateNormal];
    self.isDarkCornerActivate = NO;
    btnDark.frame = CGRectMake(10, SCREEN_HEIGHT - 10 - 70, 25, 25);
    [btnDark addTarget:self action:@selector(btnDarkClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnDark.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnDark];
    
    self.filterStyleBar = [[SWHEffectBar alloc] initWithFrame:CGRectMake(50, SCREEN_HEIGHT - 50 - kHeight, SCREEN_WIDTH - 70, kHeight)];
    self.filterStyleBar.effectBarDelegate = self;
    self.filterStyleBar.itemBeginX = 15.0;
    self.filterStyleBar.itemWidth = 50.0;
    self.filterStyleBar.margin = 10.0;
    [self.view addSubview:self.filterStyleBar];
    [self setupLOMOFilter];
}

- (void)btnBlurClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (self.isBlurActivate)
    {
        [btn setImage:[UIImage imageNamed:@"blur_deactivated"] forState:UIControlStateNormal];
        self.isBlurActivate = NO;
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"blur_activated"] forState:UIControlStateNormal];
        self.isBlurActivate = YES;
    }
}

- (void)btnDarkClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (self.isBlurActivate)
    {
        [btn setImage:[UIImage imageNamed:@"dark_corner_deactivated"] forState:UIControlStateNormal];
        self.isDarkCornerActivate = NO;
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"dark_corner_activated"] forState:UIControlStateNormal];
        self.isDarkCornerActivate = YES;
    }
}

- (UIImage *)getAddedFilterImage:(UIImage *)image andIndex:(int)index{
    switch (index) {
        case 0:
            return image;
            break;
            
        case 1:
            return [FWApplyFilter applyLomofiFilter:image];
            break;
            
        case 2:
            return [FWApplyFilter applyLomo1Filter:image];
            break;
            
        case 3:
            return [FWApplyFilter applyMissetikateFilter:image];
            break;
            
        case 4:
            return [FWApplyFilter applyNashvilleFilter:image];
            break;
            
        case 5:
            return [FWApplyFilter applyLordKelvinFilter:image];
            break;
            
        case 6:
            return [FWApplyFilter applyAmatorkaFilter:image];
            break;
            
        case 7:
            return [FWApplyFilter applyRiseFilter:image];
            break;
            
        case 8:
            return [FWApplyFilter applyHudsonFilter:image];
            break;
            
        case 9:
            return [FWApplyFilter applyXproIIFilter:image];
            break;
            
        case 10:
            return [FWApplyFilter apply1977Filter:image];
            break;
            
        case 11:
            return [FWApplyFilter applyValenciaFilter:image];
            break;
            
        case 12:
            return [FWApplyFilter applyWaldenFilter:image];
            break;
            
        case 13:
            return [FWApplyFilter applyLocalBinaryPatternFilter:image];
            break;
            
        case 14:
            return [FWApplyFilter applyInkwellFilter:image];
            break;
            
        case 15:
            return [FWApplyFilter applySierraFilter:image];
            break;
            
        case 16:
            return [FWApplyFilter applyEarlybirdFilter:image];
            break;
            
        case 17:
            return [FWApplyFilter applySutroFilter:image];
            break;
            
        case 18:
            return [FWApplyFilter applyToasterFilter:image];
            break;
            
        case 19:
            return [FWApplyFilter applyBrannanFilter:image];
            break;
            
        case 20:
            return  [FWApplyFilter applyHefeFilter:image];
            break;
        default:
            return image;
    }
}

- (void)setupFilterWithNormalImages:(NSArray *)normalImages HighlightImages:(NSArray *)highlightImages titles:(NSArray *)titles
{
    SWHEffectBarItem *item = nil;
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < [titles count]; i++)
    {
        item = [[SWHEffectBarItem alloc] initWithFrame:CGRectMake((kWidth + kSpace) * i + 10, 0, kWidth, kHeight)];
        item.titleOverlay = YES;
        item.backgroundColor = [UIColor blackColor];
        UIImage *img = [UIImage scaleImage:self.image targetHeight:70];
        UIImage *newImg = [self getAddedFilterImage:img andIndex:i];
        [item setFinishedSelectedImage:newImg withFinishedUnselectedImage:newImg];
        item.title = [titles objectAtIndex:i];
        [items addObject:item];
    }
    
    self.filterStyleBar.items = items;
}

//简单边框视图
- (void)setupLOMOFilter
{
    [self setupFilterWithNormalImages:nil HighlightImages:nil titles:[NSArray arrayWithObjects:@"原图", @"LOMO", @"流年", @"HDR", @"碧波", @"上野", @"优格", @"彩虹瀑", @"云端", @"淡雅", @"粉红佳人", @"复古", @"候鸟", @"黑白", @"一九〇〇", @"古铜色", @"哥特风", @"移轴", @"TEST1", @"TEST2", @"TEST3", nil]];
}

//海报边框视图
- (void)setupBeautyFilter
{
    [self setupFilterWithNormalImages:nil HighlightImages:nil titles:[NSArray arrayWithObjects:@"原图", @"经典LOMO", @"流年", @"HDR", @"碧波", @"上野", @"优格", @"彩虹瀑", @"云端", @"淡雅", @"粉红佳人", @"复古", @"候鸟", @"黑白", @"一九〇〇", @"古铜色", @"哥特风", @"移轴",nil]];
}

//炫彩边框视图
- (void)setupPatternFilter
{
    [self setupFilterWithNormalImages:nil HighlightImages:nil titles:[NSArray arrayWithObjects:@"原图", @"经典LOMO", @"流年", @"HDR", @"碧波", @"上野", @"优格", @"彩虹瀑", @"云端", @"淡雅", @"粉红佳人", @"复古", @"候鸟", @"黑白", @"一九〇〇", @"古铜色", @"哥特风", @"移轴",nil]];
}

- (void)setupArtistFilter
{
    [self setupFilterWithNormalImages:nil HighlightImages:nil titles:[NSArray arrayWithObjects:@"原图", @"经典LOMO", @"流年", @"HDR", @"碧波", @"上野", @"优格", @"彩虹瀑", @"云端", @"淡雅", @"粉红佳人", @"复古", @"候鸟", @"黑白", @"一九〇〇", @"古铜色", @"哥特风", @"移轴",nil]];
}

#pragma mark - FWEffectBarDelegate
- (void)effectBar:(SWHEffectBar *)bar didSelectItemAtIndex:(NSInteger)index
{
    if (104 == bar.tag)
    {
        switch (index) {
            case 0:
                [self setupLOMOFilter];
                break;
                
            case 1:
                [self setupBeautyFilter];
                break;
                
            case 2:
                [self setupPatternFilter];
                break;
                
            case 3:
                [self setupArtistFilter];
                break;
        }
        
        SWHEffectBarItem *item = (SWHEffectBarItem *)[self.filterStyleBar.items objectAtIndex:0];
        item.ShowBorder = YES;
        self.imageView.image = self.image;
        [self.filterStyleBar scrollRectToVisible:item.frame  animated:YES];
    }
    else
    {
        SWHEffectBarItem *item = (SWHEffectBarItem *)[bar.items objectAtIndex:index];
        item.ShowBorder = YES;
//        [self.filterStyleBar scrollRectToVisible:item.frame  animated:YES];
        self.imageView.image = [self getAddedFilterImage:self.image andIndex:(int)index];
        
    }
}

//保存与取消操作
- (void)btnCancelOrSaveClicked:(UIButton *)sender
{
    if (100 == sender.tag) {
        
    }else if(101 == sender.tag){
        UIImageWriteToSavedPhotosAlbum(self.currentImage, nil, nil, nil);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
