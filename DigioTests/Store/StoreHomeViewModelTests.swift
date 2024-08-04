//
//  StoreHomeViewModelTests.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 04/08/2024.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Digio

class StoreHomeViewModelTests: XCTestCase {

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var viewModel: StoreHomeViewModel!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var mockService: MockStoreService!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var mockCoordinator: MockStoreCoordinator!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        mockService = MockStoreService()
        mockCoordinator = MockStoreCoordinator()
        viewModel = StoreHomeViewModel(coordinator: mockCoordinator, service: mockService)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockCoordinator = nil
        disposeBag = nil
        super.tearDown()
    }

    func testFetchProductsSuccess() {
        // Given
        guard let expectedProducts = TestHelper.loadJSONFromFile(
            type: ProductsModel.self,
            filename: "products-success"
        ) else {
            XCTFail("Failed to load expected products")
            return
        }
        mockService.fetchProductsResult = .just(expectedProducts)
        
        let expectation = self.expectation(description: "Products fetched")
        
        viewModel.products
            .skip(1) // Jump initial value
            .subscribe(onNext: { [weak self] products in
                guard let self else { return }
                
                // Then
                XCTAssertNotNil(products)
                XCTAssertEqual(products?.cash.title, expectedProducts.cash.title)
                XCTAssertEqual(products?.cash.bannerURL, expectedProducts.cash.bannerURL)
                XCTAssertEqual(products?.cash.description, expectedProducts.cash.description)
                XCTAssertEqual(products?.spotlight.count, expectedProducts.spotlight.count)
                XCTAssertEqual(products?.products.count, expectedProducts.products.count)
                XCTAssertFalse(self.viewModel.isLoading.value)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        // When
        viewModel.fetchProducts()
        
        // Wait
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetchProductsFailure() {
        // Given
        let expectedError = APIError.unknown
        mockService.fetchProductsResult = .error(expectedError)
        
        let expectation = self.expectation(description: "Error handled")
        
        XCTAssertFalse(viewModel.isLoading.value)

        viewModel.isLoading
            .skip(1) // Jump initial value
            .subscribe(onNext: { [weak self] isLoading in
                guard let self else { return }
                
                if !isLoading {
                    XCTAssertTrue(self.mockCoordinator.didCallShowError)
                    expectation.fulfill()
                }
            })
            .disposed(by: disposeBag)
        
        // When
        viewModel.fetchProducts()
        
        // Wait
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testShowSpotlightDetails() {
        // Given
        guard let products = TestHelper.loadJSONFromFile(
            type: ProductsModel.self,
            filename: "products-success"
        ) else {
            XCTFail("Failed to load expected products")
            return
        }
        viewModel.products.accept(products)
        
        // When
        viewModel.showSpotlightDetails(at: 0)
        
        // Then
        XCTAssertTrue(mockCoordinator.didCallStartDetails)
        XCTAssertEqual(mockCoordinator.product?.name, products.spotlight[0].name)
        XCTAssertEqual(mockCoordinator.product?.imageURL, products.spotlight[0].bannerURL)
        XCTAssertEqual(mockCoordinator.product?.description, products.spotlight[0].description)
    }
    
    func testShowCashDetails() {
        // Given
        guard let products = TestHelper.loadJSONFromFile(
            type: ProductsModel.self,
            filename: "products-success"
        ) else {
            XCTFail("Failed to load expected products")
            return
        }
        viewModel.products.accept(products)
        
        // When
        viewModel.showCashDetails()
        
        // Then
        XCTAssertTrue(mockCoordinator.didCallStartDetails)
        XCTAssertEqual(mockCoordinator.product?.name, products.cash.title)
        XCTAssertEqual(mockCoordinator.product?.imageURL, products.cash.bannerURL)
        XCTAssertEqual(mockCoordinator.product?.description, products.cash.description)
    }
    
    func testShowProductDetails() {
        // Given
        guard let products = TestHelper.loadJSONFromFile(
            type: ProductsModel.self,
            filename: "products-success"
        ) else {
            XCTFail("Failed to load expected products")
            return
        }
        viewModel.products.accept(products)
        
        // When
        viewModel.showProductDetails(at: 0)
        
        // Then
        XCTAssertTrue(mockCoordinator.didCallStartDetails)
        XCTAssertEqual(mockCoordinator.product?.name, products.products[0].name)
        XCTAssertEqual(mockCoordinator.product?.imageURL, products.products[0].imageURL)
        XCTAssertEqual(mockCoordinator.product?.description, products.products[0].description)
    }
}
