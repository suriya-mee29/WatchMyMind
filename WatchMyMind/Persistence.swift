//
//  Persistence.swift
//  WatchMyMind
//
//  Created by Suriya on 3/2/2564 BE.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
  
    
    let container : NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "WatchMyMind")
        container.loadPersistentStores { (StroeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
                
            }
        }
        
    }
    // MARK: - FUNCTION
    func updateMindfulness(){
        do {
            try container.viewContext.save()
        }catch{
            container.viewContext.rollback()
            fatalError("Failed to update Mindnessful \(error)")
        }
    }
    
    func deleteMindfulness (mindfulness: Mindfulness){
        
        container.viewContext.delete(mindfulness)
        do {
            try container.viewContext.save()
        }catch{
            container.viewContext.rollback()
            fatalError("Failed to save Mindnessful \(error)")
        }
    }
    
    func getAllData() -> [Mindfulness] {
        let fetchRequest : NSFetchRequest<Mindfulness> = Mindfulness.fetchRequest()
        do{
           return try container.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    
    func createNewData( mindfulness : MindfulnessModel ){
        let mindfulnessContext = Mindfulness(context: container.viewContext)
        mindfulnessContext.id  = mindfulness.id
        mindfulnessContext.date = mindfulness.date
        mindfulnessContext.time = mindfulness.time
        
        do{
            try container.viewContext.save()
        }catch{
            fatalError("Failed to save Mindnessful Data\(error)")
        }
    }
    
   
 
       

    
}
