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
    @State private var startDate: String = ""
    @State private var endDate: String = ""
    @State private var noteText: String = ""
    
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
                                        try viewModel.noteBook(startDate: Date(),
                                                               endDate: Date(),
                                                               note: noteText)
                                    } catch {}
                                }
                            }
                    }
                    
                    HStack(alignment: .top, spacing: 12) {
                        AsyncImage(url: URL(string: viewModel.bookInfo.image)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 60, height: 90)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 90)
                                    .cornerRadius(8)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 90)
                                    .cornerRadius(8)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.bookInfo.title)
                                .font(Font(FontManager.title3B.font!))
                                .foregroundColor(.primary)
                                .lineLimit(2)
                            
                            Text(viewModel.bookInfo.author)
                                .font(Font(FontManager.body1M.font!))
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    
                    NoteTextFieldView(
                        text: $startDate,
                        placeholder: "독서 시작일"
                    )
                    
                    NoteTextFieldView(
                        text: $endDate,
                        placeholder: "독서 종료일"
                    )
                    
                    Text("감상문")
                        .font(.body)
                        .foregroundColor(.black)
                    
                    TextEditor(text: $noteText)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .frame(height: 300)
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)
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
