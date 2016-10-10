//
//  ViewController.h
//  PJTickTacToe
//
//  Created by Pragati on 26/09/16.
//  Copyright © 2016 Pragati Jawale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    int numberOfTurn,currentPlayer;
    BOOL isGameFinished;
    NSArray *winingCombinations;
    NSMutableArray *currentStat;
}
- (IBAction)buttonTap:(id)sender;


@end

