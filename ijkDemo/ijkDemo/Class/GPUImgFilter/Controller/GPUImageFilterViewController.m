//
//  GPUImageFilterViewController.m
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/27.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#import "GPUImageFilterViewController.h"
#import <GPUImage/GPUImage.h>

@interface GPUImageFilterViewController ()

@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, weak) GPUImageBilateralFilter *bilateralFilter;
@property (nonatomic, weak) GPUImageBrightnessFilter *brightnessFilter;
@property (nonatomic, weak) GPUImageSepiaFilter *sepiaFilter;

@end

@implementation GPUImageFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"原生美颜";
    self.view.backgroundColor = SWHAllBackGroundColor;
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 100, SCREEN_WIDTH - 40, 10)];
    slider.tag = 10;
    slider.minimumValue = 0.0;
    slider.maximumValue = 0.3;
    [slider setContinuous:YES];
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    UISlider *slider1 = [[UISlider alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 50, SCREEN_WIDTH - 40, 10)];
    slider1.tag = 11;
    slider1.minimumValue = 5.0;
    slider1.maximumValue = 10.0;
    [slider1 setContinuous:YES];
    [slider1 addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider1];
    
    [self setVideo];
}

// 修改美白效果
- (void)sliderChange:(UISlider *)sender{
    if (10 == sender.tag) {
        // 取值为-1.0 ~ 1.0之间,默认是0.0
        _brightnessFilter.brightness = sender.value;
    }else{
        // 值越小，磨皮效果越好
        CGFloat maxValue = 10;
        [_bilateralFilter setDistanceNormalizationFactor:(maxValue - sender.value)];
    }
}

-(void)setVideo{
    // 创建视频源
    // SessionPreset:屏幕分辨率，AVCaptureSessionPresetHigh会自适应高分辨率
    // cameraPosition:摄像头方向
    // 最好使用AVCaptureSessionPresetHigh，会自动识别，如果用太高分辨率，当前设备不支持会直接报错
    GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _videoCamera = videoCamera;
    
    // 创建最终预览View
    GPUImageView *captureVideoPreview = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:captureVideoPreview atIndex:0];
    
    // 创建滤镜：磨皮，美白，组合滤镜
    GPUImageFilterGroup *groupFilter = [[GPUImageFilterGroup alloc] init];
    
    // 磨皮滤镜
    GPUImageBilateralFilter *bilateralFilter = [[GPUImageBilateralFilter alloc] init];
    [groupFilter addTarget:bilateralFilter];
    _bilateralFilter = bilateralFilter;
    
    // 美白滤镜
    GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    [groupFilter addTarget:brightnessFilter];
    _brightnessFilter = brightnessFilter;
    
    // 怀旧filter(褐色老照片那种)
    GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
    [groupFilter addTarget:sepiaFilter];
    _sepiaFilter = sepiaFilter;
    
    // 设置滤镜组链
    [bilateralFilter addTarget:brightnessFilter];
    [brightnessFilter addTarget:sepiaFilter];
    // 设置初始滤镜
    [groupFilter setInitialFilters:@[bilateralFilter]];
    // 设置最后的滤镜
    groupFilter.terminalFilter = sepiaFilter;
    
    // 设置GPUImage处理链，从数据源 => 滤镜 => 最终界面效果
    [videoCamera addTarget:groupFilter];
    [groupFilter addTarget:captureVideoPreview];
    
    // 必须调用startCameraCapture，底层才会把采集到的视频源，渲染到GPUImageView中，就能显示了。
    // 开始采集视频
    [videoCamera startCameraCapture];
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
