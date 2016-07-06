//
//  AppDelegate.m
//  CheckXattr
//
//  Created by Soaurabh Kakkar on 08/10/15.
//  Copyright (c) 2015 Soaurabh Kakkar. All rights reserved.
//

#import "AppDelegate.h"
#include <sys/xattr.h>
#define kSFFontFilePath "/Users/soaurabhkakkar/Desktop/Sk/abc.otf"
#define kSFAttrKey "com.yourcompany.yourapp.yourattributename"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}
- (IBAction)setXttr:(id)sender {
    NSString *theString = @"SkyFonts_Hash_Value";
    NSData* encodedString = [theString dataUsingEncoding:NSUTF8StringEncoding];
    int rc = setxattr(kSFFontFilePath, kSFAttrKey, [encodedString bytes], [encodedString length], 0, 0);
    if (rc == 0) {
        NSLog(@"Sucessfully Set");
    }
}

- (IBAction)getAttr:(id)sender {
    ssize_t len = getxattr(kSFFontFilePath, kSFAttrKey, NULL, 0, 0, 0);
    if (len < 0) {
        NSLog(@"Error!!!");
    }
    
    NSMutableData* data = [NSMutableData dataWithLength:len];
    len = getxattr(kSFFontFilePath, kSFAttrKey, [data mutableBytes], len, 0, 0);
    NSString* string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Final Str - %@", string);
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
