//
//  TLCSolverViewController.m
//  Sudoku Solver
//
//  Created by andy on 2016-04-11.
//  Copyright © 2016 Te Lun Chen. All rights reserved.
//

#import "TLCSolverViewController.h"

@interface TLCSolverViewController ()

//naming convetion row-column
@property (strong, nonatomic) IBOutlet UILabel *one_one;
@property (strong, nonatomic) IBOutlet UILabel *one_two;
@property (strong, nonatomic) IBOutlet UILabel *one_three;
@property (strong, nonatomic) IBOutlet UILabel *one_four;
@property (strong, nonatomic) IBOutlet UILabel *one_five;
@property (strong, nonatomic) IBOutlet UILabel *one_six;
@property (strong, nonatomic) IBOutlet UILabel *one_seven;
@property (strong, nonatomic) IBOutlet UILabel *one_eight;
@property (strong, nonatomic) IBOutlet UILabel *one_nine;

@property (strong, nonatomic) IBOutlet UILabel *two_one;
@property (strong, nonatomic) IBOutlet UILabel *two_two;
@property (strong, nonatomic) IBOutlet UILabel *two_three;
@property (strong, nonatomic) IBOutlet UILabel *two_four;
@property (strong, nonatomic) IBOutlet UILabel *two_five;
@property (strong, nonatomic) IBOutlet UILabel *two_six;
@property (strong, nonatomic) IBOutlet UILabel *two_seven;
@property (strong, nonatomic) IBOutlet UILabel *two_eight;
@property (strong, nonatomic) IBOutlet UILabel *two_nine;

@property (strong, nonatomic) IBOutlet UILabel *three_one;
@property (strong, nonatomic) IBOutlet UILabel *three_two;
@property (strong, nonatomic) IBOutlet UILabel *three_three;
@property (strong, nonatomic) IBOutlet UILabel *three_four;
@property (strong, nonatomic) IBOutlet UILabel *three_five;
@property (strong, nonatomic) IBOutlet UILabel *three_six;
@property (strong, nonatomic) IBOutlet UILabel *three_seven;
@property (strong, nonatomic) IBOutlet UILabel *three_eight;
@property (strong, nonatomic) IBOutlet UILabel *three_nine;

@property (strong, nonatomic) IBOutlet UILabel *four_one;
@property (strong, nonatomic) IBOutlet UILabel *four_two;
@property (strong, nonatomic) IBOutlet UILabel *four_three;
@property (strong, nonatomic) IBOutlet UILabel *four_four;
@property (strong, nonatomic) IBOutlet UILabel *four_five;
@property (strong, nonatomic) IBOutlet UILabel *four_six;
@property (strong, nonatomic) IBOutlet UILabel *four_seven;
@property (strong, nonatomic) IBOutlet UILabel *four_eight;
@property (strong, nonatomic) IBOutlet UILabel *four_nine;

@property (strong, nonatomic) IBOutlet UILabel *five_one;
@property (strong, nonatomic) IBOutlet UILabel *five_two;
@property (strong, nonatomic) IBOutlet UILabel *five_three;
@property (strong, nonatomic) IBOutlet UILabel *five_four;
@property (strong, nonatomic) IBOutlet UILabel *five_five;
@property (strong, nonatomic) IBOutlet UILabel *five_six;
@property (strong, nonatomic) IBOutlet UILabel *five_seven;
@property (strong, nonatomic) IBOutlet UILabel *five_eight;
@property (strong, nonatomic) IBOutlet UILabel *five_nine;

@property (strong, nonatomic) IBOutlet UILabel *six_one;
@property (strong, nonatomic) IBOutlet UILabel *six_two;
@property (strong, nonatomic) IBOutlet UILabel *six_three;
@property (strong, nonatomic) IBOutlet UILabel *six_four;
@property (strong, nonatomic) IBOutlet UILabel *six_five;
@property (strong, nonatomic) IBOutlet UILabel *six_six;
@property (strong, nonatomic) IBOutlet UILabel *six_seven;
@property (strong, nonatomic) IBOutlet UILabel *six_eight;
@property (strong, nonatomic) IBOutlet UILabel *six_nine;

@property (strong, nonatomic) IBOutlet UILabel *seven_one;
@property (strong, nonatomic) IBOutlet UILabel *seven_two;
@property (strong, nonatomic) IBOutlet UILabel *seven_three;
@property (strong, nonatomic) IBOutlet UILabel *seven_four;
@property (strong, nonatomic) IBOutlet UILabel *seven_five;
@property (strong, nonatomic) IBOutlet UILabel *seven_six;
@property (strong, nonatomic) IBOutlet UILabel *seven_seven;
@property (strong, nonatomic) IBOutlet UILabel *seven_eight;
@property (strong, nonatomic) IBOutlet UILabel *seven_nine;

@property (strong, nonatomic) IBOutlet UILabel *eight_one;
@property (strong, nonatomic) IBOutlet UILabel *eight_two;
@property (strong, nonatomic) IBOutlet UILabel *eight_three;
@property (strong, nonatomic) IBOutlet UILabel *eight_four;
@property (strong, nonatomic) IBOutlet UILabel *eight_five;
@property (strong, nonatomic) IBOutlet UILabel *eight_six;
@property (strong, nonatomic) IBOutlet UILabel *eight_seven;
@property (strong, nonatomic) IBOutlet UILabel *eight_eight;
@property (strong, nonatomic) IBOutlet UILabel *eight_nine;

@property (strong, nonatomic) IBOutlet UILabel *nine_one;
@property (strong, nonatomic) IBOutlet UILabel *nine_two;
@property (strong, nonatomic) IBOutlet UILabel *nine_three;
@property (strong, nonatomic) IBOutlet UILabel *nine_four;
@property (strong, nonatomic) IBOutlet UILabel *nine_five;
@property (strong, nonatomic) IBOutlet UILabel *nine_six;
@property (strong, nonatomic) IBOutlet UILabel *nine_seven;
@property (strong, nonatomic) IBOutlet UILabel *nine_eight;
@property (strong, nonatomic) IBOutlet UILabel *nine_nine;

@property (nonatomic, strong) NSTimer* timer;

@end

@implementation TLCSolverViewController

NSMutableArray *board;
NSMutableArray *ingnoreIndex;
int currentIndex = 0;
int buttonIndex = 0;
UIButton *currentButton;
bool backtracing = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //navigation bar
    self.navigationController.navigationBar.translucent = NO;
    self.title=@"Sudoku Solver";
    
    //navigation bar right button
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStyleDone target:self action:@selector(solve)];
    self.navigationItem.rightBarButtonItem = right;
    
    //navigation bar left button
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    [backButton setImage:[UIImage imageNamed:@"restart"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    board = [[NSMutableArray alloc]init];
    ingnoreIndex = [[NSMutableArray alloc]init];
    
    [board addObject:_one_one];
    [board addObject:_one_two];
    [board addObject:_one_three];
    [board addObject:_one_four];
    [board addObject:_one_five];
    [board addObject:_one_six];
    [board addObject:_one_seven];
    [board addObject:_one_eight];
    [board addObject:_one_nine];
    
    [board addObject:_two_one];
    [board addObject:_two_two];
    [board addObject:_two_three];
    [board addObject:_two_four];
    [board addObject:_two_five];
    [board addObject:_two_six];
    [board addObject:_two_seven];
    [board addObject:_two_eight];
    [board addObject:_two_nine];
    
    [board addObject:_three_one];
    [board addObject:_three_two];
    [board addObject:_three_three];
    [board addObject:_three_four];
    [board addObject:_three_five];
    [board addObject:_three_six];
    [board addObject:_three_seven];
    [board addObject:_three_eight];
    [board addObject:_three_nine];
    
    [board addObject:_four_one];
    [board addObject:_four_two];
    [board addObject:_four_three];
    [board addObject:_four_four];
    [board addObject:_four_five];
    [board addObject:_four_six];
    [board addObject:_four_seven];
    [board addObject:_four_eight];
    [board addObject:_four_nine];
    
    [board addObject:_five_one];
    [board addObject:_five_two];
    [board addObject:_five_three];
    [board addObject:_five_four];
    [board addObject:_five_five];
    [board addObject:_five_six];
    [board addObject:_five_seven];
    [board addObject:_five_eight];
    [board addObject:_five_nine];
    
    [board addObject:_six_one];
    [board addObject:_six_two];
    [board addObject:_six_three];
    [board addObject:_six_four];
    [board addObject:_six_five];
    [board addObject:_six_six];
    [board addObject:_six_seven];
    [board addObject:_six_eight];
    [board addObject:_six_nine];
    
    [board addObject:_seven_one];
    [board addObject:_seven_two];
    [board addObject:_seven_three];
    [board addObject:_seven_four];
    [board addObject:_seven_five];
    [board addObject:_seven_six];
    [board addObject:_seven_seven];
    [board addObject:_seven_eight];
    [board addObject:_seven_nine];
    
    [board addObject:_eight_one];
    [board addObject:_eight_two];
    [board addObject:_eight_three];
    [board addObject:_eight_four];
    [board addObject:_eight_five];
    [board addObject:_eight_six];
    [board addObject:_eight_seven];
    [board addObject:_eight_eight];
    [board addObject:_eight_nine];
    
    [board addObject:_nine_one];
    [board addObject:_nine_two];
    [board addObject:_nine_three];
    [board addObject:_nine_four];
    [board addObject:_nine_five];
    [board addObject:_nine_six];
    [board addObject:_nine_seven];
    [board addObject:_nine_eight];
    [board addObject:_nine_nine];
    
}

- (void) solve{
    currentButton.backgroundColor = [UIColor clearColor];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.00001
                                                  target:self
                                                selector:@selector(updateTable)
                                                userInfo:nil
                                                 repeats:YES];
}

-(void) restart{
    
    [self.timer invalidate];
    
    ingnoreIndex = [[NSMutableArray alloc]init];
    
    UILabel *current;
    for (int i=0;i<81;i++){
        current = [board objectAtIndex:i];
        current.font = [UIFont systemFontOfSize:25.0f];
        current.text = @"";
        
    }
    
    currentIndex = 0;
    buttonIndex = 0;
    currentButton.backgroundColor = [UIColor clearColor];
    backtracing = false;

    
}

-(void)updateTable{
    if ([self isInputSafe]){
        [self solvePosition:currentIndex];
    }
    else{
        [self.timer invalidate];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oh-oh!" message:@"Something doesn't look right" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:okButton];
        [self presentViewController: alert animated: YES completion:nil];
    }
}

-(void)solvePosition:(NSInteger)index{
    if (index >=0 &&index <=80){
        UILabel *current = [board objectAtIndex:index];
        int num = 1;
        
        if([self isGridEmpty:index]){
            while(num<=9){
                current.text = [@(num) stringValue];
                [current setNeedsDisplay];
                if ([self isRowSafe:index]&&[self isColumnSafe:index]&&[self is3x3Safe:index]){
                    if (index+1<=81){
                        backtracing = false;
                        currentIndex++;
                    }
                    break;
                }
                else{
                    num++;
                    if (num>9){
                        current.text = @"";
                        backtracing = true;
                        currentIndex--;
                    }
                }
            }
        }
        else{
            if ([ingnoreIndex containsObject:@(index)]){
                if (backtracing){
                    currentIndex--;
                }
                else{
                    currentIndex++;
                }
            }
            else{
                while(num<=9){
                    if ([current.text intValue]+1<=10){
                        num = [current.text intValue]+1;
                    }
                    current.text = [@(num) stringValue];
                    [current setNeedsDisplay];
                    if ([self isRowSafe:index]&&[self isColumnSafe:index]&&[self is3x3Safe:index] && num <10){
                        if (index+1<=81){
                            backtracing = false;
                            currentIndex++;
                        }
                        break;
                    }
                    else{
                        num++;
                        if (num>9){
                            current.text = @"";
                            backtracing = true;
                            currentIndex--;
                            break;
                        }
                    }
                }
            }

        }
    }
    else{
        [self.timer invalidate];
    }
}

-(BOOL)isInputSafe{
    bool safe = true;
    int i=0;
    for (NSNumber *index in ingnoreIndex){
        // add and subtract index so warnning goes away!
        int value = [[ingnoreIndex objectAtIndex:i] intValue] + [index intValue] - [index intValue];
        i++;
        if (!([self isRowSafe:value]&&[self isColumnSafe:value]&&[self is3x3Safe:value])){
            safe = false;
        }
    }
    return safe;
}

-(BOOL)is3x3Safe:(NSInteger)index{
    bool safe = true;
    UILabel *current = [board objectAtIndex:index];
    NSArray *array;
    for (int box=1;box<10;box++){
        if (box == 1){
            array = @[@0,@1,@2,@9,@10,@11,@18,@19,@20];
            if ([array containsObject:@(index)]){
                break;
            }
        }
        else if (box == 2){
            array = @[@3,@4,@5,@12,@13,@14,@21,@22,@23];
            if ([array containsObject:@(index)]){
                break;
            }
        }
        else if (box == 3){
            array = @[@6,@7,@8,@15,@16,@17,@24,@25,@26];
            if ([array containsObject:@(index)]){
                break;
            }
        }
        else if (box == 4){
            array = @[@27,@28,@29,@36,@37,@38,@45,@46,@47];
            if ([array containsObject:@(index)]){
                break;
            }
        }
        else if (box == 5){
            array = @[@30,@31,@32,@39,@40,@41,@48,@49,@50];
            if ([array containsObject:@(index)]){
                break;
            }
        }
        else if (box == 6){
            array = @[@33,@34,@35,@42,@43,@44,@51,@52,@53];
            if ([array containsObject:@(index)]){
                break;
            }
        }
        else if (box == 7){
            array = @[@54,@55,@56,@63,@64,@65,@72,@73,@74];
            if ([array containsObject:@(index)]){
                break;
            }
        }
        else if (box == 8){
            array = @[@57,@58,@59,@66,@67,@68,@75,@76,@77];
            if ([array containsObject:@(index)]){
                break;
            }
        }
        else if (box == 9){
            array = @[@60,@61,@62,@69,@70,@71,@78,@79,@80];
            if ([array containsObject:@(index)]){
                break;
            }
        }
    }
    
    for (int i=0;i<9;i++){
        if ([array[i] integerValue]!= index){
            UILabel *temp = [board objectAtIndex:[array[i]integerValue]];
            if ([temp.text intValue] == [current.text intValue]){
                safe = false;
                NSLog(@":///");
            }
        }
    }
    
    return safe;
}

-(BOOL)isColumnSafe:(NSInteger)index{
    bool safe = true;
    
    UILabel *current = [board objectAtIndex:index];
    
    int column = index % 9;
    
    for (int i=column;i<(81+column);i=i+9){
        if (i != index){
            UILabel *temp = [board objectAtIndex:i];
            if ([temp.text intValue] == [current.text intValue]){
                safe = false;
                NSLog(@"://");
            }
        }
    }
    return safe;
}


-(BOOL)isRowSafe:(NSInteger)index{
    
    bool safe = true;
    
    UILabel *current = [board objectAtIndex:index];
    
    int row = index/9.0;
    for (int i=row*9;i<(row*9+9);i++){
        if (i != index){
            UILabel *temp = [board objectAtIndex:i];
            if ([temp.text intValue] == [current.text intValue]){
                safe = false;
                NSLog(@":/");
            }
        }
    }
    return safe;
}

- (BOOL)isBoardEmpty {
    bool empty = true;
    UILabel *current;
    
    for (int i=0;i<81;i++){
        current = [board objectAtIndex:i];
        if (current.text && current.text.length >0){
            empty = false;
        }
    }
    
    return empty;
}

-(BOOL)isGridEmpty: (NSInteger)index{
    bool empty = true;
    UILabel *current = [board objectAtIndex:index];
    if (current.text && current.text.length >0){
        empty = false;
    }
    return empty;
}
- (IBAction)selectedGrid:(id)sender {
    currentButton.backgroundColor = [UIColor clearColor];
    UIButton *resultebutton= (UIButton*)sender;
    resultebutton.backgroundColor = [UIColor lightGrayColor];
    resultebutton.alpha = 0.5;
    currentButton = resultebutton;
    buttonIndex = [resultebutton.titleLabel.text intValue];
    NSLog(@"The button title is %d ",buttonIndex);
}

- (IBAction)inputGrid:(id)sender {
    UIButton *resultebutton= (UIButton*)sender;
    [ingnoreIndex addObject:@(buttonIndex)];
    UILabel *currentLabel = [board objectAtIndex:buttonIndex];
    if ([resultebutton.titleLabel.text isEqualToString: @"-"]){
        currentLabel.font = [UIFont systemFontOfSize:25.0f];
        currentLabel.text = @"";
        for (id num in ingnoreIndex){
            if ([num isEqual:@(buttonIndex)]){
                [ingnoreIndex removeObject:num];
                break;
            }
        }
    }
    else{
        currentLabel.font = [UIFont boldSystemFontOfSize:25.0f];
        currentLabel.text = resultebutton.titleLabel.text;
    }
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
