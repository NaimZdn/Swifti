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
        return dateFormatter.string(from: currentDate).replacingOccurrences(of: dateFormatter.weekdaySymbols[0], with: dateFormatter.weekdaySymbols[0].capitalized)
        
    }
}
