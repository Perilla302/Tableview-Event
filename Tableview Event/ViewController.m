//
//  ViewController.m
//  Tableview Event
//
//  Created by Hongjin Su on 10/27/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "MyObject.h"
#import "MyTableViewCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview_event;
@property (strong, nonatomic) NSMutableArray *array_event;
@property (strong, nonatomic) NSMutableArray *array_path;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self DetailCall];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark To display the JSON data
- (void)DetailCall {
    
    NSString *urlString = @"http://183.82.48.194:8484/REM/RemService.svc/GetPublicEvent";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession]; // + class method
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        id object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (error) {
            
            NSLog(@"Error: %@",error);
        }
        else {
            //NSLog(@"Arrived here");
            [self JSONData:object];
        }
    }];// return a dataTask
    [dataTask resume]; //resume is necessary
}

- (void)JSONData:(id)object {
    
    if ([object isKindOfClass:[NSDictionary class]]) { // In JSON data, if nothing before brackets, then check [object isKindOfClass:[NSArray Array]]
        NSDictionary *myDict = object;
        NSArray *resultArray = [myDict objectForKey:@"GetPublicEventResult"];
        _array_path = [[NSMutableArray alloc] init];
        
        _array_event = [NSMutableArray new];
        for (int i = 0; i < [resultArray count]; i++) {
            
            MyObject *objStructure = [MyObject new];
            NSDictionary *dict = resultArray[i];
            
            // To get all the info from JSON data
            objStructure.EndDate = [NSString stringWithFormat:@"%@", [dict objectForKey:@"EndDate"]];
            objStructure.EndTime = [NSString stringWithFormat:@"%@", [dict objectForKey:@"EndTime"]];
            objStructure.EventCategory = [NSString stringWithFormat:@"%@", [dict objectForKey:@"EventCategory"]];
            objStructure.EventCategoryID = [[dict objectForKey:@"EventCategoryID"] longValue];
            objStructure.EventCategoryName = [NSString stringWithFormat:@"%@", [dict objectForKey:@"EventCategoryName"]];
            objStructure.EventDescription = [NSString stringWithFormat:@"%@", [dict objectForKey:@"EventDescription"]];
            objStructure.EventId = [NSString stringWithFormat:@"%@", [dict objectForKey:@"EventId"]];
            objStructure.EventLocation = [NSString stringWithFormat:@"%@", [dict objectForKey:@"EventLocation"]];
            objStructure.EventTitle = [NSString stringWithFormat:@"%@", [dict objectForKey:@"EventTitle"]];
            objStructure.OrganizerDescription = [NSString stringWithFormat:@"%@", [dict objectForKey:@"OrganizerDescription"]];
            objStructure.Photo = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Photo"]];
            objStructure.RSVP = [[dict objectForKey:@"RSVP"] boolValue];
            objStructure.RepeatEvent = [NSString stringWithFormat:@"%@", [dict objectForKey:@"RepeatEvent"]];
            objStructure.RequireMap = [[dict objectForKey:@"RequireMap"] boolValue];
            objStructure.StartDate = [NSString stringWithFormat:@"%@", [dict objectForKey:@"StartDate"]];
            objStructure.StartTime = [NSString stringWithFormat:@"%@", [dict objectForKey:@"StartTime"]];
            objStructure.Venue = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Venue"]];
            NSString *Videolink = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Videolink"]];
            objStructure.Videolink = [Videolink stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            objStructure.Views = [[dict objectForKey:@"Views"] longValue];
            
            // To get the link for the image
            NSString *masterPath = @"http://183.82.48.194:8484/YoutubeUploader/Pics/";
            NSString *path = [NSString stringWithFormat:@"%@%@", masterPath, objStructure.Videolink];
            [_array_path addObject:path];
            //NSLog(@"%@", objStructure.Videolink);
            //NSLog(@"Path: %@", path);
            //NSLog(@"Array: %@", [_array_path description]);
            
            
            [_array_event addObject:objStructure];
        }
    }
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [_tableview_event reloadData];
//    });
}



#pragma mark To make the table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _array_event.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTableViewCell *myCell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
//    //UITableViewCell *myCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
//    //myCell.MyImage.image =[UIImage imageNamed:@"image.jpg"];
//    
//    NSString *urlPath = [_array_path objectAtIndex:indexPath.row];
//    NSURL *url = [NSURL URLWithString:urlPath];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    myCell.MyImage.image = [UIImage imageWithData:data];
//    //NSLog(@"X %ld", (long)indexPath.row);
//    //myCell.imageView.image = [UIImage imageWithData:data];
//    //NSLog(@"Y %ld", (long)indexPath.row);
    
    MyObject *obj_myClass = [_array_event objectAtIndex:indexPath.row];
    myCell.textLabel.text = [NSString stringWithFormat:@"%@", obj_myClass.EventTitle];
    
    
    myCell.MyImage.image = nil;
    // Top priority
    dispatch_queue_t que = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    // Image is the first priority
    dispatch_async(que, ^{
        
        NSString *urlPath = [_array_path objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:urlPath];
        
        NSData *dataImage = [NSData dataWithContentsOfURL:url];
        UIImage *imageFromWeb = [UIImage imageWithData:dataImage];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            MyTableViewCell *cell =(id)[tableView cellForRowAtIndexPath:indexPath];
            if (cell) {
                cell.MyImage.image = imageFromWeb;
                [_tableview_event reloadData];
            }
            
        });
    });
    
    return myCell;
    
}

#pragma mark To process to the next screen
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"DetailPush"]) {
        DetailViewController *objDVC = [segue destinationViewController];
        NSIndexPath *myIndexPath = [_tableview_event indexPathForSelectedRow];
        objDVC.myObject = [_array_event objectAtIndex:myIndexPath.row];
    }
}

@end
