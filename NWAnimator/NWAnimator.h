//
//  NWAnimator.h
//
//  Created by Nicholas White on 11/23/15.
//  Copyright © 2015 MyLikes. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NWAnimation)(void);

@interface NWAnimator : NSObject

+ (void)animateForKey:(NSString*)key duration:(NSTimeInterval)duration animate:(NWAnimation)block;
+ (void)animateForKey:(NSString*)key duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animate:(NWAnimation)block;
+ (void)animateForKey:(NSString*)key animations:(NSArray<NSDictionary*>*)animations;

+ (void)stopForKey:(NSString*)key;
+ (void)stopForKey:(NSString*)key completion:(NWAnimation)completion;

@end
