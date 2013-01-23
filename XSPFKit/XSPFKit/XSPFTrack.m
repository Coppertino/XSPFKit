//
//  XSPFTrack.m
//  XSPFKit
//
//  Created by Ivan Ablamskyi on 22.01.13.
//  Copyright (c) 2013 Coppertino Inc. All rights reserved.
//

#import "XSPFTrack.h"

@implementation XSPFTrack

- (id)init
{
    self = [super init];
    if (self) {
        self.meta = [NSMutableArray array];
        self.links = [NSMutableArray array];
    }
    
    return self;
}

- (NSString *)description
{
    NSString *trackInfo;
    if (self.author)
        trackInfo = [NSString stringWithFormat:@"%@ - %@", self.author, self.title];
    else if (self.title)
        trackInfo = self.title;
    else
        trackInfo = [NSString stringWithFormat:@"!!%@!!", self.location];
    
    NSString *numInfo = @"";
    if (self.trackNumber)
        numInfo = [NSString stringWithFormat:@"%@.", self.trackNumber];
    
    return [NSString stringWithFormat:@"%@ %@ (%@s) [%@]", numInfo, trackInfo, self.duration?:@"0", self.location];
}

@end
