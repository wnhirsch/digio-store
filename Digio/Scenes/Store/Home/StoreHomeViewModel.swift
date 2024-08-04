//
//  StoreHomeViewModel.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/2024.
//

import Foundation
import RxSwift
import RxCocoa

class StoreHomeViewModel {
    
    private weak var coordinator: StoreCoordinator?
    private let service: StoreService
    
    let products: BehaviorRelay<ProductsModel?> = BehaviorRelay(value: nil)
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    private let disposeBag = DisposeBag()
    
    init(coordinator: StoreCoordinator, service: StoreService = .init()) {
        self.coordinator = coordinator
        self.service = service
    }
    
    func fetchProducts() {
        guard !isLoading.value else { return }
        
        isLoading.accept(true)
        
        service.fetchProducts()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] products in
                    guard let self else { return }
                    self.isLoading.accept(false)
                    self.products.accept(products)
                },
                onError: { [weak self] error in
                    guard let self else { return }
                    self.coordinator?.showError(error: .init(error)) { [weak self] _ in
                        guard let self else { return }
                        // If user press try again, rerun the request
                        self.fetchProducts()
                    } cancel: { _ in
                        // If user press cancel, do nothing
                    }
                    self.isLoading.accept(false)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func showSpotlightDetails(at index: Int) {
        guard let model = products.value else { return }
        coordinator?.startDetails(with: .init(
            name: model.spotlight[index].name,
            imageURL: model.spotlight[index].bannerURL,
            description: model.spotlight[index].description
        ))
    }
    
    func showCashDetails() {
        guard let model = products.value else { return }
        coordinator?.startDetails(with: .init(
            name: model.cash.title,
            imageURL: model.cash.bannerURL,
            description: model.cash.description
        ))
    }
    
    func showProductDetails(at index: Int) {
        guard let model = products.value else { return }
        coordinator?.startDetails(with: model.products[index])
    }
}
