//
//  StoreHomeView.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/2024.
//

import SnapKit
import UIKit

class StoreHomeView: UIView, CodeView {
    
    lazy var profileWelcomeView: UIView = {
        let imageView = UIImageView(image: .digioIcon)
        imageView.contentMode = .scaleAspectFit

        let label = UILabel()
        label.text = "store.welcome".localized("Maria") // Hardcoded example
        label.font = .systemFont(ofSize: .size16, weight: .bold)
        label.textColor = .digioPrimary

        let view = UIView()
        view.addSubview(imageView)
        view.addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(CGFloat.size24)
            make.width.equalTo(CGFloat.size24)
        }
        
        label.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(CGFloat.size12)
            make.trailing.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(
            top: .size24,
            left: .zero,
            bottom: .size24,
            right: .zero
        )
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .size32
        return stackView
    }()

    lazy var spotlightCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .size16
        layout.itemSize = spotlightItemSize

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(StoreSpotlightCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .digioWhite
        collectionView.clipsToBounds = false
        
        return collectionView
    }()
    
    private lazy var cashSection = StoreCashSectionView()
    
    private lazy var productsHeader = StoreProductsHeader()
    
    let productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .size16
        layout.itemSize = .productImage

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(StoreProductsCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .digioWhite
        collectionView.clipsToBounds = false
        
        return collectionView
    }()
    
    private var spotlightItemSize: CGSize {
        CGSize.spotlightImage.insideWidth(UIScreen.main.bounds.width - .size24 * 2)
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(spotlightCollectionView)
        stackView.addArrangedSubview(cashSection)
        stackView.addArrangedSubview(productsHeader)
        stackView.addArrangedSubview(productsCollectionView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        spotlightCollectionView.snp.makeConstraints { make in
            make.height.equalTo(spotlightItemSize.height + CGFloat.size4)
        }
        
        stackView.setCustomSpacing(.size12, after: productsHeader)
        
        productsCollectionView.snp.makeConstraints { make in
            make.height.equalTo(CGSize.productImage.height + CGFloat.size4)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .digioWhite
    }
    
    func setup(with model: ProductsModel, cashTapGesture: UITapGestureRecognizer) {
        cashSection.setup(with: model.cash)
        spotlightCollectionView.reloadData()
        productsCollectionView.reloadData()
        
        cashSection.isUserInteractionEnabled = true
        cashSection.addGestureRecognizer(cashTapGesture)
    }
}
