//
//  SWHAutoBeautyViewController.m
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/28.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#import "SWHAutoBeautyViewController.h"
#import "SWHEffectBar.h"
#import "SWHEffectBarItem.h"
#import "FWApplyFilter.h"

@interface SWHAutoBeautyViewController ()<SWHEffectBarDelegate>

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, strong) UIImage *currentImage;

@end

@implementation SWHAutoBeautyViewController

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
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
    [self initView];
}

-(void)initView{
    //显示图片
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 115);
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
    
    SWHEffectBar *styleBar = [[SWHEffectBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 105, SCREEN_WIDTH, 55)];
    
    NSArray *normalImageArr = @[@"icon_autobeauty1_a", @"icon_autobeauty2_a", @"icon_autobeauty4_a", @"icon_autobeauty5_a", @"icon_autobeauty6_a", @"icon_autobeauty7_a", @"icon_autobeauty3_a"];
    NSArray *hightlightedImageArr = @[@"icon_autobeauty1_b", @"icon_autobeauty2_b", @"icon_autobeauty4_b", @"icon_autobeauty5_b", @"icon_autobeauty6_b", @"icon_autobeauty7_b", @"icon_autobeauty3_b"];
    NSArray *textArr = @[@"原图", @"自动", @"美食", @"静物", @"风景", @"去雾", @"人物"];
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < [textArr count]; i++)
    {
        SWHEffectBarItem *item = [[SWHEffectBarItem alloc] initWithFrame:CGRectZero];
        [item setFinishedSelectedImage:[UIImage imageNamed:[hightlightedImageArr objectAtIndex:i]] withFinishedUnselectedImage:[UIImage imageNamed:[normalImageArr objectAtIndex:i]] ];
        item.title = [textArr objectAtIndex:i];
        [items addObject:item];
    }
    styleBar.items = items;
    styleBar.effectBarDelegate = self;
    [styleBar setSelectedItem:[styleBar.items objectAtIndex:0]];
    [self effectBar:styleBar didSelectItemAtIndex:0];
    [self.view addSubview:styleBar];
}

#pragma mark - FWEffectBarDelegate
- (void)effectBar:(SWHEffectBar *)bar didSelectItemAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            self.currentImage = self.image;
            break;
            
        case 1:
            self.currentImage = [FWApplyFilter autoBeautyFilter:self.image];
            break;
            
        case 2:
            self.currentImage = [FWApplyFilter applyHudsonFilter:self.image];
            break;
            
        case 3:
            self.currentImage = [FWApplyFilter applyStaticFilter:self.image];
            break;
            
        case 4:
            self.currentImage = [FWApplyFilter applyViewFilter:self.image];
            break;
            
        case 5:
            self.currentImage = [FWApplyFilter applyLomo1Filter:self.image];
            break;
            
        case 6:
            self.currentImage = [FWApplyFilter applyNashvilleFilter:self.image];
            break;
    }
    self.imageView.image = self.currentImage;
    
}

//保存与取消操作
- (void)btnCancelOrSaveClicked:(UIButton *)sender
{
    if (100 == sender.tag) {
        
    }else if(101 == sender.tag){
        UIImageWriteToSavedPhotosAlbum(self.currentImage, nil, nil, nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
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
