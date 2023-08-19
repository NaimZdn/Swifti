//
//  WelcomeTests.swift
//  SwiftiTests
//
//  Created by Zidouni on 18/08/2023.
//

import XCTest
import CoreData
@testable import Swifti

final class WelcomeTests: XCTestCase {

    var welcome: WelcomeViewModel!
    
    override func setUp() {
        welcome = WelcomeViewModel()
    }
    
    func testGivenContainsOnlySpaces_WhenInputContainsOnlySpaces_ThenReturnTrue() {
           let input = "    "
        
           let result = welcome.containsOnlySpaces(input)

           XCTAssertTrue(result)
       }
       
       func testGivenContainsOnlySpaces_WhenInputContainsNonSpaceCharacters_ThenReturnFalse() {
           let input = "  Hello World  "
   
           let result = welcome.containsOnlySpaces(input)
           
           XCTAssertFalse(result)
       }
       
       func testGivenContainsOnlySpaces_WhenInputIsEmpty_ThenReturnTrue() {
           let input = ""
           
           let result = welcome.containsOnlySpaces(input)

           XCTAssertTrue(result)
       }
    
    func testGivenAddUserAndRedirectToHome_WhenNameProvided_ThenUserIsAddedAndIsUserRegisteredIsTrue() {
        let name = "John Doe"
        
        welcome.addUserAndRedirectToHome(name: name)
 
        XCTAssertTrue(welcome.isUserRegistered)
    }

}
