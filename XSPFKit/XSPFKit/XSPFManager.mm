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
#import "XSPFPlaylist.h"
#import "XSPFTrack.h"

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
    
    int res = reader.parseFile(_PT(path), callback, _PT(uri));
    if (res != XSPF_READER_SUCCESS) {
        NSLog(@"fail to parse %@", @(res));
    }
    delete callback;
    
    return playlist;
}

-(BOOL)writePlaylist:(XSPFPlaylist *)playlist toUrl:(NSURL *)url {
    XspfIndentFormatter xmlFormatter;
    XspfWriter * const writer = XspfWriter::makeWriter(xmlFormatter, NULL);
    
    XspfProps props;
    
//    XspfDateTime dateTime;
//    props.lendDate(&dateTime);
    if (playlist.title) props.lendTitle(_PT([playlist.title UTF8String]));
    if (playlist.author) props.lendCreator(_PT([playlist.author UTF8String]));
    if (playlist.comment) props.lendAnnotation(_PT([playlist.comment UTF8String]));
    if (playlist.info) props.lendInfo(_PT([[playlist.info absoluteString] UTF8String]));
    if (playlist.location) props.lendLocation(_PT([[playlist.location absoluteString] UTF8String]));
    if (playlist.identifier) props.lendIdentifier(_PT([playlist.identifier UTF8String]));
    if (playlist.image) props.lendImage(_PT([[playlist.image absoluteString] UTF8String]));
    if (playlist.license) props.lendLicense(_PT([[playlist.license absoluteString] UTF8String]));
    
    writer->setProps(props);
    
    for (XSPFTrack *track in [playlist trackList]) {
        XspfTrack innerTrack;

        if (track.location) innerTrack.lendAppendLocation(_PT([[track.location absoluteString] UTF8String]));
        if (track.identifier) innerTrack.lendAppendIdentifier(_PT([track.identifier UTF8String]));
        if (track.title) innerTrack.lendTitle(_PT([track.title UTF8String]));
        if (track.author) innerTrack.lendCreator(_PT([track.author UTF8String]));
        if (track.comment) innerTrack.lendAnnotation(_PT([track.comment UTF8String]));
        if (track.info) innerTrack.lendInfo(_PT([[track.info absoluteString] UTF8String]));
        if (track.image) innerTrack.lendImage(_PT([[track.image absoluteString] UTF8String]));
        if (track.album) innerTrack.lendAlbum(_PT([track.album UTF8String]));
        if (track.trackNumber) innerTrack.setTrackNum(_PT([track.trackNumber intValue]));
        if (track.duration) innerTrack.setDuration((int)([track.duration intValue]));
        
        writer->addTrack(innerTrack);
    }
    int errorCode = writer->writeFile(_PT([[url path] UTF8String]));
    if (errorCode != 0) {
        NSLog(@"Error while writing playlist to url %@, error code %d", url, errorCode);
    }
    return (errorCode == 0);
}

@end
