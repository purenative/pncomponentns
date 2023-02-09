public extension TextInput {
    
    static func phone(code: String, format: String) -> TextInputFormatter {
        TextInputPhoneFormat(
            code: code,
            format: format
        )
    }
    
}
