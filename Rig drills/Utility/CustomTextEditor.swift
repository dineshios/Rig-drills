//
//  CustomTextEditor.swift
//  Rig drills
//
//  Created by Dinesh on 04/04/25.
//

import SwiftUI

struct CustomTextEditor: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isValid: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.headline)
            
            HStack {
                TextEditor(text: $text)
                    .frame(height: 150)
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1))
                
                // Show alert image if invalid
                if !text.isEmpty && !isValid {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
