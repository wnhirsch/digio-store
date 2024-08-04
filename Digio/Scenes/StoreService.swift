//
//  StoreService.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/2024.
//

import Foundation
import RxSwift
import RxCocoa

class StoreService {
    
    func fetchProducts() -> Observable<ProductsModel> {
        guard let request = APIRequest.products else {
            return Observable.error(APIError.networkError)
        }
        
        return URLSession.shared.rx.data(request: request)
            .map { data -> ProductsModel in
                do {
                    let decoder = JSONDecoder()
                    return try decoder.decode(ProductsModel.self, from: data)
                } catch {
                    throw APIError.decodingError
                }
            }
            .asObservable()
            .catch { error in
                if error as? APIError == APIError.decodingError {
                    return Observable.error(error)
                } else {
                    return Observable.error(APIError.networkError)
                }
            }
    }
}
