//
//  StoreSpotlightCell.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 04/08/2024.
//

import Kingfisher
import SnapKit
import UIKit

class StoreSpotlightCell: UICollectionViewCell, CodeView {
    
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.cornerRadius = CGFloat.size12
        imageView.layer.masksToBounds = true
        
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        contentView.addSubview(bannerImageView)
    }
    
    func setupConstraints() {
        bannerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
        
        layer.shadowColor = UIColor.digioBlack.cgColor
        layer.shadowOpacity = .init(.alpha25)
        layer.shadowOffset = CGSize(width: .size2, height: .size2)
        layer.shadowRadius = .size4
        layer.masksToBounds = false
    }
    
    func setup(with link: String) {
        guard let url = URL(string: link) else { return }
        bannerImageView.kf.setImage(with: url)
    }
}
