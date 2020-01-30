//
//  AddItemViewController.h
//  ToDoTask
//
//  Created by Roman Divkovic on 2020-01-29.
//  Copyright © 2020 Roman Divkovic. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AddItemViewControllerDelegate <NSObject>

- (void)didSaveNewToDo:(NSString *)todoText;

@end

@interface AddItemViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) id <AddItemViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end

NS_ASSUME_NONNULL_END
