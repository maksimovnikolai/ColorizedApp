//
//  ColorView.swift
//  Colorized
//
//  Created by Nikolai Maksimov on 22.12.2023.
//

import UIKit


final class ColorView: UIView {
    
    typealias Axis = NSLayoutConstraint.Axis
    
    lazy var colorView = makeView()
    
    lazy var redLabel = makeLabelView()
    lazy var greenLabel = makeLabelView()
    lazy var blueLabel = makeLabelView()
    
    lazy var redSlider = makeSliderView(trackColor: .red, value: 0.22)
    lazy var greenSlider = makeSliderView(trackColor: .green, value: 0.47)
    lazy var blueSlider = makeSliderView(value: 0.69)
    
    lazy var redTextField = makeTextFieldView()
    lazy var greenTextField = makeTextFieldView()
    lazy var blueTextField = makeTextFieldView()

    private lazy var redLabelText = makeLabelView(withTitle: "Red")
    private lazy var greenLabelText = makeLabelView(withTitle: "Green")
    private lazy var blueLabelText = makeLabelView(withTitle: "Blue")
    
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
        titleStackView.addArrangedSubview(redLabelText)
        titleStackView.addArrangedSubview(greenLabelText)
        titleStackView.addArrangedSubview(blueLabelText)
    }
    
    private func configureValueStackView() {
        valueStackView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        valueStackView.spacing = 25
        valueStackView.alignment = .fill
        valueStackView.distribution = .fill
        valueStackView.addArrangedSubview(redLabel)
        valueStackView.addArrangedSubview(greenLabel)
        valueStackView.addArrangedSubview(blueLabel)
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
        view.layer.cornerRadius = 15
        return view
    }
    
    private func makeLabelView(withTitle title: String? = nil) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = .systemFont(ofSize: 14)
        return label
    }
    
    private func makeSliderView(trackColor: UIColor? = nil, value: Float ) -> UISlider {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = trackColor
        slider.value = value
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
