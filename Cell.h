//
//  Cell.h
//  Reversi
//
//  Created by Vadim Raitses on 9/28/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cellStatus.h"

@interface Cell : NSObject

@property (nonatomic,readwrite) cellStatus content;
@property (nonatomic) NSUInteger x_Value;
@property (nonatomic) NSUInteger y_Value;



-(instancetype)initCell:(int) x :(int) y :(cellStatus) value ;

-(void)updateCell:(cellStatus) value ;

@end
