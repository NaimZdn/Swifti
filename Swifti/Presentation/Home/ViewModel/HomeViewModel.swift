//
//  HomeViewModel.swift
//  Swifti
//
//  Created by Zidouni on 23/07/2023.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    private var dataController: DataController
    private var context: NSManagedObjectContext
    
    @Published var userName = ""
    
    init() {
           dataController = DataController.shared
           context = dataController.container.viewContext
           transformData()
       }
    
    private func transformData() {
        userName = dataController.getUserName() ?? ""
        print(userName)
        
    }
}
