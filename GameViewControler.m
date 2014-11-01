//
//  GameViewControler.m
//  Reversi
//
//  Created by Vadim Raitses on 9/27/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.
//

#import "GameViewControler.h"
#import "ReversiModelViewController.h"
#import "Game.h"
#import "Cell.h"

@interface GameViewControler ()
@property (strong, nonatomic)Game* game;
@property (strong, nonatomic)NSMutableArray* field;
@property (strong, nonatomic) IBOutletCollection(UIButton)NSArray *fieldButtons;
@property (nonatomic) cellStatus playerTurn;
@property (nonatomic)BOOL changeToNextPLayer;
@property (nonatomic)BOOL checkIfpathExist;
@property (weak, nonatomic) IBOutlet UILabel *playerTurnLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstPLayerCount;
@property (weak, nonatomic) IBOutlet UILabel *secondPlayerCount;
@property (strong,nonatomic) NSMutableDictionary* computerPossibleMoves;



@end



@implementation GameViewControler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.game=[[Game alloc] initGame];
    self.field=[self.game field];
    self.playerTurn=FIRSPLAYER;
    self.changeToNextPLayer = false;
    self.playerTurnLabel.text = @"Player 1";
    self.firstPLayerCount.text= @"2";
    self.secondPlayerCount.text= @"2";
    self.checkIfpathExist = true;
    [self findPossiblePaths];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewWillAppear:(BOOL)animated
{
    

  //  NSString *Player = self.playerOption;
 //  NSLog(@"inGame  %@",Player);

}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"OK"])
    {
        UIStoryboard *storyboard = self.storyboard;
        ReversiModelViewController *svc = [storyboard instantiateInitialViewController];
        [self presentViewController:svc animated:YES completion:nil];
 
    }

}


- (IBAction)touchStandButton:(UIButton *)sender {
    
    NSInteger anIndex=[self.fieldButtons indexOfObject:sender];
    if(NSNotFound == anIndex) {
        NSLog(@"not found");
    }
    int row=anIndex/DIMENSION;
    int col=anIndex%DIMENSION;
    Cell *cell=self.field[row][col];

    if(self.playerTurn != cell.content && cell.content==EMPTY )
    {
        [self checkMove:anIndex :false];
    }
 
    

}

-(void)computerInit{
    
    self.computerPossibleMoves = [[NSMutableDictionary alloc]init];
  
}


-(void)computerStep
{
    
    NSString  *keyOfBigestValue;
    NSInteger value = 0;
    NSInteger posOfBestPath;
    
    for(NSString *key in self.computerPossibleMoves)
    {
        
        if(value < [[self.computerPossibleMoves valueForKey:key] intValue])
        {
            keyOfBigestValue = key;
            value = [[self.computerPossibleMoves valueForKey:key] intValue];
        }
    }
    
    posOfBestPath = [keyOfBigestValue integerValue];

   ////timer
    
    UIButton *cellButton = self.fieldButtons[posOfBestPath];
          [cellButton setImage:[UIImage imageNamed:@"button_step_border"] forState:UIControlStateNormal];

    int64_t delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    
        [self checkMove:posOfBestPath :false];
            });

    
}




-(void)checkMove:(int) position :(BOOL) possibleMOves
{

    int row = -1;
    int col = -1;
    
    for(int i=0; i<NUMOFPATHS;i++)
    {
        
        if(i==1)
        {
            row=-1;
            col = 0;
        }
        
        if(i==2)
        {
            row = -1;
            col = +1;
        }
        
        if(i==3)
        {
            row = 0;
            col = +1;
        }
        
        if(i==4)
        {
            row = +1;
            col = +1;
        }
        
        if(i==5)
        {
            row = +1;
            col = 0;
        }
        
        if(i==6)
        {
            row = +1;
            col = -1;
        }
        
        if(i==7)
        {
            row = 0;
            col = -1;
        }
        
       if(possibleMOves)
           _checkIfpathExist = [self.game PossiblePaths:row :col :position :_fieldButtons :_checkIfpathExist :_playerOption :_playerTurn :_computerPossibleMoves :_field];
        else
            _changeToNextPLayer = [self.game findPath:row :col :position :_playerTurn :_field :_fieldButtons :_changeToNextPLayer];
        
    }
    
    if(self.changeToNextPLayer)
    {
        if(self.playerTurn==FIRSPLAYER)
        {
            self.playerTurn=SECONDPLAYER;
            self.playerTurnLabel.text = @"Player 2";
            
            if([self.playerOption isEqualToString:@"onePlayer"])
                [self computerInit];
        }
        else
        {
            self.playerTurn=FIRSPLAYER;
            self.playerTurnLabel.text = @"Player 1";
        }
        self.changeToNextPLayer = false;
        
        [self.game countPlayerCells:_field :_fieldButtons :_secondPlayerCount :_firstPLayerCount];
        [self findPossiblePaths];
       

    }
    
 
 
}


////////
-(void)findPossiblePaths
{
   
    self.checkIfpathExist = false;
    for(int i=0;i<self.fieldButtons.count; i++)
    {
        
        if([self.field[i/DIMENSION][i%DIMENSION] content] == EMPTY)
        {
            UIButton *cellButton = self.fieldButtons[i];
            [cellButton setImage:[UIImage imageNamed:@"Button"] forState:UIControlStateNormal];
            [self checkMove:i :true];
        }
    }

    if(!(self.checkIfpathExist))
        [self checkWinner];
    else if([self.playerOption isEqualToString:@"onePlayer"] && self.playerTurn==SECONDPLAYER)
        [self computerStep];

    
}


//////
-(void)checkWinner
{
    int firstPlayer=0;
    int secondPlayer=0;
     NSString *winner;
    
    for(int i=0;i<self.fieldButtons.count; i++)
    {
        
        if([self.field[i/DIMENSION][i%DIMENSION] content] == FIRSPLAYER)
            firstPlayer++;
        
        if([self.field[i/DIMENSION][i%DIMENSION] content] == SECONDPLAYER)
            secondPlayer++;
        
    }
    
    if(firstPlayer > secondPlayer)
        winner = @"Player 1 is winner";
    else if(secondPlayer > firstPlayer)
        winner = @"Player 2 is winner";
    else
        winner = @"is draft";
  
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                      message: winner
                                                     delegate: self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];

    
    [message show];
    
  
}


-(void)viewWillDisappear:(BOOL)animated{
    NSString* a = @"";
    NSUserDefaults* standartUserdefaults = [NSUserDefaults standardUserDefaults];
    [standartUserdefaults setObject:a forKey:@"PLAYER"];

}

@end
