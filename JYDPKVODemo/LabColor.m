//
//  LabColor.m
//  JYDPKVODemo
//
//  Created by JinYong on 15-3-2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LabColor.h"

@implementation LabColor

- (double)redComponent {
    return self.lComponent/255.0f;
}

- (double)greenComponent {
    return self.aComponent/255.0f;
}

- (double)blueComponent {
    return self.bComponent/255.0f;
}

- (UIColor *)color {
    return [UIColor colorWithRed:self.redComponent green:self.greenComponent blue:self.blueComponent alpha:1.0f];
}
//- (void)willChangeValueForKey:(NSString *)key {
//    NSLog(@"will change value");
//}
//
//- (void)didChangeValueForKey:(NSString *)key {
//    NSLog(@"did change value");
//}
//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
//    if ([key isEqualToString:@"lComponent"]) {
//        return NO;
//    }
//    return YES;
//}
//- (void)setLComponent:(double)lComponent {
//    if (_lComponent == lComponent) {
//        return;
//    }
//    [self willChangeValueForKey:@"lComponent"];
//    _lComponent = lComponent;
//    [self didChangeValueForKey:@"lComponent"];
//}

+ (NSSet *)keyPathsForValuesAffectingRedComponent {
    return [NSSet setWithObject:@"lComponent"];
}

+ (NSSet *)keyPathsForValuesAffectingGreenComponent {
    return [NSSet setWithObject:@"aComponent"];
}

+ (NSSet *)keyPathsForValuesAffectingBlueComponent {
    return [NSSet setWithObject:@"bComponent"];
}

+ (NSSet *)keyPathsForValuesAffectingColor {
    return [NSSet setWithObjects:@"redComponent",@"greenComponent",@"blueComponent", nil];
}
@end
