//
//  ContactPerson.m
//  JYDPKVODemo
//
//  Created by JinYong on 15-3-2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ContactPerson.h"

@implementation ContactPerson
- (void)setNilValueForKey:(NSString *)key {
    if ([key isEqualToString:@"height"]) {
        [self setValue:@0 forKey:key];
    } else {
        [super setNilValueForKey:key];
    }
}
@end
