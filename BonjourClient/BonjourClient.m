//
//  BonjourClient.m
//  BonjourClient
//
//  Created by Keith Lee on 2/25/13.
//  Copyright (c) 2013 Keith Lee. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are
//  permitted provided that the following conditions are met:
//
//   1. Redistributions of source code must retain the above copyright notice, this list of
//      conditions and the following disclaimer.
//
//   2. Redistributions in binary form must reproduce the above copyright notice, this list
//      of conditions and the following disclaimer in the documentation and/or other materials
//      provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY Keith Lee ''AS IS'' AND ANY EXPRESS OR IMPLIED
//  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
//  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Keith Lee OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those of the
//  authors and should not be interpreted as representing official policies, either expressed
//  or implied, of Keith Lee.

#import "BonjourClient.h"

@implementation BonjourClient

- (id)init
{
  if ((self = [super init]))
  {
    _isFinished = NO;
    _serviceBrowser = [[NSNetServiceBrowser alloc] init];
    [_serviceBrowser setDelegate:self];
  }
  
  return self;
}

#pragma mark -
#pragma mark NSNetServiceBrowserDelegate methods

- (void)netServiceBrowserWillSearch:(NSNetServiceBrowser *)netServiceBrowser
{
  NSLog(@"Beginning search");
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)sb
           didFindService:(NSNetService *)ns
               moreComing:(BOOL)moreComing
{
  NSLog(@"Found service: %@", ns);
  if (!moreComing)
  {
    // No more services, stop search
    [self.serviceBrowser stop];
  }
}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)netServiceBrowser
{
  // Stopped search, set flag to exit run loop
  NSLog(@"Stopped search");
  self.isFinished = YES;
}

@end
