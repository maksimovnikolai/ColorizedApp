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

// MARK: Metods
extension ColorViewController {
    
    private func commonInit() {
        colorView.colorView.backgroundColor = viewColor
        addTargets()
        setSliders()
        setValue(for: colorView.redLabel, colorView.greenLabel, colorView.blueLabel)
        setValue(for: colorView.redTextField, colorView.greenTextField, colorView.blueTextField)
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
        delegate?.setColor(colorView.colorView.backgroundColor ?? .clear)
        navigationController?.popViewController(animated: true)
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
}
