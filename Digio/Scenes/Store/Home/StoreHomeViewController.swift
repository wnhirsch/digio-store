//
//  StoreHomeViewController.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/2024.
//

import RxSwift
import RxCocoa
import SnapKit
import UIKit

class StoreHomeViewController: UIViewController, Loadable {

    private let contentView: StoreHomeView
    private let viewModel: StoreHomeViewModel
    
    private let disposeBag = DisposeBag()

    init(viewModel: StoreHomeViewModel) {
        contentView = StoreHomeView()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        bind()
        viewModel.fetchProducts()
    }
    
    private func setupNavigationBar() {
        let leftBarButtonItem = UIBarButtonItem(customView: contentView.profileWelcomeView)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func bind() {
        contentView.spotlightCollectionView.dataSource = self
        contentView.spotlightCollectionView.delegate = self
        contentView.productsCollectionView.dataSource = self
        contentView.productsCollectionView.delegate = self
        
        viewModel.isLoading
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] isLoading in
                guard let self else { return }
                isLoading ? self.showLoading() : self.hideLoading()
            })
            .disposed(by: disposeBag)
        
        viewModel.products
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] products in
                guard let self else { return }
                self.contentView.setup(
                    with: products,
                    cashTapGesture: .init(target: self, action: #selector(didTapCashSection))
                )
            })
            .disposed(by: disposeBag)
    }
    
    @objc func didTapCashSection() {
        viewModel.showCashDetails()
    }
}

// MARK: - UICollectionViewDataSource
extension StoreHomeViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let model = viewModel.products.value else {
            collectionView.isHidden = true
            return .zero
        }
        
        switch collectionView {
        case contentView.spotlightCollectionView:
            collectionView.isHidden = model.spotlight.isEmpty
            return model.spotlight.count
        case contentView.productsCollectionView:
            collectionView.isHidden = model.products.isEmpty
            return model.products.count
        default:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let model = viewModel.products.value else { return .init() }
        
        switch collectionView {
        case contentView.spotlightCollectionView:
            let cell = collectionView.dequeueReusableCell(StoreSpotlightCell.self, for: indexPath)
            cell.setup(with: model.spotlight[indexPath.row].bannerURL)
            return cell
        case contentView.productsCollectionView:
            let cell = collectionView.dequeueReusableCell(StoreProductsCell.self, for: indexPath)
            cell.setup(with: model.products[indexPath.row].imageURL)
            return cell
        default:
            return .init()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension StoreHomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case contentView.spotlightCollectionView:
            viewModel.showSpotlightDetails(at: indexPath.row)
        case contentView.productsCollectionView:
            viewModel.showProductDetails(at: indexPath.row)
        default: break
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension StoreHomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .init(top: .size4, left: .size24, bottom: .zero, right: .size24)
    }
}
