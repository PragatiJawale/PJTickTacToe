//
//  ViewController.m
//  PJTickTacToe
//
//  Created by Pragati on 26/09/16.
//  Copyright © 2016 Pragati Jawale. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initGame];
    
}
-(void)initGame{
    numberOfTurn=0;
    currentPlayer=1;
    isGameFinished =false;
    winingCombinations =@[@ [@0,@1,@2],@ [@3,@4,@5],@ [@6,@7,@8],@ [@0,@3,@6],@ [@1,@4,@7],@ [@2,@5,@8],@ [@0,@4,@8],@ [@2,@4,@6]];
    
    currentStat =[[NSMutableArray alloc]initWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0, nil];
   
    for(int i=100; i<=108; i++){
        UIButton *button=[self.view viewWithTag:i];
        [button setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
        
    }
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)win:(NSString *)player
{
    [self showAlertWithTitle:@"Won" message:[NSString stringWithFormat:@"Congrats!,%@ won the game",player] ];
    
    
}
-(void) showAlertWithTitle:(NSString *)Title
                   message:(NSString *)message
{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:Title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *OK =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK Button Pressed !");
    }];
    [alert addAction:OK];
    [self presentViewController:alert animated:YES completion:nil];

}
-(void)alertForEndWithTitle:(NSString *)Title message:(NSString *)message

{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:Title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self initGame];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [alert addAction:ok];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        exit(0);
        
    }];
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}



- (IBAction)buttonTap:(id)sender {
   
    numberOfTurn = numberOfTurn + 1;
    
    UIButton *tile = sender;
    UIImage *playerImage;
    int player = currentPlayer;
    
    BOOL isButtonNotSelected = [[currentStat objectAtIndex:(tile.tag - 100)] isEqual:@0];
    
    if (isButtonNotSelected) {
        
        if (!isGameFinished) {
            if (player == 1) {
                playerImage = [UIImage imageNamed:@"nought"];
                [currentStat replaceObjectAtIndex:(tile.tag - 100) withObject:@1];
                
                currentPlayer = 2;
            }
            else
                
            {
                playerImage = [UIImage imageNamed:@"cross"];
                [currentStat replaceObjectAtIndex:(tile.tag - 100) withObject:@2];
                currentPlayer = 1;
            }
        }
        
        [tile setBackgroundImage:playerImage forState:UIControlStateNormal];
    }
    else {
        [self showAlertWithTitle:@"Caution" message:@"Please select another tile" ];
    }
    
    
    if (numberOfTurn >=5) {
        for (NSArray *combination in winingCombinations) {
            int indexOfButtnOne = [[combination objectAtIndex:0]intValue];
            int indexOfButtnTwo = [[combination objectAtIndex:1]intValue];
            int indexOfButtnThree = [[combination objectAtIndex:2]intValue];
            NSNumber *stateAtButtonOne = [currentStat objectAtIndex:indexOfButtnOne];
            NSNumber *stateAtButtonTwo = [currentStat objectAtIndex:indexOfButtnTwo];
            NSNumber *stateAtButtonThree = [currentStat objectAtIndex:indexOfButtnThree];
            
            if (![stateAtButtonOne isEqual:@0] && [stateAtButtonOne isEqual:stateAtButtonTwo] && [stateAtButtonTwo isEqual:stateAtButtonThree])
            {
                isGameFinished = YES;
                NSString *winnerString = [NSString stringWithFormat:@"Player %d has Won",player];
                
                [self alertForEndWithTitle:winnerString message:@"Do you want to play again"];
                break;
            }
        }
    }
    if (!isGameFinished) {
        BOOL zeroValuePresent = [currentStat containsObject:@0];
        
        if (!zeroValuePresent) {
            [self alertForEndWithTitle:@"Game Draw" message:@"Do you want to play again"];
        }
    }
    
}


    @end

