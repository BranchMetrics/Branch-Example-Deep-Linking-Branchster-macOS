//
//  AppDelegate.m
//  Branchster-macOS
//
//  Created by Nidhi on 9/18/20.
//  Copyright © 2020 Branch. All rights reserved.
//

#import "AppDelegate.h"
#import "Branch/Branch.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    // Register for Branch URL notifications:
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(branchWillStartSession:) name:BranchWillStartSessionNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(branchDidStartSession:) name:BranchDidStartSessionNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(branchOpenedURLNotification:) name:BranchDidOpenURLWithSessionNotification object:nil];

    // Create a Branch configuration object with your key:
    BranchConfiguration *configuration = [[BranchConfiguration alloc] initWithKey:@"key_live_aaIYKCwWVXm3oOK58pCDLimmwtpc1CIm"];

    // Start Branch:
    [[Branch sharedInstance] startWithConfiguration:configuration];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void) branchWillStartSession:(NSNotification*)notification {
    NSLog(@"branchWillStartSession: %@", notification.name);

    NSString *url = notification.userInfo[BranchURLKey] ?: @"";
    NSLog(@"URL: %@", url);
}

- (void) branchDidStartSession:(NSNotification*)notification {
    NSLog(@"branchDidStartSession: %@", notification.name);

    NSString *url = notification.userInfo[BranchURLKey] ?: @"";
    NSLog(@"URL: %@", url);

    BranchSession *session = notification.userInfo[BranchSessionKey];
    NSString *data = (session && session.data) ? session.data.description : @"";
}

- (void) branchOpenedURLNotification:(NSNotification*)notification {
    NSLog(@"branchOpenedURLNotification: %@", notification.name);

    NSString *url = notification.userInfo[BranchURLKey] ?: @"";
    NSLog(@"URL: %@", url);

    BranchSession *session = notification.userInfo[BranchSessionKey];

    // Do something with the link!
    
}

- (BOOL)application:(NSApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<NSUserActivityRestoring>> * _Nonnull))restorationHandler {
    [[Branch sharedInstance] continueUserActivity:userActivity];
    return YES;
}
@end
