//
//  NoteBookView.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/11/25.
//

import SwiftUI

struct NoteBookView: View {
    @ObservedObject var viewModel: NoteBookViewModel
    var coordinator: AnyNoteCoordinator?
    @State private var category: BookCategory = .readDone
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var showStartDatePicker = false
    @State private var showEndDatePicker = false
    @State private var noteText: String = ""
    
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    HStack() {
                        Spacer()
                        Text("기록")
                            .font(Font(FontManager.title2SB.font!))
                        Spacer()
                        Text("저장")
                            .font(Font(FontManager.body1M.font!))
                            .foregroundColor(Color.blue)
                            .onTapGesture {
                                Task {
                                    do {
                                        try viewModel.noteBook(startDate: startDate,
                                                               endDate: endDate,
                                                               note: noteText)
                                    } catch {}
                                }
                            }
                    }
                    
                    HStack {
                        AsyncImage(url: URL(string: viewModel.bookInfo.image)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 60, height: 90)
                        .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.bookInfo.title)
                                .font(.headline)
                            Text(viewModel.bookInfo.author)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    
                    Text("시작일")
                        .font(Font(FontManager.body2B.font!))
                    
                    Button {
                        showStartDatePicker = true
                    } label: {
                        HStack {
                            Text(dateFormatter.string(from: startDate))
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "calendar")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $showStartDatePicker) {
                        DatePicker(
                            "시작일 선택",
                            selection: $startDate,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .padding()
                    }
                    
                    Text("종료일")
                        .font(Font(FontManager.body2B.font!))
                    
                    Button {
                        showEndDatePicker = true
                    } label: {
                        HStack {
                            Text(dateFormatter.string(from: endDate))
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "calendar")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $showEndDatePicker) {
                        DatePicker(
                            "종료일 선택",
                            selection: $endDate,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .padding()
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)
            }
            .onAppear {
                startDate = viewModel.bookInfo.startDate ?? Date()
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct NoteTextFieldView: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
    }
}
