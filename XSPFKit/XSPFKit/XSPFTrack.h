//
//  XSPFTrack.h
//  XSPFKit
//
//  Created by Ivan Ablamskyi on 22.01.13.
//  Copyright (c) 2013 Coppertino Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSPFTrack : NSObject

@property (nonatomic, retain) NSURL *location;
@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) NSURL *info;
@property (nonatomic, retain) NSURL *image;
@property (nonatomic, retain) NSString *album;
@property (nonatomic, retain) NSNumber *trackNumber;
/** Duration in miliseconds */
@property (nonatomic, retain) NSNumber *duration;
@property (nonatomic, retain) NSMutableArray *links;
@property (nonatomic, retain) NSMutableArray *meta;

@end
