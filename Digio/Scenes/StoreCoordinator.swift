//
//  StoreCoordinator.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/2024.
//

import UIKit

class StoreCoordinator: Coordinator {

    internal var childCoordinators = [Coordinator]()
    internal var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = StoreHomeViewController(viewModel: .init(coordinator: self))
        navigationController.pushViewController(vc, animated: true)
    }
    
    func startDetails(with model: ProductModel) {
        let vc = StoreDetailsViewController(viewModel: .init(model: model, coordinator: self))
        let nav = UINavigationController(rootViewController: vc)
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .overFullScreen
        navigationController.present(nav, animated: true)
    }
    
    func showError(
        error: APIError,
        tryAgain: ((UIAlertAction) -> Void)? = nil,
        cancel: ((UIAlertAction) -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: "error.title".localized,
            message: error.localized,
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(
            title: "error.cancel".localized,
            style: .cancel,
            handler: cancel
        )
        alert.addAction(cancelAction)
        
        let tryAgainAction = UIAlertAction(
            title: "error.tryAgain".localized,
            style: .default,
            handler: tryAgain
        )
        alert.addAction(tryAgainAction)
        
        navigationController.visibleViewController?.present(alert, animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
