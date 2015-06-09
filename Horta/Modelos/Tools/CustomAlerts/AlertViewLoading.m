//
//  AlertViewLoading.m
//  SoundEarth
//
//  Created by Felipe Costa Nascimento on 4/24/15.
//  Copyright (c) 2015 Joao Sisanoski. All rights reserved.
//

#import "AlertViewLoading.h"

@implementation AlertViewLoading

-(id)init{
    self = [super init];
    
    if (self) {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicator setFrame:CGRectMake(0, 0, 50, 50)];
        [self setContainerView:activityIndicator];
        
    }
    
    return self;
}


-(void)show{
    [super show];
    //[[self containerView] setBackgroundColor:[UIColor clearColor]];
    //[[self dialogView] setBackgroundColor:[UIColor greenColor]];
    //[[self parentView] setBackgroundColor:[UIColor greenColor]];
    //[self setBackgroundColor:[UIColor clearColor]];
    [activityIndicator startAnimating];
}


-(void)close{
    [activityIndicator stopAnimating];
    [super close];
}

@end
