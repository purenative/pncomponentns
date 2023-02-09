import Foundation
import UIKit
import SwiftUI

final class TextInputWrapperCoordinator: NSObject {
    
    private weak var textField: UITextField?
    
    @Binding
    var text: String
    
    let formatter: TextInputFormatter?
    
    init(text: Binding<String>, formatter: TextInputFormatter?) {
        _text = text
        self.formatter = formatter
    }
    
    deinit {
        textField?.removeTarget(
            self,
            action: #selector(handleEditingChanged),
            for: .editingChanged
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
    }
    
    func updateTextIfNeeded(_ text: String) {
        if textField?.text != text {
            textField?.text = text
            textField?.sendActions(for: .editingChanged)
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
    
}
