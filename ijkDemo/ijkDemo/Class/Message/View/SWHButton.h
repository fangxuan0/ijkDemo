//
//  SWHButton.h
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/27.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWHButton : UIButton

@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *backgroundColorHighlighted;
@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *highlightedTextColor;
@property (nonatomic, assign) float topPading;

+ (SWHButton *) button;

+ (SWHButton *)buttonWithType:(UIButtonType)type;

@end
