//
//  Game.m
//  Reversi
//
//  Created by Vadim Raitses on 9/27/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.
//

#import "Game.h"





@interface Game()



@end

@implementation Game

@synthesize field =_field;


-(instancetype) initGame{
    self = [super init];
    _field = self.createField;
    return self;
}





-(BOOL)gamePlay{
    

    return true;}

-(BOOL)fieldChecking:(int) demension :(Cell*) cell{


    return true;
}

- (NSMutableArray *)createField {
    
    NSMutableArray* gameField= [[NSMutableArray alloc]init];
    
    for(NSInteger i = 0;i<DIMENSION;i++)
    {
        NSMutableArray *row = [[NSMutableArray alloc]init];
        
        for(NSInteger j = 0;j<DIMENSION;j++)
        {
            Cell *cell;cellStatus cellStatus;

            if(i==3 && j==3)
                      cell = [[Cell alloc]initCell:i :j :cellStatus=FIRSPLAYER];
            else if(i==3 && j==4)
                      cell = [[Cell alloc]initCell:i :j :cellStatus=SECONDPLAYER];
            else if(i==4 && j==3)
                        cell = [[Cell alloc]initCell:i :j :cellStatus=SECONDPLAYER];
            else if(i==4 && j==4)
                        cell = [[Cell alloc]initCell:i :j :cellStatus=FIRSPLAYER];
            else
                        cell = [[Cell alloc]initCell:i :j :cellStatus=EMPTY];
            [row addObject:cell];
            
        }
     
        [gameField addObject:row];

    }
    
    return gameField;
}

-(void)initField{



 

}

-(void) resetGame:(int)count{}


-(void)countPlayerCells:(NSMutableArray*) field :(NSArray*) fieldButtons :(UILabel*) secondPlayerCount :(UILabel*) firstPLayerCount
{
    int firstPlayer=0;
    int secondPlayer=0;
    
    for(int i=0;i<fieldButtons.count; i++)
    {
        
        if([field[i/DIMENSION][i%DIMENSION] content] == FIRSPLAYER)
            firstPlayer++;
        
        if([field[i/DIMENSION][i%DIMENSION] content] == SECONDPLAYER)
            secondPlayer++;
        
    }
    
    firstPLayerCount.text = [NSString stringWithFormat:@"%d",firstPlayer];
    secondPlayerCount.text = [NSString stringWithFormat:@"%d",secondPlayer];
    
}

-(BOOL)PossiblePaths:(int) x :(int) y :(int) position :(NSArray*) fieldButtons :(BOOL) checkIfpathExist :(NSString*) playerOption :(cellStatus)playerTurn :(NSMutableDictionary*) computerPossibleMoves :(NSMutableArray*) field
{
    
    int countCells=1;
    int row=position/DIMENSION + x;
    int col=position%DIMENSION + y;
    NSString *keyIndex;
    while (row < DIMENSION && row>=0 && col>=0 && col<DIMENSION) {
        
        Cell *cell=field[row][col];
        
        if(playerTurn != cell.content && cell.content!=EMPTY )
        {
            
            countCells++;
            row+=x;
            col+=y;
            
        }
        else if(playerTurn == cell.content && countCells>1)
        {
            
            UIButton *cellButton = fieldButtons[position];
            if(playerTurn==FIRSPLAYER)
                [cellButton setImage:[UIImage imageNamed:@"button_step_2"] forState:UIControlStateNormal];
            
            if(playerTurn==SECONDPLAYER){
                [cellButton setImage:[UIImage imageNamed:@"button_step"] forState:UIControlStateNormal];
                if([playerOption isEqualToString:@"onePlayer"])
                {
                    keyIndex = [NSString stringWithFormat:@"%d", position];
                    if([computerPossibleMoves valueForKey:keyIndex] == nil)
                        [computerPossibleMoves setValue:[NSNumber numberWithInteger:countCells] forKey:keyIndex];
                    else
                    {
                        int pos = [[computerPossibleMoves valueForKey:keyIndex ] integerValue]+countCells;
                        [computerPossibleMoves setValue:[NSNumber numberWithInteger:pos] forKey:keyIndex];
                    }
                    
                }
            }
            
            checkIfpathExist = true;
            
           return checkIfpathExist;
        }
        else
            return checkIfpathExist;
    }
    
    return checkIfpathExist;
}


-(BOOL)findPath:(int) x :(int) y : (int) position :(cellStatus)playerTurn :(NSMutableArray*) field :(NSArray*) fieldButtons :(BOOL) changeToNextPLayer
{
    int countCells=1;
    int row=position/DIMENSION + x;
    int col=position%DIMENSION + y;
    
    NSString *imageName;
    
    cellStatus nextPlayer;
    
    if(playerTurn==FIRSPLAYER)
        nextPlayer=SECONDPLAYER;
    else
        nextPlayer=FIRSPLAYER;
    
    
    NSMutableArray *rowArray = [NSMutableArray array];
    NSMutableArray *colArray = [NSMutableArray array];
    
    [rowArray addObject:[NSNumber numberWithInteger:position/DIMENSION]];
    [colArray addObject:[NSNumber numberWithInteger:position%DIMENSION]];
    
    
    while (row < DIMENSION && row>=0 && col>=0 && col<DIMENSION) {
        
        Cell *cell=field[row][col];
        
        if(playerTurn != cell.content && cell.content!=EMPTY )
        {
            [rowArray addObject:[NSNumber numberWithInteger:row]];
            [colArray addObject:[NSNumber numberWithInteger:col]];
            countCells++;
            row+=x;
            col+=y;
            
            
        }
        else if(playerTurn == cell.content && countCells>1)
        {
            
            for(int i=0;i<rowArray.count;i++)
            {
                
                int rowOfCell = [[rowArray objectAtIndex:i] integerValue];
                int colOfCell = [[colArray objectAtIndex:i] integerValue];
                int index = rowOfCell*DIMENSION + colOfCell;
                
                [field[rowOfCell][colOfCell] updateCell: playerTurn];
                
                if(playerTurn==FIRSPLAYER)
                    imageName = @"button_red";
                else
                    imageName = @"white_play";
                
                UIButton *cellButton = fieldButtons[index];
                cellButton.hidden = false;
                [cellButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            }
            
            
            changeToNextPLayer = true;
            
            return changeToNextPLayer;
            
        }
        else
            return changeToNextPLayer;
    }
    
    return changeToNextPLayer;
}



@end
