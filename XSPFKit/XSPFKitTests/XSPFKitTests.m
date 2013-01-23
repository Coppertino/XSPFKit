//
//  XSPFKitTests.m
//  XSPFKitTests
//
//  Created by Ivan Ablamskyi on 22.01.13.
//  Copyright (c) 2013 Coppertino Inc. All rights reserved.
//

#import "XSPFKitTests.h"
#import "XSPFKit.h"

@implementation XSPFKitTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    NSBundle *mainBundle = [NSBundle bundleForClass:self.class];
    XSPFPlaylist *pl = [[XSPFManager sharedManager] playlistFromFile:[mainBundle pathForResource:@"test1" ofType:@"xspf"]];
    NSLog(@"pl %@", pl.trackList);
    
//    STFail(@"Unit tests are not implemented yet in XSPFKitTests");
}

@end
