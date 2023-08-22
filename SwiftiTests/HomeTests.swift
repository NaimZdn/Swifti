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
        let expectedDate = "Mercredi 23 août" // Replace by the current date

        let result = home.getCurrentDate()
        
        XCTAssertEqual(result, expectedDate)
    }
}
