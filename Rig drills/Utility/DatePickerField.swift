//
//  DatePicker.swift
//  Rig drills
//
//  Created by Dinesh on 04/04/25.
//

import SwiftUI

import SwiftUI

struct CustomDatePickerField: View {
    var label: String
    var placeholder: String
    var date: Date?
    var onTap: () -> Void
    let str: String = ""

    var body: some View {
        let str = date.map { dateFormatter.string(from: $0) } ?? ""
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.headline)
            Text(str)
                .foregroundColor(.primary)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.4))
                )
                .onTapGesture {
                    onTap()
                }
        }
        .padding(.vertical, 4)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
