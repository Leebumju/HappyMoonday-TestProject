//
//  NoteMainView.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import SwiftUI

struct NoteMainView: View {
    @ObservedObject var viewModel: NoteMainViewModel
    var coordinator: AnyNoteCoordinator?
    @State private var isEditMode: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("노트 목록")
                .font(Font(FontManager.title2SB.font!))
            
            Text(isEditMode ? "완료" : "편집")
                .font(Font(FontManager.body2M.font!))
                .onTapGesture {
                    isEditMode.toggle()
                }
            
            BookListView(
                books: viewModel.notedBooks,
                onBookTap: { book in
                    print("선택된 책: \(book.title)")
                    coordinator?.moveTo(.noteBook, userData: ["bookInfo": book])
                },
                onDeleteBook: { book in
                    print("삭제할 책: \(book.title)")
                    // 삭제 처리 로직 넣기
                }, isEditMode: $isEditMode
            )
        }
        .background(Color.white)
        .onAppear {
            viewModel.fetchNotedBooks()
        }
    }
}

struct BookItemView: View {
    let book: Book.Entity.BookItem
    @Binding var isEditMode: Bool
    
    let onDelete: () -> Void
    let onTap: () -> Void 
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: book.image)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 60, height: 90)
            .cornerRadius(8)
            
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                        .truncationMode(.tail)
                        .lineLimit(2)
                    Text(book.author)
                        .font(.subheadline)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                    Text("등록일: \(book.recordDate?.dateToString(with: "yyyy-MM-dd") ?? "")")
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if isEditMode {
                    Button(action: {
                        onDelete()
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.red)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 24, height: 24)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}

struct BookListView: View {
    let books: [Book.Entity.BookItem]
    let onBookTap: (Book.Entity.BookItem) -> Void
    let onDeleteBook: (Book.Entity.BookItem) -> Void
    @Binding var isEditMode: Bool
    
    var body: some View {
        List(books) { book in
            BookItemView(
                book: book,
                isEditMode: $isEditMode,
                onDelete: { onDeleteBook(book) },
                onTap: { onBookTap(book) }
            )
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        }
        .listStyle(PlainListStyle())
    }
}
