//
//  DetailViewController.m
//  Tableview Event
//
//  Created by Hongjin Su on 10/27/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textview_detail;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *RSVP;
    NSString *RequireMap;
    
    if (_myObject.RSVP == YES) {
        RSVP = [NSString stringWithFormat:@"Yes"];
    }
    else {
        RSVP = [NSString stringWithFormat:@"No"];
    }
    
    if (_myObject.RequireMap == YES) {
        RequireMap = [NSString stringWithFormat:@"Yes"];
    }
    else {
        RequireMap = [NSString stringWithFormat:@"No"];
    }
    _textview_detail.text = [NSString stringWithFormat:@"EndDate: %@ \n EndTime: %@ \n EventCategory: %@ \n EventCategoryID: %ld \n EventCategoryName: %@ \n EventDescription: %@ \n EventId: %@ \n EventLocation: %@ \n OrganizerDescription: %@ \n Photo: %@ \n RSVP: %@ \n RepeatEvent: %@ \n RequireMap: %@ \n StartDate: %@ \n StartTime: %@ \n Venue: %@ \n Videolink: %@ \n Views: %ld \n", _myObject.EndDate, _myObject.EndTime, _myObject.EventCategory, _myObject.EventCategoryID, _myObject.EventCategoryName, _myObject.EventDescription, _myObject.EventId, _myObject.EventLocation, _myObject.OrganizerDescription, _myObject.Photo, RSVP, _myObject.RepeatEvent, RequireMap, _myObject.StartDate, _myObject.StartTime, _myObject.Venue, _myObject.Videolink, _myObject.Views];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
