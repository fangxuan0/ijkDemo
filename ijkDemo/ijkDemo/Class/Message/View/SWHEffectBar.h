//
//  SWHEffectBar.h
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/28.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWHEffectBarItem.h"

@class SWHEffectBar;

@protocol SWHEffectBarDelegate <NSObject>

- (void)effectBar:(SWHEffectBar *)bar didSelectItemAtIndex:(NSInteger)index;

@end

@interface SWHEffectBar : UIScrollView

@property (nonatomic, assign) id<SWHEffectBarDelegate> effectBarDelegate;
@property (nonatomic, copy) NSArray *items;
@property (nonatomic, weak) SWHEffectBarItem *selectedItem;
@property CGFloat margin;
@property (nonatomic) CGFloat itemWidth;
@property CGFloat itemBeginX;
/**
 * Sets the height of tab bar.
 */
- (void)setHeight:(CGFloat)height;

@end
