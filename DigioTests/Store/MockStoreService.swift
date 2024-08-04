//
//  MockStoreService.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 04/08/2024.
//

import Foundation
import RxSwift
import RxCocoa
@testable import Digio

class MockStoreService: StoreService {
    
    var fetchProductsResult: Observable<ProductsModel> = .empty()
    
    override func fetchProducts() -> Observable<ProductsModel> {
        return fetchProductsResult
    }
}
