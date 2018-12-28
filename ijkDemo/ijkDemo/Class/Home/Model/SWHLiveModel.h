//
//  SWHLiveModel.h
//  ijkDemo
//
//  Created by 司伟红 on 2018/12/27.
//  Copyright © 2018年 司伟红. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SWHCreaorModel;
@interface SWHLiveModel : NSObject

/** 直播流地址 */
@property (nonatomic, copy) NSString *stream_addr;
/** 关注人 */
@property (nonatomic, assign) NSUInteger online_users;
/** 城市 */
@property (nonatomic, copy) NSString *city;
/** 主播 */
@property (nonatomic, strong) SWHCreaorModel *creator;

@end
