//
//  DetailViewController.h
//  0402 HW
//
//  Created by Ann wu on 2015/4/2.
//  Copyright (c) 2015年 Ann wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

