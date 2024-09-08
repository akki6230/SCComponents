import SwiftUI
import SCTokens

public struct SDTextField: View {
    @Binding private var text: String
    private let placeholder: String
    private let errorMessage: String
    private let isSecure: Bool
    
    @FocusState private var isTextFieldFocused: Bool
    
    private var isTextFieldInputChanged: Bool {
        !text.isEmpty || isTextFieldFocused
    }
    
    public init(text: Binding<String>, placeholder: String, errorMessage: String, isSecure: Bool = false) {
        self._text = text
        self.placeholder = placeholder
        self.errorMessage = errorMessage
        self.isSecure = isSecure
    }

    public var body: some View {
        VStack(alignment: .leading) {
            VStack {
                ZStack(alignment: .leading) {
                    placeholderView
                    textField
                }
                .frame(height: Sizing.textFieldHeight)
            }
            .overlay {
                RoundedRectangle(cornerRadius: Sizing.sizing1x)
                    .stroke(Color.grayStroke, lineWidth: Sizing.sizing0xHalf)
            }
            errorView
        }
        .padding()
    }
    
    private var textField: some View {
        VStack {
            TextField(text: $text, prompt: nil) { }
                .textFieldStyle(SDTextFieldStyle())
                .focused($isTextFieldFocused)
                .onChange(of: isTextFieldFocused, perform: { _ in })
                .onChange(of: text, perform: { value in
                    
                })
        }
        .background(Color.clear)
    }
    
    @ViewBuilder
    private var placeholderView: some View {
        VStack {
            Text(placeholder)
                .foregroundColor(!isTextFieldInputChanged ? Color.placholder : .primaryText)
                .font(!isTextFieldInputChanged ? .font100Regular : .font75Light)
                .frame(height: !isTextFieldInputChanged ? Sizing.textFieldHeight : Sizing.sizing3x)
                .padding(EdgeInsets(top: Sizing.sizing1xHalf, leading: !isTextFieldInputChanged ? Sizing.sizing1x : Sizing.sizing2x, bottom: Sizing.sizing1x, trailing: !isTextFieldInputChanged ? Sizing.sizing1x : Sizing.sizing2x))
                .animation(.linear(duration: 0.3), value: !isTextFieldInputChanged)
            if isTextFieldInputChanged { Spacer() }
        }
    }

    @ViewBuilder
    private var errorView: some View {
        if text.isEmpty && isTextFieldFocused {
            Text(errorMessage)
                .frame(alignment: .leading)
                .font(.font75Light)
                .foregroundColor(Color.error)
                .padding(Spacing.spacing0x)
        }
        EmptyView()
    }
}

struct Usage: View {
    @State private var username: String = ""
    var body: some View {
        SDTextField(text: $username, placeholder: "Email", errorMessage: "Enter a valid email", isSecure: false)
    }
}

#Preview {
    Usage()
}
