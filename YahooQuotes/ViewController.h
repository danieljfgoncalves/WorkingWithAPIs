//
//  ViewController.h
//  YahooQuotes
//
//  Created by Daniel Goncalves on 2015-04-27.
//  Copyright (c) 2015 Daniel J Goncalves. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

// UITextField
@property (strong, nonatomic) UITextField *textfield;
// String
@property (strong, nonatomic) NSString *quote;
// UILabel
@property (strong, nonatomic) UILabel *myLabel;

// Quote Method
-(void)getQuote;


@end

