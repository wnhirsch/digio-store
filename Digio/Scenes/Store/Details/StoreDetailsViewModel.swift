//
//  StoreDetailsViewModel.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 04/08/2024.
//

class StoreDetailsViewModel {
    
    var product: ProductModel
    private weak var coordinator: StoreCoordinator?
    
    init(model: ProductModel, coordinator: StoreCoordinator) {
        self.product = model
        self.coordinator = coordinator
    }
    
    func dismiss() {
        coordinator?.dismiss()
    }
}
