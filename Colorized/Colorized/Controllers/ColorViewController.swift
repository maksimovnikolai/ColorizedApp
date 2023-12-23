//
//  ColorViewController.swift
//  Colorized
//
//  Created by Nikolai Maksimov on 22.12.2023.
//

import UIKit

final class ColorViewController: UIViewController {
    
    var viewColor: UIColor!
    weak var delegate: ColorViewControllerDelegate?
    
    private let colorView = ColorView()
    
    override func loadView() {
        view = colorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        commonInit()
    }
}

// MARK: Private Methods
extension ColorViewController {
    
    private func commonInit() {
        colorView.colorView.backgroundColor = viewColor
        addTargets()
        setupDelegate()
        setSliders()
        setValue(for: colorView.redLabel, colorView.greenLabel, colorView.blueLabel)
        setValue(for: colorView.redTextField, colorView.greenTextField, colorView.blueTextField)
    }
    
    private func setupDelegate() {
        [colorView.redTextField,
         colorView.blueTextField,
         colorView.greenTextField].forEach { $0.delegate = self }
    }
    
    private func setColor() {
        colorView.colorView.backgroundColor =
        UIColor(red: CGFloat(colorView.redSlider.value),
                green: CGFloat(colorView.greenSlider.value),
                blue: CGFloat(colorView.blueSlider.value),
                alpha: 1)
    }
    
    private func addTargets() {
        colorView.redSlider.addTarget(self, action: #selector(changeValues), for: .valueChanged)
        colorView.greenSlider.addTarget(self, action: #selector(changeValues), for: .valueChanged)
        colorView.blueSlider.addTarget(self, action: #selector(changeValues), for: .valueChanged)
        colorView.doneButton.addTarget(self, action: #selector(showMain), for: .touchUpInside)
    }
    
    @objc
    private func changeValues() {
        [colorView.redSlider, colorView.greenSlider, colorView.blueSlider].forEach { slider in
                switch slider {
                case colorView.redSlider:
                    setValue(for: colorView.redLabel)
                    setValue(for: colorView.redTextField)
                case colorView.greenSlider:
                    setValue(for: colorView.greenLabel)
                    setValue(for: colorView.greenTextField)
                default:
                    setValue(for: colorView.blueLabel)
                    setValue(for: colorView.blueTextField)
                }
            }
        setColor()
    }
    
    @objc
    private func showMain() {
        delegate?.setColor(self, colorView.colorView.backgroundColor ?? .clear)
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapDone() {
        view.endEditing(true)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case colorView.redLabel:
                colorView.redLabel.text = string(from: colorView.redSlider)
            case colorView.greenLabel:
                colorView.greenLabel.text = string(from: colorView.greenSlider)
            default:
                colorView.blueLabel.text = string(from: colorView.blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textfield in
            switch textfield {
            case colorView.redTextField:
                colorView.redTextField.text = string(from: colorView.redSlider)
            case colorView.greenTextField:
                colorView.greenTextField.text = string(from: colorView.greenSlider)
            default:
                colorView.blueTextField.text = string(from: colorView.blueSlider)
            }
        }
    }
    
    private func setSliders() {
        let ciColor = CIColor(color: viewColor)
        colorView.redSlider.value = Float(ciColor.red)
        colorView.greenSlider.value = Float(ciColor.green)
        colorView.blueSlider.value = Float(ciColor.blue)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension ColorViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            switch textField {
            case colorView.redTextField:
                colorView.redSlider.setValue(currentValue, animated: true)
                setValue(for: colorView.redLabel)
            case colorView.greenTextField:
                colorView.greenSlider.setValue(currentValue, animated: true)
                setValue(for: colorView.greenLabel)
            default:
                colorView.blueSlider.setValue(currentValue, animated: true)
                setValue(for: colorView.blueLabel)
            }
            setColor()
            return
        }
        showAlert(title: "Неверный формат!", message: "Введите корректное значение")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        textField.inputAccessoryView = keyboardToolBar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBrButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        keyboardToolBar.items = [flexBrButton, doneButton]
    }
}
