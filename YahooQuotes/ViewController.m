//
//  ViewController.m
//  YahooQuotes
//
//  Created by Daniel Goncalves on 2015-04-27.
//  Copyright (c) 2015 Daniel J Goncalves. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    // Create the textfield
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(20, 60, 280, 20)];
    self.textfield.text = @"AAPL";
    
    // disabling AutoCorrection
    self.textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    
    // Enable AutoCapitaliation
    self.textfield.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    
    //Enable Return Key
    self.textfield.returnKeyType = UIReturnKeyDone;
    self.textfield.delegate = self;
    
    [self.view addSubview:self.textfield];
    
    // Create a label
    self.myLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 280, 40)];
    self.myLabel.text = @"$0.00";
    [self.view addSubview:self.myLabel];
    // Create Button
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.frame = CGRectMake(20, 200, 280, 40);
    [myButton setTitle:@"Get Quote" forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(getQuote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myButton];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.textfield resignFirstResponder];
    [self getQuote];
    
    return YES;
    
}

-(void)getQuote {
    
    // http://download.finance.yahoo.com/d/quotes.csv?s=%@&f=sl1d1t1c1ohgv&e=.csv
    NSString *quoteAddress = [NSString stringWithFormat:@"http://download.finance.yahoo.com/d/quotes.csv?s=%@&f=sl1d1t1c1ohgv&e=.csv", self.textfield.text];
    
    // Create a URL
    NSURL *theURL = [[NSURL alloc]initWithString:[quoteAddress stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    NSURLRequest *theURLRequest = [[NSURLRequest alloc]initWithURL:theURL];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:theURLRequest returningResponse:&response error:&error];
    NSMutableString *contentString = [[NSMutableString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *arrayData = [contentString componentsSeparatedByString:@","];
    
    float current = [[arrayData objectAtIndex:1]floatValue];
    float open = [[arrayData objectAtIndex:5]floatValue];
    
    if (current >= open) {
        self.myLabel.textColor = [UIColor greenColor];
        self.myLabel.text = [arrayData objectAtIndex:1];
    } else {
        self.myLabel.textColor = [UIColor redColor];
//        self.myLabel.text = [arrayData objectAtIndex:5];
    }
    
    self.myLabel.text = [arrayData objectAtIndex:1];
    
    NSLog(@"%@", contentString);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
