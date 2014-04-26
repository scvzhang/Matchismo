//
//  PlayingCard.h
//  Matchismo
//
//  Created by 张 俊 on 14-2-11.
//  Copyright (c) 2014年 zhangjun. All rights reserved.
//
//

#import "Card.h"

@interface PlayingCard : Card

//花色
@property (strong, nonatomic) NSString *suit;
//大小点数
@property (nonatomic) NSUInteger rank;

//return 有效的所有花色
+ (NSArray *)validSuits;
//return 最大的点数
+ (NSUInteger)maxRank;

@end
