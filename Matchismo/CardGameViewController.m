//
//  CardGameViewController.m
//  Matchismo
//
//  Created by 张 俊 on 14-2-11.
//  Copyright (c) 2014年 zhangjun. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *modeSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *matchResultLabel;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _matchResultLabel.text = @"";
    
    [_modeSegmentedControl setTitle:@"2-card-match mode" forSegmentAtIndex:0];
    [_modeSegmentedControl setTitle:@"3-card-match mode" forSegmentAtIndex:1];
    [_modeSegmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    _modeSegmentedControl.selectedSegmentIndex = 0;
}

- (void)segmentChanged:(UISegmentedControl *)sender{
    self.game.mode = sender.selectedSegmentIndex + 1;
}

- (Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    _matchResultLabel.text = self.game.hint;
    self.modeSegmentedControl.enabled = NO;
}

- (IBAction)reDealButton:(id)sender {
    [self.game reSet];
    [self updateUI];
    _matchResultLabel.text = @"";
    self.modeSegmentedControl.enabled = YES;
}

- (void)updateUI{
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}
@end
