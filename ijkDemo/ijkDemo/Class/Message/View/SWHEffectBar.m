//
//  SWHEffectBar.m
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/28.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#import "SWHEffectBar.h"

@implementation SWHEffectBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInit
{
    self.bounces = NO;
    self.margin = 15;
    self.itemWidth = 50;
    self.itemBeginX = 15;
}

- (void)layoutSubviews
{
    CGSize frameSize = self.frame.size;
    
    NSInteger index = 0;
    
    // Layout items
    
    for (SWHEffectBarItem *item in [self items]) {
        CGFloat itemHeight = [item itemHeight];
        if (!itemHeight) {
            itemHeight = frameSize.height;
        }
        
        [item setFrame:CGRectMake(_itemBeginX + index * (_itemWidth + _margin),
                                  0,
                                  self.itemWidth, self.frame.size.height)];
        [item setNeedsDisplay];
        //        NSLog(@"item frame is :%@", NSStringFromCGRect(item.frame));
        
        index++;
    }
    
    CGSize contentSize = CGSizeMake(_itemBeginX * 2 + [_items count] * _itemWidth + ([_items count] - 1) * _margin, self.frame.size.height);
    self.contentSize = contentSize;
}

#pragma mark - Configuration

- (void)setItems:(NSArray *)items
{
    for (SWHEffectBarItem *item in _items) {
        [item removeFromSuperview];
    }
    
    _items = [items copy];
    for (SWHEffectBarItem *item in _items) {
        [item addTarget:self action:@selector(tabBarItemWasSelected:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:item];
    }
    
}

- (void)setHeight:(CGFloat)height
{
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame),
                              CGRectGetWidth(self.frame), height)];
}

#pragma mark - Item selection

- (void)tabBarItemWasSelected:(id)sender
{
    [self setSelectedItem:sender];
    
    if ([[self effectBarDelegate] respondsToSelector:@selector(effectBar:didSelectItemAtIndex:)]) {
        NSInteger index = [self.items indexOfObject:self.selectedItem];
        [[self effectBarDelegate] effectBar:self didSelectItemAtIndex:index];
    }
}

- (void)setSelectedItem:(SWHEffectBarItem *)selectedItem
{
    if (selectedItem == _selectedItem) {
        return;
    }
    [_selectedItem setSelected:NO];
    
    _selectedItem = selectedItem;
    [_selectedItem setSelected:YES];
}

@end
