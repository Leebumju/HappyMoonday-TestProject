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
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("노트 목록")
                .font(Font(FontManager.title2SB.font!))
            
            BookListView(
                books: viewModel.notedBooks,
                onBookTap: { book in
                    print("선택된 책: \(book.title)")
                    coordinator?.moveTo(.noteBook,
                                        userData: ["bookInfo": book])
                }
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
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: book.image)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 60, height: 90)
            .cornerRadius(8)
            
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
        }
        .padding(.vertical, 8)
    }
}

struct BookListView: View {
    let books: [Book.Entity.BookItem]
    let onBookTap: (Book.Entity.BookItem) -> Void
    
    var body: some View {
        List(books) { book in
            BookItemView(book: book)
                .onTapGesture {
                    onBookTap(book)
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        }
        .listStyle(PlainListStyle())
    }
}
