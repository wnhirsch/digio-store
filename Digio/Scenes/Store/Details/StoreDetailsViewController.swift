//
//  StoreDetailsViewController.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 04/08/2024.
//

import RxSwift
import RxCocoa
import SnapKit
import UIKit

class StoreDetailsViewController: UIViewController {

    private let contentView: StoreDetailsView
    private let viewModel: StoreDetailsViewModel
    
    private let disposeBag = DisposeBag()

    init(viewModel: StoreDetailsViewModel) {
        contentView = StoreDetailsView()
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
        contentView.setup(with: viewModel.product)
    }
    
    private func setupNavigationBar() {
        let closeButton = UIImageView(image: .digioClose)
        closeButton.tintColor = .digioSecondary
        
        closeButton.isUserInteractionEnabled = true
        closeButton.addGestureRecognizer(UITapGestureRecognizer(
            target: self, action: #selector(didTapCloseButton))
        )
        
        closeButton.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.size16)
            make.width.equalTo(CGFloat.size16)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }
    
    @objc func didTapCloseButton() {
        viewModel.dismiss()
    }
}
