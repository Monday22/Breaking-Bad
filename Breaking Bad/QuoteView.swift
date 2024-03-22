//
//  QuoteView.swift
//  Breaking Bad
//
//  Created by Anthony Lartey on 22/03/2024.
//

import SwiftUI

struct QuoteView: View {
    @StateObject private var viewModel = ViewModel(controller: FetchController())
    @State private var showCharacterInfo: Bool = false
    let show: String
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.lowerNoSpaces)
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                VStack {
                    VStack {
                        Spacer(minLength: 140.0)
                        switch viewModel.status {
                        case .success(let data):
                            Text("\"\(data.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(Color.white)
                                .padding()
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(25.0)
                                .padding(.horizontal)
                            Text(data.character.name)
                                .font(.title)
                                .foregroundStyle(Color.white)
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: data.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                                .onTapGesture {
                                    showCharacterInfo.toggle()
                                }
                                .sheet(isPresented: $showCharacterInfo) {
                                    CharacterView(show: show, character: data.character)
                                }
                                Text(data.character.status)
                                    .foregroundStyle(Color.white)
                                    .padding(10.0)
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .background(.ultraThinMaterial)
                            }
                            .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                            .cornerRadius(80.0)
                        case .fetching:
                            ProgressView()
                        default:
                            EmptyView()
                        }
                        Spacer()
                    }
                    Button {
                        Task {
                            await viewModel.getData(for: show)
                        }
                    } label: {
                        Text("Get Random Quote")
                            .font(.title)
                            .foregroundStyle(Color.white)
                            .padding()
                            .background(Color("\(show.noSpaces)Button"))
                            .cornerRadius(7.0)
                            .shadow(color: Color("\(show.noSpaces)Shadow"), radius: 2.0)
                    }
                    Spacer(minLength: 180.0)
                }
                .frame(width: geo.size.width)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}
#Preview {
    QuoteView(show: Constants.bbName)
        .preferredColorScheme(.dark)
}
