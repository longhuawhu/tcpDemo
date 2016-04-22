//
//  NSString+lhBase64.h
//  tcpDemo
//
//  Created by lh on 16/4/22.
//  Copyright © 2016年 Lh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (lhBase64)
- (NSString * )lh_Base64EncodedStringFromString:(NSString *)string;
- (NSString * )lh_Base64DecodedStringFromString:(NSString *)string;
@end
