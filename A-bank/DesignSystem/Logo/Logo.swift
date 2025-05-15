//
//  Logo.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 04.05.2025.
//

import UIKit

public final class Logo: UIView {
    private var viewModel: LogoViewModel!

    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) not supported") }

    public func configure(with vm: LogoViewModel) {
        self.viewModel = vm

        NSLayoutConstraint.deactivate(constraints)
        widthAnchor.constraint(equalToConstant: vm.size.width).isActive = true
        heightAnchor.constraint(equalToConstant: vm.size.height).isActive = true

        backgroundColor = .clear
        setNeedsDisplay()
    }

    public override func draw(_ rect: CGRect) {
        guard let vm = viewModel else { return }

        let path = UIBezierPath()
        path.lineWidth = vm.lineWidth

        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        let crossY = rect.midY * 0.9
        path.move(to: CGPoint(x: rect.width * 0.25, y: crossY))
        path.addLine(to: CGPoint(x: rect.width * 0.75, y: crossY))

        let uiColor: UIColor
        switch vm.color {
        case .light:   uiColor = .white
        case .primary: uiColor = .red
        case .dark:    uiColor = .black
        }
        uiColor.setStroke()
        path.stroke()
    }
}
