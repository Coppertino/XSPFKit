//
//  XSPFManager.h
//  XSPFKit
//
//  Created by Ivan Ablamskyi on 22.01.13.
//  Copyright (c) 2013 Coppertino Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSPFPlaylist.h"
@interface XSPFManager : NSObject

/**
 Returns the shared instance of XSPFManager
 */
+ (instancetype)sharedManager;

- (XSPFPlaylist *) playlistFromFile:(NSString *)file;
- (XSPFPlaylist *) playlistFromUrl:(NSURL *)url;
- (XSPFPlaylist *) playlistFromString:(NSString *)string;
- (XSPFPlaylist *) playlistFromData:(NSData *)data;


@end
