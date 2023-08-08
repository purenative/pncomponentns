import Foundation
import UIKit
import SwiftUI

final class TextInputWrapperCoordinator: NSObject {
    
    private weak var textField: UITextField?
    
    @Binding
    var text: String
    
    let formatter: TextInputFormatter?
    
    let onFocusChanged: (Bool) -> Void
    
    init(text: Binding<String>, formatter: TextInputFormatter?, onFocusChanged: @escaping (Bool) -> Void) {
        _text = text
        self.formatter = formatter
        self.onFocusChanged = onFocusChanged
    }
    
    deinit {
        textField?.removeTarget(
            self,
            action: #selector(handleEditingChanged),
            for: .editingChanged
        )
        
        textField?.removeTarget(
            self,
            action: #selector(handleEditingDidBegin),
            for: .editingDidBegin
        )
        textField?.removeTarget(
            self,
            action: #selector(handleEditingDidEnd),
            for: .editingDidEnd
        )
    }
    
    func bind(textField: UITextField) {
        self.textField = textField
        textField.delegate = self
        
        textField.addTarget(
            self,
            action: #selector(handleEditingChanged),
            for: .editingChanged
        )
        
        textField.addTarget(
            self,
            action: #selector(handleEditingDidBegin),
            for: .editingDidBegin
        )
        textField.addTarget(
            self,
            action: #selector(handleEditingDidEnd),
            for: .editingDidEnd
        )
    }
    
    func updateTextIfNeeded(_ text: String) {
        if textField?.text != text {
            textField?.text = text
            textField?.sendActions(for: .editingChanged)
        }
    }
    
    func updateFocusedIfNeeded(_ focused: Bool) {
        guard let textField else {
            return
        }
        
        DispatchQueue.main.async {
            if focused {
                if !textField.isFirstResponder {
                    textField.becomeFirstResponder()
                }
            } else {
                if textField.isFirstResponder {
                    textField.resignFirstResponder()
                }
            }
        }
    }
    
}

extension TextInputWrapperCoordinator: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let formatter else {
            return true
        }
        
        textField.text = formatter.process(
            originalString: textField.text ?? "",
            appending: string
        )
        
        textField.sendActions(for: .editingChanged)
        
        return false
    }
    
    @objc
    func handleEditingChanged(_ textField: UITextField) {
        text = textField.text ?? ""
    }
    
    @objc
    func handleEditingDidBegin() {
        DispatchQueue.main.async { [weak self] in
            self?.onFocusChanged(true)
        }
    }
    
    @objc
    func handleEditingDidEnd() {
        DispatchQueue.main.async { [weak self] in
            self?.onFocusChanged(false)
        }
    }
    
}
