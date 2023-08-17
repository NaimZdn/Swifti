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
    var questionsData: [CourseEntity] = []
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
    
    func addScoreToData(courseTitle: String, score: Int) {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<CourseEntity> = CourseEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", courseTitle)
        
        do {
            if let existingCourseEntity = try context.fetch(fetchRequest).first {
                existingCourseEntity.score = Int16(score)
            } else {
                let newCourseEntity = CourseEntity(context: context)
                newCourseEntity.title = courseTitle
                newCourseEntity.score = Int16(score)
                questionsData.append(newCourseEntity)
            }
            
            try context.save()
        } catch {
            print("Erreur lors de l'ajout du score : \(error.localizedDescription)")
        }
    }
    
    func getCourseData() -> [String: Int]? {
        let fetchRequest: NSFetchRequest<CourseEntity> = CourseEntity.fetchRequest()
        do {
            let courseEntities = try context.fetch(fetchRequest)
            var scoreDictionary: [String: Int] = [:]
            
            for courseEntity in courseEntities {
                scoreDictionary[courseEntity.title ?? ""] = Int(courseEntity.score)
            }
            //print(scoreDictionary)
            return scoreDictionary
        } catch {
            print("Erreur lors de la récupération des données de cours : \(error)")
        }
        return nil
    }
}
