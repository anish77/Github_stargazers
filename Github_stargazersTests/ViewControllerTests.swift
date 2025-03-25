//
//  ViewControllerTests.swift
//  Github_stargazersUITests
//
//  Created by Ana Cvasniuc on 24/03/25.
//
import UIKit
import XCTest
@testable import Github_stargazers

final class ViewControllerTests: XCTestCase {
    
    var vc: ViewController!
    var mockNavController: MockNavigationController!
    
    override func setUpWithError() throws {
        super.setUp()
        
        // Carica la storyboard e l'istanza della ViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = (storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController)
        vc.loadViewIfNeeded()
        mockNavController = MockNavigationController(rootViewController: vc)
        
       
    }
    
    override func tearDownWithError() throws {
        vc = nil
        mockNavController = nil
        super.tearDown()
    }
    
    func testGradientBackground() {
         vc.gradientBackground()
         
         let sublayers = vc.view.layer.sublayers
         let gradientLayer = sublayers?.first { $0 is CAGradientLayer } as? CAGradientLayer
         
         XCTAssertNotNil(gradientLayer, "Gradient layer should be added to the view's layer.")
         XCTAssertEqual(gradientLayer?.colors?.count, 2, "Gradient should have two colors.")
     }
    
    func testSearchOwner() {
        // Imposta i valori per i text field
        vc.ownerTextField.text = "mindverse"
        vc.repositoryTextField.text = "Second-Me"
        vc.searchOwner(UIButton())
        
        // Verifica che la vista UsersTableView sia pushata
        XCTAssertTrue(mockNavController.pushedViewController is UsersTableView, "UsersTableView should be pushed when valid input is provided.")
    }
    
    class MockNavigationController: UINavigationController {
        var pushedViewController: UIViewController?
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewController = viewController
            super.pushViewController(viewController, animated: animated)
        }
    }
}
