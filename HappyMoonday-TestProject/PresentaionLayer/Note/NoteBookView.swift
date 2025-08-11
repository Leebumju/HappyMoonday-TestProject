//
//  NoteBookView.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/11/25.
//

import SwiftUI

struct NoteBookView: View {
//    @ObservedObject var viewModel: NoteBookViewModel
    var coordinator: AnyNoteCoordinator?
    @State private var category: BookCategory = .readDone
    @State private var bookTitle: String = ""
    @State private var author: String = ""
    @State private var descriptionText: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    NoteTextFieldView(
                        text: $bookTitle,
                        placeholder: "책 제목"
                    )
                    
                    NoteTextFieldView(
                        text: $author,
                        placeholder: "저자"
                    )
                    
                    Text("책 설명(선택 사항)")
                        .font(.body)
                        .foregroundColor(.black)
                    
                    TextEditor(text: $descriptionText)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .frame(height: 300)
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)
            }
            
            Button(action: {
//                viewModel.saveBook(
//                    category: category,
//                    title: bookTitle,
//                    author: author,
//                    description: descriptionText
//                )
            }) {
                Text("저장")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
//                    .background(viewModel.isSaveEnabled ? Color.blue : Color.gray)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, getDefaultSafeAreaBottom())
//            .disabled(!viewModel.isSaveEnabled)
        }
        .navigationTitle("책 추가")
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
