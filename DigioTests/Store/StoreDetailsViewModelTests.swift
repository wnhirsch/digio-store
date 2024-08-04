//
//  StoreDetailsViewModelTests.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 04/08/2024.
//

import XCTest
@testable import Digio

class StoreDetailsViewModelTests: XCTestCase {
    
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var viewModel: StoreDetailsViewModel!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var mockCoordinator: MockStoreCoordinator!
    
    override func setUp() {
        super.setUp()
        mockCoordinator = MockStoreCoordinator()
        let product = ProductModel(
            name: "Test Product",
            imageURL: "test-url",
            description: "Test description"
        )
        viewModel = StoreDetailsViewModel(model: product, coordinator: mockCoordinator)
    }
    
    override func tearDown() {
        viewModel = nil
        mockCoordinator = nil
        super.tearDown()
    }
    
    func testDismiss() {
        // When
        viewModel.dismiss()
        
        // Then
        XCTAssertTrue(mockCoordinator.didCallDismiss)
    }
    
    func testProductInitialization() {
        // Given
        let expectedName = "Test Product"
        let expectedImageURL = "test-url"
        let expectedDescription = "Test description"
        
        // Then
        XCTAssertEqual(viewModel.product.name, expectedName)
        XCTAssertEqual(viewModel.product.imageURL, expectedImageURL)
        XCTAssertEqual(viewModel.product.description, expectedDescription)
    }
}
