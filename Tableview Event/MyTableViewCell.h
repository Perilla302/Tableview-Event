//
//  MyTableViewCell.h
//  Tableview Event
//
//  Created by Hongjin Su on 10/27/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *MyImage;
@property (weak, nonatomic) IBOutlet UILabel *label_eventTitle;

@end
