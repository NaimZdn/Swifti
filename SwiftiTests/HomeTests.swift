//
//  HomeTests.swift
//  SwiftiTests
//
//  Created by Zidouni on 18/08/2023.
//

import XCTest
import CoreData
@testable import Swifti

final class HomeTests: XCTestCase {
    var home: HomeViewModel!
    var dataController: DataController!
    var context: NSManagedObjectContext!
    
    override func setUp() {
        home = HomeViewModel()
        dataController = DataController.shared
        context = dataController.container.viewContext
    }
    
    func testGivenGetCurrentDate_WhenUsingSpecificDate_ThenReturnFormattedDate() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE d MMMM")
        
        var dateString = dateFormatter.string(from: currentDate)
        
        if let firstLetter = dateString.first {
            dateString = dateString.replacingCharacters(in: dateString.startIndex...dateString.startIndex, with: String(firstLetter).capitalized)
        }

        let result = home.getCurrentDate()
        
        XCTAssertEqual(result, dateString)
    }
}
