//
//  SWHButton.m
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/27.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#import "SWHButton.h"

#define kButtonOffset 35.f
#define kTopPadding 5.f

@interface SWHButton ()

@property (nonatomic, strong) UIImage *highlightedButtonImage;
@property (nonatomic, strong) UIImage *normalButtonImage;

@end

@implementation SWHButton

+ (SWHButton *)button
{
    return [super buttonWithType:UIButtonTypeCustom];
}

+ (SWHButton *)buttonWithType:(UIButtonType)type
{
    return [SWHButton button];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.cornerRadius = 10.f;
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.4f];
        self.backgroundColorHighlighted = [UIColor colorWithWhite:0.f alpha:0.6f];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.normalButtonImage == nil || self.highlightedButtonImage == nil) {
        self.normalButtonImage = [self imageForState:UIControlStateNormal];
        self.highlightedButtonImage = [self imageForState:UIControlStateHighlighted];
        [self.imageView removeFromSuperview];
    }
    
    if (self.normalTextColor == nil) {
        self.normalTextColor = [UIColor whiteColor];
    }
    if (self.highlightedTextColor == nil) {
        self.highlightedTextColor = [UIColor whiteColor];
    }
    
    UIImage *buttonImage;
    if (self.state == UIControlStateNormal) {
        buttonImage = self.normalButtonImage;
        CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    }
    else {
        CGContextSetFillColorWithColor(context, self.backgroundColorHighlighted.CGColor);
        if (self.titleLabel.text.length > 0) {
            //            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        }
        if (self.normalButtonImage != self.highlightedButtonImage && self.highlightedButtonImage != nil) {
            buttonImage = self.highlightedButtonImage;
        }
        else{
            buttonImage = self.normalButtonImage;
        }
    }
    
    // Draw button content view
    CGRect buttonRect = CGRectMake(0.f, 0.f, rect.size.width, rect.size.height);
    UIBezierPath *buttonBezier = [UIBezierPath bezierPathWithRoundedRect:buttonRect cornerRadius:self.cornerRadius];
    [buttonBezier addClip];
    CGContextFillRect(context, buttonRect);
    
    // Draw button image
    if (buttonImage != nil) {
        CGImageRef buttonCGImage = buttonImage.CGImage;
        CGSize imageSize = CGSizeMake(CGImageGetWidth(buttonCGImage)/[self scale], CGImageGetHeight(buttonCGImage)/[self scale]);
        CGFloat buttonYOffset = (rect.size.height-kButtonOffset)/2.f - imageSize.height/2.f + kTopPadding;
        if (self.titleLabel.text.length == 0) {
            buttonYOffset = rect.size.height/2.f - imageSize.height/2.f;
        }
        [buttonImage drawInRect:CGRectMake(rect.size.width/2. - imageSize.width/2.f,
                                           buttonYOffset,
                                           imageSize.width,
                                           imageSize.height)];
    }
    
    // Draw button title
    if (self.titleLabel.text.length > 0) {
        if (self.state == UIControlStateNormal) {
            CGContextSetFillColorWithColor(context, self.normalTextColor.CGColor);
        }else {
            CGContextSetFillColorWithColor(context, self.highlightedTextColor.CGColor);
        }
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        /// Set line break mode
        paragraphStyle.lineBreakMode = self.titleLabel.lineBreakMode;
        /// Set text alignment
        paragraphStyle.alignment = NSTextAlignmentCenter;
        UIColor *textC = self.state == UIControlStateNormal ? self.normalTextColor : self.highlightedTextColor;
        NSDictionary *attributes = @{ NSFontAttributeName: self.titleLabel.font,
                                      NSParagraphStyleAttributeName: paragraphStyle,
                                      NSForegroundColorAttributeName: textC
                                      };
        [self.titleLabel.text drawInRect:CGRectMake(0.f, (buttonImage != nil ? rect.size.height -kButtonOffset+self.topPading *kTopPadding: rect.size.height/2 - 10.f), rect.size.width, 20.f) withAttributes:attributes];
    }
    
    [self.titleLabel removeFromSuperview];
}

- (void)setBackgroundColor:(UIColor *)color
{
    _backgroundColor = color;
}

- (void)setBackgroundColorHighlighted:(UIColor *)color
{
    _backgroundColorHighlighted = color;
}

- (CGFloat)scale
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        return [[UIScreen mainScreen] scale];
    }
    return 1.0f;
}

@end
