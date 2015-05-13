//
//  BPDStudioStore.m
//  BPDMaps
//
//  Created by Wesllei on 13/05/15.
//  Copyright (c) 2015 Wesllei. All rights reserved.
//

#import "BPDStudioStore.h"
#import "BPDStudios.h"
#import "AppDelegate.h"

@interface BPDStudioStore ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation BPDStudioStore

static NSString *DATA_MODEL_ENTITY_NAME = @"BPDStudio";

+ (instancetype)sharedStore {
    static BPDStudioStore *sharedStore = nil;
    
    if (!sharedStore) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        sharedStore = [[self alloc] initPrivate];
        sharedStore.managedObjectContext = appDelegate.managedObjectContext;
        
        //[sharedStore resetStoredData];// popula com os dados do resetStoredData
    }
    
    return sharedStore;
}

- (instancetype)initPrivate {
    self = [super init];
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BPDStudioStore sharedStore]"
                                 userInfo:nil];
}

- (void)resetStoredData{
    
    // Delete all objects
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:DATA_MODEL_ENTITY_NAME];
    NSError *error;
    NSArray *objects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Error fetching objects: %@", error.userInfo);
    }
    
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    for (NSManagedObject *object in objects) {
        [self.managedObjectContext deleteObject:object];
    }
    
    // Populate with defaults
    NSArray *stNome= @[@"Studio 5", @"Studio 6", @"Studio 7"];
    NSArray *stLatitude = @[@-3.1273201723523214, @-3.1276516013554967, @-3.1296977546589306];
    NSArray *stLongitude = @[@-60.02646142709199, @ -60.02880500721875, @-60.028676261186035];
    NSArray *stHora = @[@"8:00 as 17:00", @"8:00 as 17:00", @"8:00 as 17:00"];
    NSArray *stValorHora = @[@60.00, @50.00, @70.00];
    NSArray *stDia = @[@"seg a sex", @"seg a sex", @"seg a sex"];
    
    for (int i = 0; i < [stNome count]; ++i) {
        NSString *name=[stNome objectAtIndex:i];
        NSNumber *latitude=[stLatitude objectAtIndex:i];
        NSNumber *longitude=[stLongitude objectAtIndex:i];
        NSString *hora=[stHora objectAtIndex:i];
        NSNumber *valorHora=[stValorHora objectAtIndex:i];
        NSString *dia=[stDia objectAtIndex:i];
        
        [self createStudioWithNome:[stNome objectAtIndex:i] andLatitude:[stLatitude objectAtIndex:i] andLongitude:[stLongitude objectAtIndex:i] andValorHora:[stValorHora objectAtIndex:i] andHora:[stHora objectAtIndex:i] andDia:[stDia objectAtIndex:i]];
    }
}

- (BPDStudios *)createStudioWithNome:(NSString *)nome andLatitude:(NSNumber *)latitude andLongitude:(NSNumber *)longitude andValorHora:(NSNumber *)valorHora andHora:(NSString *)horaDisponivel andDia:(NSString *)diaFuncionamento{
    BPDStudios *studio = [NSEntityDescription
                         insertNewObjectForEntityForName:DATA_MODEL_ENTITY_NAME
                         inManagedObjectContext:self.managedObjectContext];
    
    studio.id = [[[NSUUID alloc] init] UUIDString];
    studio.nome= nome;
    studio.latitude=latitude;
    studio.longitude=longitude;
    studio.valorHora=valorHora;
    studio.horaDisponivel=horaDisponivel;
    studio.diaFuncionamento=diaFuncionamento;
    
    NSError *error;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Could not save %@, %@", error, error.userInfo);
    }
    
    return studio;
}

- (void)removeStudio:(BPDStudios *)studio{
    [self.managedObjectContext deleteObject:studio];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:DATA_MODEL_ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
        
        [fetchRequest setEntity:entity];
        
        // Set the batch size to a suitable number.
        [fetchRequest setFetchBatchSize:20];
        
        // Edit the sort key as appropriate. //ordenar a tabela
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"code" ascending:YES];
        NSArray *sortDescriptors = @[sortDescriptor];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        // _fetchedResultsController.delegate = self;
        
        NSError *error = nil;
        if (![_fetchedResultsController performFetch:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    return _fetchedResultsController;
}

- (BOOL)saveChanges {
    NSError *error;
    
    if ([self.managedObjectContext hasChanges]) {
        BOOL successful = [self.managedObjectContext save:&error];
        
        if (!successful) {
            NSLog(@"Error saving: %@", [error localizedDescription]);
        }
        
        return successful;
    }
    
    return YES;
}


@end
