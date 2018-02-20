//
//  JotSquareBrushTexture.m
//  JotUI
//
//  Created by JENNIFER MARY JACOBS on 6/4/17.
//  Copyright © 2017 Milestone Made. All rights reserved.
//



#import "JotSquareBrushTexture.h"
#import "JotSharedBrushTexture.h"
#import "UIImage+BrushTextures.h"


@implementation JotSquareBrushTexture

#pragma mark - PlistSaving

- (NSDictionary*)asDictionary {
    return [NSDictionary dictionaryWithObject:NSStringFromClass([self class]) forKey:@"class"];
}

- (id)initFromDictionary:(NSDictionary*)dictionary {
    NSString* className = [dictionary objectForKey:@"class"];
    Class clz = NSClassFromString(className);
    return [[clz alloc] init];
}


#pragma mark - Singleton

- (UIImage*)texture {
    return [[self brushTexture] texture];
}

- (NSString*)name {
    return [[self brushTexture] name];
}

- (BOOL)bind {
   // DebugLog(@"binding square brush");
    return [[self brushTexture] bind];
}

-(void)unbind {
    JotGLContext* currContext = (JotGLContext*)[JotGLContext currentContext];
    if (!currContext) {
        @throw [NSException exceptionWithName:@"NilGLContextException" reason:@"Cannot bind texture to nil gl context" userInfo:nil];
    }
    if (![currContext isKindOfClass:[JotGLContext class]]) {
        @throw [NSException exceptionWithName:@"JotGLContextException" reason:@"Current GL Context must be JotGLContext" userInfo:nil];
    }
    JotBrushTexture* texture = [currContext.contextProperties objectForKey:@"squareBrushTexture"];
    if (!texture) {
        @throw [NSException exceptionWithName:@"JotGLContextException" reason:@"Cannot unbind unbuilt brush texture" userInfo:nil];
    }
    [texture unbind];
}

#pragma mark - Singleton

static JotSquareBrushTexture* _instance = nil;

- (id)init {
    if (_instance)
        return _instance;
    if ((_instance = [super init])) {
        // noop
    }
    return _instance;
}

+ (JotBrushTexture*)sharedInstance {
    if (!_instance) {
        _instance = [[JotSquareBrushTexture alloc] init];
    }
    return _instance;
}


#pragma mark - Private
- (JotSharedBrushTexture*)brushTexture {
    JotGLContext* currContext = (JotGLContext*)[JotGLContext currentContext];
    if (!currContext) {
        @throw [NSException exceptionWithName:@"NilGLContextException" reason:@"Cannot bind texture to nil gl context" userInfo:nil];
    }
    if (![currContext isKindOfClass:[JotGLContext class]]) {
        @throw [NSException exceptionWithName:@"JotGLContextException" reason:@"Current GL Context must be JotGLContext" userInfo:nil];
    }
    JotSharedBrushTexture* texture = [currContext.contextProperties objectForKey:@"squareBrushTexture"];
    if (!texture) {
        texture = [[JotSharedBrushTexture alloc] initWithImage:[UIImage squareBrushTexture]];
        [currContext.contextProperties setObject:texture forKey:@"squareBrushTexture"];
    }
    return texture;
}

@end
