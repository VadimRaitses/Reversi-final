//
//  Game.h
//  Reversi
//
//  Created by Vadim Raitses on 9/27/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.
//
#import "Cell.h"

#import <Foundation/Foundation.h>
static  int DIMENSION = 8;
static  int NUMOFPATHS = 8;
@interface Game : NSObject

@property (strong, readwrite) NSMutableArray *field;
@property (strong, nonatomic) NSArray *onePlayer;
@property (strong, nonatomic) NSArray *secondPlayer;
@property (nonatomic) BOOL playerTurn;

-(instancetype) initGame;
-(BOOL)gamePlay;
-(void)initField;
-(void) resetGame:(int)count;
//-(void)checkWinner:(NSArray*) fieldButtons :(UIAlertView*) message;
-(BOOL)PossiblePaths:(int) x :(int) y :(int) position :(NSArray*) fieldButtons :(BOOL) checkIfpathExist :(NSString*) playerOption :(cellStatus) playerTurn :(NSMutableDictionary*) computerPossibleMoves :(NSMutableArray*) field;
-(BOOL)findPath:(int) x :(int) y :(int) position :(cellStatus)playerTurn :(NSMutableArray*) field :(NSArray*) fieldButtons :(BOOL) changeToNextPLayer;
-(void)countPlayerCells:(NSMutableArray*) field :(NSArray*) fieldButtons :(UILabel*) secondPlayerCount :(UILabel*) firstPLayerCount;


@end
