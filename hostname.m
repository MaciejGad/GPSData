//
//  hostname.c
//  GPS Data
//
//  Created by Maciek on 03.01.2015.
//  Copyright (c) 2015 Maciej Gad. All rights reserved.
//

#import "hostname.h"
#import <Foundation/Foundation.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>


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

NSString * localIPAddress()
{
    struct hostent *host = gethostbyname([serverHostname() UTF8String]);
    if (!host) {herror("resolv"); return nil;}
    struct in_addr **list = (struct in_addr **)host->h_addr_list;
    return [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
}