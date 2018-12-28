//
//  SWHEditImageViewController.h
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/27.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWHEditImageViewController : UIViewController

@property (nonatomic, strong) UIImageView *imageView;
//@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImage *image;

- (id)initWithImage:(UIImage *)image;

@end
