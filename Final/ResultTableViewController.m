//
//  ResultTableViewController.m
//  Final
//
//  Created by Thor on 5/12/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import "ResultTableViewController.h"

#define locurl "http://qpublic7.qpublic.net/ga_alsearch.php?Address_Search=Address+Search&county=ga_barrow&searchType=address_search&streetUnit=&streetDirection=&streetType=&streetName=&streetNumber=&BEGIN=50"
@interface ResultTableViewController ()
@property dispatch_queue_t globalQ;
@end

@implementation ResultTableViewController

@synthesize locatLat,locatLong;

@synthesize county;

@synthesize streetName,addressNumber;

@synthesize searchTable, searchmethod;
@synthesize currentelement,pastelement;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    pastelement = @"";
    _globalQ =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //NSString *urlString = @"http://qpublic7.qpublic.net/ga_alsearch.php?Address_Search=Address+Search&county=ga_barrow&searchType=address_search&streetUnit=&streetDirection=&streetType=&streetName=&streetNumber=&BEGIN=50";
    NSString *urlString = [NSString stringWithFormat: @"http://qpublic7.qpublic.net/ga_alsearch.php?BEGIN=0&streetNumber=%d&streetName=%@&streetType=&streetDirection=&streetUnit=&searchType=address_search&county=ga_barrow&Address_Search=Address+Search",self.addressNumber,self.streetName];
    //NSLog(@"url : %@",urlString);
    NSURL *htmlURL = [NSURL URLWithString:urlString];

    NSData *data = [NSData dataWithContentsOfURL:htmlURL];
    
    TFHpple *tableparser = [TFHpple hppleWithHTMLData:data];
    
    NSString *queryString = @"//table[@align='center']/tr/td";
    
    NSArray *propertyvals = [tableparser searchWithXPathQuery:queryString];
    
    //NSLog(@"Array%@",propertyvals);
    
    self.searchTable = [[NSMutableArray alloc] init];
    propertyData *property = [[propertyData alloc]init];
    int i =0;
    int test =-1;
    for (TFHppleElement *element in propertyvals) {
        //NSLog(@"element%@",element.children);
        int x=0;
        while (x<element.children.count) {
           // NSLog(@"elements values for  %d :%@",x,[element.children objectAtIndex:x]);
            x++;
        }
        if ((test==-1)&&(element.children.count > 2)) {
            property = [[propertyData alloc]init];
            property.url = [((TFHppleElement *)[element.children objectAtIndex:1])objectForKey:@"href"];
          //  property.parcelNum =[[element firstChild] content];
           // NSLog(@"element%@",[element.children objectAtIndex:1] );
           // if ([[element.children objectAtIndex:1] isMemberOfClass:[TFHppleElement class]]) {
           //     NSLog(@"found");
                //NSLog(@"item %@", [((TFHppleElement *)[element.children objectAtIndex:1]));
          //  }
            //NSLog(@"element item %@", [((TFHppleElement *)[element.children objectAtIndex:1]) content ] );
            test =0;
            i=1;
        }else if(test==0){
            if ((i%5==1)){
                property.ownerName =[[element firstChild] content];
             //   NSLog(@"ownerName%@",element.children);
            }else if (i%5==2){
                property.Address =[[element firstChild] content];
              //  NSLog(@"Address%@",element.children);
            }else if (i%5==3){
                property.legalInfo =[[element firstChild] content];
               // NSLog(@"legalInfo%@",element.children);
            }else if (i%5==4){
                property.mapInfo =[[element firstChild] content];
               // NSLog(@"mapInfo%@",element.children);
                [searchTable addObject:property];
                test=-1;
            }
            i++;
        }
        
    }
    //NSLog(@"table %@",searchTable);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.searchTable.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    cell.textLabel.text = ((propertyData *)[self.searchTable objectAtIndex:indexPath.row]).Address;
    cell.detailTextLabel.text =((propertyData *)[self.searchTable objectAtIndex:indexPath.row]).ownerName;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"PropertyDetail"]) {
        NSIndexPath *datatransfer= [self.tableView indexPathForCell:sender];
        ResultViewController *secondVC= (ResultViewController *)segue.destinationViewController;
        secondVC.url = ((propertyData *)[self.searchTable objectAtIndex:datatransfer.row]).url;

    }
}
@end
