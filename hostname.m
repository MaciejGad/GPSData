//
//  hostname.c
//  GPS Data
//
//  Created by Maciek on 03.01.2015.
//  Copyright (c) 2015 Maciej Gad. All rights reserved.
//

#import "hostname.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NSString * serverHostname()
{
    char baseHostName[256];
    int success = gethostname(baseHostName, 255);
    if (success != 0) return nil;
    baseHostName[255] = '\0';
    
#if !TARGET_IPHONE_SIMULATOR
    return [NSString stringWithFormat:@"%s.local", baseHostName];
#else
    return [NSString stringWithFormat:@"%s", baseHostName];
#endif
}