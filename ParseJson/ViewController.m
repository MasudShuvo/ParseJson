//
//  ViewController.m
//  ParseJson
//
//  Created by Shuvo on 12/29/13.
//  Copyright (c) 2013 Masud Shuvo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *string = @"testing_string";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://md5.jsontest.com/?text=%@",string]];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (error) {
            [self failedToResponed:error];
        }
        else {
            [self receivedData:data];
        }
        
    }];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)failedToResponed:(NSError *)error
{
    NSLog(@"error %@",[error description]);
}

- (void)receivedData:(NSData *)data
{
    NSError *error;
    dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    for(NSString *key in [dictionary allKeys])
    {
        if ([key isEqualToString:@"md5"]) {
            md5String = [dictionary objectForKey:key];
        }
        else if ([key isEqualToString:@"original"]) {
            originalString = [dictionary objectForKey:key];
        }
    }
    NSLog(@"md5String : %@ originalString : %@",md5String, originalString);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
