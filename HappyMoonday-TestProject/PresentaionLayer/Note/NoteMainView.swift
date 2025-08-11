//
//  NoteMainView.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import SwiftUI

struct NoteMainView: View {
    let books: [Book.Entity.BookItem] = [.init(title: "제목",
                                               link: "",
                                               image: "",
                                               author: "저자",
                                               discount: "",
                                               publisher: "",
                                               pubdate: "",
                                               isbn: "",
                                               description: ""),
                                         .init(title: "제목",
                                                                                    link: "",
                                                                                    image: "",
                                                                                    author: "저자",
                                                                                    discount: "",
                                                                                    publisher: "",
                                                                                    pubdate: "",
                                                                                    isbn: "",
                                                                                    description: ""),
                                         .init(title: "제목",
                                                                                    link: "",
                                                                                    image: "",
                                                                                    author: "저자",
                                                                                    discount: "",
                                                                                    publisher: "",
                                                                                    pubdate: "",
                                                                                    isbn: "",
                                                                                    description: ""),
                                         .init(title: "제목",
                                                                                    link: "",
                                                                                    image: "",
                                                                                    author: "저자",
                                                                                    discount: "",
                                                                                    publisher: "",
                                                                                    pubdate: "",
                                                                                    isbn: "",
                                                                                    description: "")]
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
             Text("노트 목록")
                 .font(Font(FontManager.title2SB.font!))
                 .padding(.horizontal)
             
             BookListView(books: books)
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
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

struct BookListView: View {
    let books: [Book.Entity.BookItem]

    var body: some View {
        List(books) { book in
            BookItemView(book: book)
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        }
        .listStyle(PlainListStyle())
    }
}
