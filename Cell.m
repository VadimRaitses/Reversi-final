//
//  Cell.m
//  Reversi
//
//  Created by Vadim Raitses on 9/28/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.
//

#import "Cell.h"

@interface Cell ()


@end

@implementation Cell

-(instancetype)initCell:(int) x :(int) y :(cellStatus) value {
    
    self.x_Value=x;
    self.y_Value=y;
    self.content=value;
    return self;
}


-(void)updateCell:(cellStatus) value ;
{
    self.content=value;
  
}
@end
