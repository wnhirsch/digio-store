//
//  Loadable.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/2024.
//

import SnapKit
import UIKit

protocol Loadable {
    func showLoading(message: String?, on subview: UIView?)
    func hideLoading()
}

extension Loadable where Self: UIViewController {
    
    func showLoading(message: String? = nil, on subview: UIView? = nil) {
        view.endEditing(true)
        
        if let loadingView = findLoadingView() {
            loadingView.setup(message: message)
            view.bringSubviewToFront(loadingView)
            return
        }

        let loadingView = addLoadingView(subview: subview)
        loadingView.setup(message: message)
        loadingView.alpha = 1
    }

    func hideLoading() {
        guard let loadingView = findLoadingView() else {
            return
        }

        UIView.animate(withDuration: Double(.alpha25), animations: {
            loadingView.alpha = .zero
        }, completion: { _ in
            loadingView.stopAnimating()
            loadingView.removeFromSuperview()
        })
    }

    private func findLoadingView() -> LoadingView? {
        return view.subviews.compactMap { $0 as? LoadingView }.first
    }

    private func addLoadingView(subview: UIView? = nil) -> LoadingView {
        let loadingView = LoadingView()
        loadingView.startAnimating()
        
        if let superview = subview ?? view {
            superview.addSubview(loadingView)
            loadingView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }

        return loadingView
    }
}
