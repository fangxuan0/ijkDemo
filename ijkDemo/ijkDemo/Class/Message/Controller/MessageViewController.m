//
//  MessageViewController.m
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/26.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#import "MessageViewController.h"
#import "SWHEditImageViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface MessageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"美图功能";
    self.view.backgroundColor = SWHAllBackGroundColor;
    
    NSArray *titleArr = @[@"相册选取", @"拍照"];
    
    for (int i = 0; i < titleArr.count; ++i) {
        UIButton *ListBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100 + i * 60, [UIScreen mainScreen].bounds.size.width - 100, 40)];
        ListBtn.tag = i;
        ListBtn.backgroundColor = [UIColor orangeColor];
        [ListBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        ListBtn.layer.cornerRadius = 5;
        [ListBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:ListBtn];
    }
}

-(void)btnClick:(UIButton *)sender{
    if (0 == sender.tag) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            controller.delegate = self;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    }else if(1 == sender.tag){
        // 拍照
        if ([self isCameraAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

#pragma mark - 获取照片成功的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"获取照片成功");
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        SWHEditImageViewController *editV = [[SWHEditImageViewController alloc] initWithImage:portraitImg];
        [self.navigationController pushViewController:editV animated:YES];
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
