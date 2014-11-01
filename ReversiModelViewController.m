//
//  ReversiModelViewController.m
//  Reversi
//
//  Created by Vadim Raitses on 9/5/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.
//

#import "ReversiModelViewController.h"
#import "GameViewControler.h"
@interface ReversiModelViewController()


//
@property (weak, nonatomic) IBOutlet UIButton *onePlayer;
@property (weak, nonatomic) IBOutlet UIButton *twoPlayers;
@property(weak,nonatomic)   NSUserDefaults* standartUserdefaults;
@property (strong,nonatomic)  NSString* playerOption;
//@property (nonatomic, retain) IBOutlet UIView *gameViewController;
@end


@implementation ReversiModelViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
GameViewControler *game = 	[segue destinationViewController];
    if([segue.identifier isEqualToString:@"seg1"]){
       // NSLog(@"seg1");
        
        game.playerOption = @"onePlayer";
    
    }
    if([segue.identifier isEqualToString:@"seg2"]){
       // NSLog(@"seg2");
        
        game.playerOption = @"twoPlayers";
        
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];    // Do any additional setup after loading the view.
    _standartUserdefaults= [NSUserDefaults standardUserDefaults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onePlayerClick:(UIButton *)sender {
    
    _playerOption = @"onePlayer";
    
    
}


- (IBAction)twoPlayers:(UIButton *)sender {
    
    _playerOption= @"twoPlayers";

    
}


-(void)viewWillDisappear :(BOOL)animated{
[_standartUserdefaults setObject:_playerOption forKey:@"PLAYER"];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */




@end
