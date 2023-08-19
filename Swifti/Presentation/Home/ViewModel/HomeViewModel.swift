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
        
    }
    
    func getCurrentDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE d MMMM")
        
        var dateString = dateFormatter.string(from: currentDate)
        
        if let firstLetter = dateString.first {
            dateString = dateString.replacingCharacters(in: dateString.startIndex...dateString.startIndex, with: String(firstLetter).capitalized)
        }
        
        return dateString
    }
}
