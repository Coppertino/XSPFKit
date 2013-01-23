//
//  XSPFPlaylist.h
//  XSPFKit
//
//  Created by Ivan Ablamskyi on 22.01.13.
//  Copyright (c) 2013 Coppertino Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSPFPlaylist : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSURL *info;
@property (nonatomic, strong) NSURL *location;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSURL *image;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSURL *license;
@property (nonatomic, strong) NSMutableArray *links;
@property (nonatomic, strong) NSMutableArray *meta;
@property (nonatomic, strong) NSMutableArray *trackList;

+ (id) playlist;

@end
