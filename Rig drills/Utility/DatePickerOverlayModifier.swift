//
//  CustomDatePickerOverlay.swift
//  Rig drills
//
//  Created by Dinesh on 04/04/25.
//

import SwiftUI

struct DatePickerOverlayModifier<Field: Hashable>: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var selectedDate: Date
    var selectedField: Field?
    var onDone: (Field, Date) -> Void

    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isPresented ? 3 : 0)
                .animation(.easeInOut(duration: 0.2), value: isPresented)

            if isPresented {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { isPresented = false }
                    }

                VStack(spacing: 16) {
                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                    Button("Done") {
                        if let field = selectedField {
                            onDone(field, selectedDate)
                        }
                        withAnimation {
                            isPresented = false
                        }
                    }
                    .foregroundColor(.blue)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding()
                .transition(.scale)
            }
        }
    }
}

extension View {
    func customDatePickerOverlay<Field: Hashable>(
        isPresented: Binding<Bool>,
        selectedDate: Binding<Date>,
        selectedField: Field?,
        onDone: @escaping (Field, Date) -> Void
    ) -> some View {
        self.modifier(DatePickerOverlayModifier(
            isPresented: isPresented,
            selectedDate: selectedDate,
            selectedField: selectedField,
            onDone: onDone
        ))
    }
}
