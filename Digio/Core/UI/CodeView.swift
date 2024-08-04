//
//  CodeView.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/2024.
//

public protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

public extension CodeView {

    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
