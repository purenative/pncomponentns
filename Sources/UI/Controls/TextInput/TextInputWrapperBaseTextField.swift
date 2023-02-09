import Foundation
import UIKit

final class TextInputWrapperBaseTextField: UITextField {
    
    typealias Configuration = (UITextField) -> Void
    
    private var doneButton: UIBarButtonItem?
    
    init(configuration: Configuration) {
        super.init(frame: .zero)
        
        configuration(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addDoneButton() {
        guard doneButton == nil else {
            return
        }
        
        doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(handleDoneButton)
        )
        
        let toolbar = UIToolbar()
        toolbar.setItems([
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            doneButton!
        ], animated: false)
        inputAccessoryView = toolbar
        toolbar.sizeToFit()
    }
    
    @objc
    private func handleDoneButton() {
        endEditing(true)
    }
    
}
