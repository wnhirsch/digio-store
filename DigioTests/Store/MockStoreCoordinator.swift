//
//  MockStoreCoordinator.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 04/08/2024.
//

import Foundation
import UIKit
@testable import Digio

class MockStoreCoordinator: StoreCoordinator {
    
    private(set) var didCallShowError = false
    private(set) var didCallStartDetails = false
    private(set) var didCallDismiss = false
    private(set) var error: APIError?
    private(set) var product: ProductModel?
    
    init() {
        super.init(navigationController: .init())
    }
    
    override func startDetails(with model: ProductModel) {
        didCallStartDetails = true
        self.product = model
    }
    
    override func showError(
        error: APIError,
        tryAgain: ((UIAlertAction) -> Void)? = nil,
        cancel: ((UIAlertAction) -> Void)? = nil
    ) {
        didCallShowError = true
        self.error = error
    }
    
    override func dismiss() {
        didCallDismiss = true
    }
}
