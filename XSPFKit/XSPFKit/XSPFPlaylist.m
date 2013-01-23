//
//  XSPFPlaylist.m
//  XSPFKit
//
//  Created by Ivan Ablamskyi on 22.01.13.
//  Copyright (c) 2013 Coppertino Inc. All rights reserved.
//

#import "XSPFPlaylist.h"

@implementation XSPFPlaylist

+ (id) playlist
{
	return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.links = [NSMutableArray array];
        self.meta = [NSMutableArray array];
        self.trackList = [NSMutableArray array];
    }
    return self;
}

@end
