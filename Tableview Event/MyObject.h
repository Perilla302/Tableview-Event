//
//  MyObject.h
//  Tableview Event
//
//  Created by Hongjin Su on 10/27/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyObject : NSObject

@property (strong, nonatomic) NSString *EndDate;
@property (strong, nonatomic) NSString *EndTime;
@property (strong, nonatomic) NSString *EventCategory;
@property (nonatomic) long EventCategoryID;
@property (strong, nonatomic) NSString *EventCategoryName;
@property (strong, nonatomic) NSString *EventDescription;
@property (strong, nonatomic) NSString *EventId;
@property (strong, nonatomic) NSString *EventLocation;
@property (strong, nonatomic) NSString *EventTitle;
@property (strong, nonatomic) NSString *OrganizerDescription;
@property (strong, nonatomic) NSString *Photo;
@property (nonatomic) BOOL RSVP;
@property (strong, nonatomic) NSString *RepeatEvent;
@property (nonatomic) BOOL RequireMap;
@property (strong, nonatomic) NSString *StartDate;
@property (strong, nonatomic) NSString *StartTime;
@property (strong, nonatomic) NSString *Venue;
@property (strong, nonatomic) NSString *Videolink;
@property (nonatomic) long Views;


@end
