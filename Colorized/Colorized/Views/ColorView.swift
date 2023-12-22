//
//  ColorView.swift
//  Colorized
//
//  Created by Nikolai Maksimov on 22.12.2023.
//

import UIKit


final class ColorView: UIView {
    
    typealias Axis = NSLayoutConstraint.Axis
    
    private lazy var colorView = makeView()
    
    private lazy var redLabel = makeLabelView(withTitle: "Red")
    private lazy var greenLabel = makeLabelView(withTitle: "Green")
    private lazy var blueLabel = makeLabelView(withTitle: "Blue")
    
    private lazy var redSliderValue = makeLabelView(withTitle: "0.33")
    private lazy var greenSliderValue = makeLabelView(withTitle: "0.33")
    private lazy var blueSliderValue = makeLabelView(withTitle: "0.33")
    
    private lazy var redSlider = makeSliderView()
    private lazy var greenSlider = makeSliderView()
    private lazy var blueSlider = makeSliderView()
    
    private lazy var redTextField = makeTextFieldView()
    private lazy var greenTextField = makeTextFieldView()
    private lazy var blueTextField = makeTextFieldView()
    
    private lazy var titleStackView = makeStackView(axis: .vertical)
    private lazy var valueStackView = makeStackView(axis: .vertical)
    private lazy var sliderStackView = makeStackView(axis: .vertical)
    private lazy var textFieldStackView = makeStackView(axis: .vertical)
    
    private lazy var mainStackView = makeStackView(axis: .horizontal)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Methods
extension ColorView {
    
    private func commonInit() {
        setupConstraintsToColorView()
        setupConstraintsToVerticalStack()
        configureMainStackView()
        configureTitleStackView()
        configureValueStackView()
        configureSliderStackView()
        configureTextFieldStackView()
    }
}

// MARK: Constraints
extension ColorView {
    
    private func setupConstraintsToColorView() {
        addSubview(colorView)
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            colorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            colorView.heightAnchor.constraint(equalToConstant: 128),
        ])
        
    }
    
    private func setupConstraintsToVerticalStack() {
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 40),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}

// MARK: Configure's
extension ColorView {
    
    private func configureMainStackView() {
        mainStackView.spacing = 8
        mainStackView.alignment = .center
        mainStackView.addArrangedSubview(titleStackView)
        mainStackView.addArrangedSubview(valueStackView)
        mainStackView.addArrangedSubview(sliderStackView)
        mainStackView.addArrangedSubview(textFieldStackView)
    }
    
    private func configureTitleStackView() {
        titleStackView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        titleStackView.spacing = 25
        titleStackView.alignment = .fill
        titleStackView.distribution = .fill
        titleStackView.addArrangedSubview(redLabel)
        titleStackView.addArrangedSubview(greenLabel)
        titleStackView.addArrangedSubview(blueLabel)
    }
    
    private func configureValueStackView() {
        valueStackView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        valueStackView.spacing = 25
        valueStackView.alignment = .fill
        valueStackView.distribution = .fill
        valueStackView.addArrangedSubview(redSliderValue)
        valueStackView.addArrangedSubview(greenSliderValue)
        valueStackView.addArrangedSubview(blueSliderValue)
    }
    
    private func configureSliderStackView() {
        sliderStackView.spacing = 12
        sliderStackView.alignment = .fill
        sliderStackView.distribution = .fill
        sliderStackView.addArrangedSubview(redSlider)
        sliderStackView.addArrangedSubview(greenSlider)
        sliderStackView.addArrangedSubview(blueSlider)
    }
    
    private func configureTextFieldStackView() {
        textFieldStackView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        textFieldStackView.spacing = 4
        textFieldStackView.alignment = .fill
        textFieldStackView.distribution = .fill
        textFieldStackView.addArrangedSubview(redTextField)
        textFieldStackView.addArrangedSubview(greenTextField)
        textFieldStackView.addArrangedSubview(blueTextField)
    }
}

// MARK: UI-elements
extension ColorView {
    
    private func makeView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }
    
    private func makeLabelView(withTitle title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        return label
    }
    
    private func makeSliderView() -> UISlider {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }
    
    private func makeTextFieldView() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemBackground
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        textField.minimumFontSize = 17
        textField.adjustsFontSizeToFitWidth = true
        return textField
    }
    
    private func makeStackView(axis: Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        return stackView
    }
}
