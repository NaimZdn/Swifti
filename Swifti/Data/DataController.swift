//
//  DataController.swift
//  Swifti
//
//  Created by Zidouni on 23/07/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    var userEntity: UserEntity?
    var userName = ""
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    static let shared = DataController()
    
    private init() {
        container = NSPersistentContainer(name: "SwiftiDataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
        context = container.viewContext
        userName = getUserName() ?? ""
    }
    
    func getUserName() -> String? {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            if let userEntity = try context.fetch(fetchRequest).first {
                return userEntity.name
            }
        } catch {
            print("Erreur lors de la récupération du nom d'utilisateur : \(error)")
        }
        return nil
    }
    
    func addUserNameToData(name: String) {
        let context = container.viewContext
        
        let userEntity = UserEntity(context: context)
        userEntity.name = name
        
        do {
            try context.save()
        } catch {
            print("Erreur lors de l'enregistrement du nom de l'utilisateur : \(error.localizedDescription)")
        }
    }
}
