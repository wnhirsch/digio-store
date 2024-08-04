//
//  StoreDetailsView.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 04/08/2024.
//

import Foundation
import Kingfisher
import SnapKit
import UIKit

class StoreDetailsView: UIView, CodeView {
    
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
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .digioWhite
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = CGFloat.size12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .digioWhite
        label.textAlignment = .center
        label.font = .systemFont(ofSize: .size20, weight: .bold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .digioWhite
        label.font = .systemFont(ofSize: .size16)
        label.numberOfLines = 0
        return label
    }()
    
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
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size24)
            make.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .digioBlack.withAlphaComponent(.alpha80)
    }
    
    func setup(with model: ProductModel) {
        titleLabel.text = model.name
        descriptionLabel.text = model.description
        if let url = URL(string: model.imageURL) {
            KF.url(url)
              .cacheMemoryOnly()
              .fade(duration: CGFloat.alpha25)
              .onSuccess { [weak self] result in
                  guard let self else { return }
                  
                  let viewWidth = UIScreen.main.bounds.width - .size24 * 2
                  let width = min(viewWidth, result.image.size.width)
                  let height = floor(width * result.image.size.height / result.image.size.width)
                  
                  self.imageView.snp.remakeConstraints { make in
                      make.height.equalTo(height)
                  }
              }
              .set(to: imageView)
        }
    }
}
