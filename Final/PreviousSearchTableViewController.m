//
//  PreviousSearchTableViewController.m
//  Final
//
//  Created by unbounded on 5/20/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import "PreviousSearchTableViewController.h"
#import "ResultViewController.h"
@interface PreviousSearchTableViewController ()

@end

@implementation PreviousSearchTableViewController
@synthesize DatebaseArray;
@synthesize DataMang;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.DataMang = [[DataStorage alloc] init];
    self.DatebaseArray = [[NSMutableArray alloc] init];
    self.DatebaseArray = [DataMang readBasicFromDataBase];
    //NSLog(@"Database values : %@", [DataMang readBasicFromDataBase]);
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.DatebaseArray = [[NSMutableArray alloc] init];
    self.DatebaseArray = [DataMang readBasicFromDataBase];
    //NSLog(@"Database values : %@", [DataMang readBasicFromDataBase]);
    [self.tableView reloadData];
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
    return self.DatebaseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DataCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [[self.DatebaseArray objectAtIndex:indexPath.row] objectAtIndex:1];
    cell.detailTextLabel.text =[[self.DatebaseArray objectAtIndex:indexPath.row] objectAtIndex:2];
    // Configure the cell...
    
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
    
    if ([segue.identifier isEqualToString:@"PropertyDetails"]) {
        NSIndexPath *datatransfer= [self.tableView indexPathForCell:sender];
        ResultViewController *secondVC= (ResultViewController *)segue.destinationViewController;
        //NSLog(@"object %@",[[self.DatebaseArray objectAtIndex:datatransfer.row] objectAtIndex:0] );
        secondVC.url = (NSString *)[[self.DatebaseArray objectAtIndex:datatransfer.row] objectAtIndex:0];
        
    }
}
@end
