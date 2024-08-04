//
//  StoreCashSectionView.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/2024.
//

import Kingfisher
import SnapKit
import UIKit

class StoreCashSectionView: UIView, CodeView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .digioPrimary
        label.textAlignment = .left
        label.font = .systemFont(ofSize: .size20, weight: .bold)
        return label
    }()
    
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = CGFloat.size12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var bannerImageSize: CGSize {
        CGSize.cashImage.insideWidth(UIScreen.main.bounds.width - .size24 * 2)
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(bannerImageView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size24)
        }
        
        bannerImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.size12)
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size24)
            make.bottom.equalToSuperview()
            
            make.height.equalTo(bannerImageSize.height)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .digioWhite
    }
    
    func setup(with model: CashModel) {
        titleLabel.text = model.title
        if let url = URL(string: model.bannerURL) {
            bannerImageView.kf.setImage(with: url)
        }
    }
}
