//
//  BPDStudioStore.h
//  BPDMaps
//
//  Created by Wesllei on 13/05/15.
//  Copyright (c) 2015 Wesllei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPDStudios.h"
@import CoreData;
@interface BPDStudioStore : NSObject

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

+ (instancetype)sharedStore;

- (BPDStudios *)createStudioWithNome:(NSString *)nome andLatitude:(NSNumber *)latitude andLongitude:(NSNumber *)longitude andValorHora:(NSNumber *)valorHora andHora:(NSString *)horaDisponivel andDia:(NSString *)diaFuncionamento;

- (void)removeStudio:(BPDStudios *)studio;
- (BOOL)saveChanges;
@end
