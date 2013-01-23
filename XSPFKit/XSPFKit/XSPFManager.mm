//
//  XSPFManager.m
//  XSPFKit
//
//  Created by Ivan Ablamskyi on 22.01.13.
//  Copyright (c) 2013 Coppertino Inc. All rights reserved.
//

#import "XSPFManager.h"
#include <Xspf.h>
#include <XspfDefines.h>
#include "XSPFReaderCallback.h"

using namespace Xspf;

@implementation XSPFManager

+ (instancetype)sharedManager
{
    static XSPFManager *__sharedXSPFManager;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        __sharedXSPFManager = [[XSPFManager alloc] init];
    });
    return __sharedXSPFManager;
}

- (XSPFPlaylist *) playlistFromFile:(NSString *)file;
{
    return [self playlistFromUrl:[NSURL fileURLWithPath:file]];
}


- (XSPFPlaylist *)playlistFromUrl:(NSURL *)url
{
    XSPFPlaylist *playlist = [XSPFPlaylist playlist];

    XspfReader reader;
    XspfReaderCallback *callback = new XSPFKit::XSPFReaderCallback(playlist);
    
    // parse
    const char * uri;
    const char * path;
    if ([url isFileURL]) {
        uri = [[[url scheme] stringByAppendingString:@"://"] UTF8String];
        path = [[url path] UTF8String];
    } else {
        uri = [[[url baseURL] absoluteString] UTF8String];
        path = [[url absoluteString] UTF8String];
    }
    
    reader.parseFile(_PT(path), callback, _PT(uri));
    delete callback;
    
    return playlist;
}



@end
