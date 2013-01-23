//
//  XSPFReaderCallback.cpp
//  XSPFKit
//
//  Created by Ivan Ablamskyi on 22.01.13.
//  Copyright (c) 2013 Coppertino Inc. All rights reserved.
//

#include "XSPFReaderCallback.h"
#import "XSPFPlaylist.h"
#import "XSPFTrack.h"

namespace Xspf {
namespace XSPFKit {
    XSPFReaderCallback::XSPFReaderCallback(XSPFPlaylist *playlist): mPlaylist(playlist), valid(true) {};
    
    void XSPFReaderCallback::addTrack(XspfTrack *track)
    {
        XSPFTrack *newTrack = [XSPFTrack new];
        
        const XML_Char *location = track->getLocation(0);
        newTrack.location = location ? [NSURL URLWithString:[NSString stringWithUTF8String:location]] : nil;
        
        // New track has proper location
        if (newTrack.location) {
            
            // Find basic info for track
            const XML_Char *album = track->getAlbum();
            newTrack.album = album ? [NSString stringWithUTF8String:album] : nil;
            
            const XML_Char *title = track->getTitle();
            newTrack.title = title ? [NSString stringWithUTF8String:title] : nil;
            
            const XML_Char *identifier = track->getIdentifier(0);
            newTrack.identifier = identifier ? [NSString stringWithUTF8String:identifier] : nil;
            
            const XML_Char *creator = track->getCreator();
            newTrack.author = creator ? [NSString stringWithUTF8String:creator] : nil;
            
            const XML_Char *comment = track->getAnnotation();
            newTrack.comment = comment ? [NSString stringWithUTF8String:comment] : nil;
            
            const XML_Char *image = track->getImage();
            newTrack.image = image ? [NSURL URLWithString:[NSString stringWithUTF8String:image]] : nil;

            const XML_Char *info = track->getInfo();
            newTrack.info = info ? [NSURL URLWithString:[NSString stringWithUTF8String:info]] : nil;
            
            const int trackNumber = track->getTrackNum();
            const int trackDuration = track->getDuration();
            
            newTrack.trackNumber = trackNumber > -1 ? @(trackNumber) : nil;
            newTrack.duration = trackDuration > -1 ? @(trackDuration) : nil;
            
            // Find all links
            int linksCount = track->getLinkCount();
            for (int i=0; i < linksCount; ++i) {
                std::pair<const XML_Char *, const XML_Char *> *link = track->getLink(i);
                if (link->first && link->second) {
                    NSString *key = [NSString stringWithUTF8String:link->first];
                    NSString *val = [NSString stringWithUTF8String:link->second];
                    [newTrack.links addObject:@{@"typeurl" : key, @"url" : val}];
                }
                delete link;
            }
            
            // Read all meta
            int metaCount = track->getMetaCount();
            for (int i=0; i < metaCount; ++i) {
                std::pair<const XML_Char *, const XML_Char *> *meta = track->getMeta(i);
                if (meta->first && meta->second) {
                    NSString *key = [NSString stringWithUTF8String:meta->first];
                    NSString *val = [NSString stringWithUTF8String:meta->second];
                    [newTrack.meta addObject:@{@"typeurl" : key, @"url" : val}];
                }
                delete meta;
            }
        }
        
        [mPlaylist.trackList addObject:newTrack];
        delete track;
    }
    
    
    void XSPFReaderCallback::setProps (XspfProps *props)
    {
        const XML_Char *title = props->getTitle();
        mPlaylist.title = title ? [NSString stringWithUTF8String:title] : nil;

        const XML_Char *author = props->getCreator();
        mPlaylist.author = author ? [NSString stringWithUTF8String:author] : nil;
        
        const XML_Char *comment = props->getAnnotation();
        mPlaylist.comment = comment ? [NSString stringWithUTF8String:comment] : nil;
        
        const XML_Char *info = props->getInfo();
        mPlaylist.info = info ? [NSURL URLWithString:[NSString stringWithUTF8String:info]] : nil;
        
        const XML_Char *location = props->getLocation();
        mPlaylist.location = location ? [NSURL URLWithString:[NSString stringWithUTF8String:location]] : nil;
        
        const XML_Char *identifier = props->getIdentifier();
        mPlaylist.identifier = identifier ? [NSString stringWithUTF8String:identifier] : nil;
        
        const XML_Char *image = props->getImage();
        mPlaylist.image= image ? [NSURL URLWithString:[NSString stringWithUTF8String:image]] : nil;
        
        const XspfDateTime *date = props->getDate();
        if (date) {
            BOOL offset = (date->getDistHours() + date->getDistMinutes()) > 0;
            NSString *dateString = [NSString stringWithFormat:@"%04i-%02i-%02i %02i:%02i:%02i %@%02i%02i",
                                    date->getYear(), date->getMonth(), date->getDay(),
                                    date->getHour(), date->getMinutes(), date->getSeconds(),
                                    offset ? @"+" : @"-",
                                    date->getDistHours(), date->getDistMinutes()
                                    ];
            mPlaylist.date = [NSDate dateWithString:dateString];
        }
        
        const XML_Char *license = props->getLicense();
        mPlaylist.license = license ? [NSURL URLWithString:[NSString stringWithUTF8String:license]] : nil;
        
        
        // Find all links
        int linksCount = props->getLinkCount();
        for (int i=0; i < linksCount; ++i) {
            std::pair<const XML_Char *, const XML_Char *> *link = props->getLink(i);
            if (link->first && link->second) {
                NSString *key = [NSString stringWithUTF8String:link->first];
                NSString *val = [NSString stringWithUTF8String:link->second];
                [mPlaylist.links addObject:@{@"typeurl" : key, @"url" : val}];
            }
            delete link;
        }
        
        // Read all meta
        int metaCount = props->getMetaCount();
        for (int i=0; i < metaCount; ++i) {
            std::pair<const XML_Char *, const XML_Char *> *meta = props->getMeta(i);
            if (meta->first && meta->second) {
                NSString *key = [NSString stringWithUTF8String:meta->first];
                NSString *val = [NSString stringWithUTF8String:meta->second];
                [mPlaylist.meta addObject:@{@"typeurl" : key, @"url" : val}];
            }
            delete meta;
        }
        
        delete props;
    }
    
    void XSPFReaderCallback::notifyFatalError (int line, int column, int errorCode, XML_Char const *description)
    {
        
    }
    
    void XSPFReaderCallback::notifySuccess ()
    {
        valid = true;
    }
    
    bool XSPFReaderCallback::handleError (int line, int column, int errorCode, XML_Char const *description)
    {
        valid = false;
        return false;
    }
    
    bool XSPFReaderCallback::handleWarning (int line, int column, int warningCode, XML_Char const *description)
    {
        return false;
    }
}}
