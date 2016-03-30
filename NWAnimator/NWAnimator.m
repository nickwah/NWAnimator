//
//  NWAnimator.m
//  FriendLife
//
//  Created by Nicholas White on 11/23/15.
//  Copyright © 2015 MyLikes. All rights reserved.
//

#import "NWAnimator.h"
@import UIKit;

@implementation NWAnimator

static NSMutableDictionary<NSString *, NSMutableArray<NSDictionary *> *> *_animationQueues;
static NSMutableDictionary<NSString *, NSDictionary *> *_runningKeys;

+ (void)animateForKey:(NSString *)key duration:(NSTimeInterval)duration animate:(NWAnimation)block {
    [self animateForKey:key duration:duration delay:0 animate:block];
}
+ (void)animateForKey:(NSString *)key duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animate:(NWAnimation)block {
    if (!_animationQueues) _animationQueues = [NSMutableDictionary dictionary];
    if (!_animationQueues[key]) {
        _animationQueues[key] = [NSMutableArray array];
    }
    [_animationQueues[key] addObject:@{@"block": block, @"duration": @(duration), @"delay": @(delay)}];
    [self runAnimationsForKey:key];
}
+ (void)animateForKey:(NSString *)key animations:(NSArray<NSDictionary *> *)animations {
    if (!_animationQueues) _animationQueues = [NSMutableDictionary dictionary];
    if (!_animationQueues[key]) {
        _animationQueues[key] = [animations mutableCopy];
    } else {
        [_animationQueues[key] addObjectsFromArray:animations];
    }
    [self runAnimationsForKey:key];
}

+ (void)stopForKey:(NSString *)key {
    [self stopForKey:key completion:nil];
}

+ (void)stopForKey:(NSString *)key completion:(NWAnimation)completion {
    if (_runningKeys[key]) {
        NSDictionary *current = _runningKeys[key];
        [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:current[@"block"] completion:^(BOOL finished) {
            if (completion) completion();
        }];
    }
    if (_animationQueues[key]) {
        [_animationQueues removeObjectForKey:key];
    }
}

+ (void)runAnimationsForKey:(NSString*)key {
    if (!_runningKeys) _runningKeys = [NSMutableDictionary dictionary];
    if (_runningKeys[key]) return; // Already animating
    if (_animationQueues[key].count) {
        NSDictionary *first = _animationQueues[key].firstObject;
        [_animationQueues[key] removeObjectAtIndex:0];
        NSTimeInterval duration = [first[@"duration"] doubleValue];
        NSTimeInterval delay = [first[@"delay"] doubleValue];
        NWAnimation block = (NWAnimation)first[@"block"];
        if (duration || delay) {
            _runningKeys[key] = first;
            [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:block completion:^(BOOL finished) {
                if (_runningKeys[key]) [_runningKeys removeObjectForKey:key];
                [self runAnimationsForKey:key];
            }];
        } else {
            block();
            [self runAnimationsForKey:key];
        }
    }
}

@end
