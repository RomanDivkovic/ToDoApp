//
//  ViewController.m
//  ToDoTask
//
//  Created by Roman Divkovic on 2020-01-28.
//  Copyright © 2020 Roman Divkovic. All rights reserved.
//

#import "ViewController.h"
#import "TaskTableViewCell.h"
#import "AddItemViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableArray *todos;

@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.todos = [[NSMutableArray alloc] init];
    
       if ([[NSUserDefaults standardUserDefaults] objectForKey:@"key"] == nil) {
           self.todos = @[@{@"name" : @"click the + to make a ToDo"}].mutableCopy;
       }else {
           self.todos = [[[NSUserDefaults standardUserDefaults] objectForKey:@"key"]mutableCopy];
       }
}
-(void)saveItemsToDefaults:(NSArray *) todos{
    [[NSUserDefaults standardUserDefaults] setObject:todos forKey:@"key"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.todos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"TaskTableViewCell";
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSString *todoText = self.todos[indexPath.row];
    
    if(nil == cell) {
        cell = [[TaskTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = todoText;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Hello I was touched: %@", indexPath);
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}
/*-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *nav = segue.destinationViewController;
    AddItemViewController *addVC = nav.viewControllers[0];
    addVC.delegate = (id<AddItemViewControllerDelegate>)self;
}
-(void) didSaveNewToDo: (NSDictionary *)todoText {
    [self.todos addObject:todoText];
    [self saveItemsToDefaults:self.todos];
    [self.tabelView reloadData];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.todos removeObjectAtIndex:indexPath.row];
    [self saveItemsToDefaults:self.todos];
    [self.tabelView reloadData];
}


@end
