//
//  NSString+Shove.h
//  Shove
//
//  Created by 英迈思实验室移动开发部 on 14-8-28.
//  Copyright (c) 2014年 EIMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Shove)

/* 
 * 给字符串md5加密
 */
- (NSString *)md5;

/**
 * 判断字符串是否是email格式
 */
- (BOOL)isEmail;


@end
