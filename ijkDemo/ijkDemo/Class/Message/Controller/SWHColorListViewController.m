//
//  SWHColorListViewController.m
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/28.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#import "SWHColorListViewController.h"
#import "SWHEffectBar.h"
#import "SWHEffectBarItem.h"
#import "FWApplyFilter.h"

@interface SWHColorListViewController ()<SWHEffectBarDelegate>

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, strong) UIImage *currentImage;
@property (nonatomic, strong)UISlider *slider;

@property NSInteger selectedIndex;

@end

@implementation SWHColorListViewController

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
    
    [self initView];
    [self setupSlider];
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
    
    NSArray *normalImageArr = @[@"icon_brightness_a", @"icon_contrast_a", @"icon_colourTemperature_a", @"icon_saturation_a", @"icon_hightLight_a", @"icon_shade_a", @"icon_fillinlight_a"];
    NSArray *hightlightedImageArr = @[@"icon_brightness_b", @"icon_contrast_b", @"icon_colourTemperature_b", @"icon_saturation_b", @"icon_hightLight_b", @"icon_shade_b", @"icon_fillinlight_b"];
    NSArray *textArr = @[@"亮度", @"对比度", @"色温", @"饱和度", @"高光", @"暗部", @"智能补光"];
    
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

- (void)setupSlider
{
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 115 - 40, SCREEN_WIDTH, 40)];
    subview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:subview];
    
    self.slider = [[UISlider alloc] initWithFrame:CGRectZero];
    self.slider.minimumValue = -0.5;
    self.slider.maximumValue = 0.5;
    self.slider.value = 0;
    self.slider.frame = CGRectMake(SCREEN_WIDTH / 2 - 100, 10, 200, 20);
    [self.slider addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
    [self.slider setThumbImage:[UIImage imageNamed:@"icon_slider_thumb"] forState:UIControlStateNormal];
    
    [subview addSubview:self.slider];
    
}


#pragma mark - FWEffectBarDelegate
- (void)effectBar:(SWHEffectBar *)bar didSelectItemAtIndex:(NSInteger)index
{
    self.selectedIndex = index;
    switch (index) {
        case 0:
            self.slider.minimumValue = -.5;
            self.slider.maximumValue = 0.5;
            self.slider.value = 0.0;
            break;
            
        case 1:
            self.slider.minimumValue = 0.1;
            self.slider.maximumValue = 1.9;
            self.slider.value = 1.0;
            
            break;
            
        case 2:
            self.slider.minimumValue = 1000;
            self.slider.maximumValue = 10000;
            self.slider.value = 5000;
            
            break;
            
        case 3:
            self.slider.minimumValue = 0.0;
            self.slider.maximumValue = 2.0;
            self.slider.value = 1.0;
            break;
            
        case 4:
            self.slider.minimumValue = 0.0;
            self.slider.maximumValue = 1.0;
            self.slider.value = 0.5;
            break;
            
        case 5:
            self.slider.minimumValue = 0.0;
            self.slider.maximumValue = 1.0;
            self.slider.value = 0.5;
            break;
            
        case 6:
            self.slider.minimumValue = -5;
            self.slider.maximumValue = 5;
            self.slider.value = 0;
            break;
            
        default:
            break;
    }
}

- (void)updateValue:(id)sender
{
    switch (self.selectedIndex) {
        case 0:
            self.currentImage = [FWApplyFilter changeValueForBrightnessFilter:self.slider.value image:self.image];
            break;
            
        case 1:
            self.currentImage = [FWApplyFilter changeValueForContrastFilter:self.slider.value image:self.image];
            self.imageView.image =   self.currentImage;
            break;
            
        case 2:
            self.currentImage = [FWApplyFilter changeValueForWhiteBalanceFilter:self.slider.value image:self.image];
            break;
            
        case 3:
            self.currentImage = [FWApplyFilter changeValueForSaturationFilter:self.slider.value image:self.image];
            break;
            
        case 4:
            self.currentImage = [FWApplyFilter changeValueForHightlightFilter:self.slider.value image:self.image];
            break;
            
        case 5:
            self.currentImage = [FWApplyFilter changeValueForLowlightFilter:self.slider.value image:self.image];
            break;
            
        case 6:
            self.currentImage = [FWApplyFilter changeValueForExposureFilter:self.slider.value image:self.image];
            break;
            
        default:
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
