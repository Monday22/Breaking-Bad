//
//  CharacterView.swift
//  Breaking Bad
//
//  Created by Anthony Lartey on 22/03/2024.
//

import SwiftUI

struct CharacterView: View {
    let show: String
    let character: Character
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                // background Image
                Image(show.lowerNoSpaces)
                    .resizable()
                    .scaledToFit()
                ScrollView {
                    // character Image
                    VStack {
                        AsyncImage(url: character.images.randomElement()) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .frame(width: geo.size.width / 1.2, height: geo.size.height / 1.7)
                    .cornerRadius(25.0)
                    .padding(.top, 60.0)
                    // character info
                    VStack(alignment: .leading) {
                        Group {
                            Text(character.name)
                                .font(.largeTitle)
                            Text("Portrayed By: \(character.portrayedBy)")
                                .font(.subheadline)
                            Divider()
                            Text("\(character.name) Character Info")
                                .font(.title2)
                            Text("Born: \(character.birthday)")
                            Divider()
                        }
                        Group {
                        Text("Occupations:")
                            .font(.subheadline)
                            ForEach(character.occupations, id:\.self) { occupation in
                            Text("• \(occupation)")
                        }
                        Divider()
                        Text("NickNames")
                            if character.aliases.count > 0 {
                                ForEach(character.aliases, id:\.self) { alias in
                                    Text("• \(alias)")
                                }
                            } else {
                                Text("None")
                                    .font(.subheadline)
                            }
                            Divider()
                            Text("• \(character.status)")
                                .font(.subheadline)
                        }
                    }
                    .padding([.leading, .bottom], 40.0)
                }
            }
        }
        .ignoresSafeArea()
    }
}
#Preview {
    CharacterView(show: Constants.bbName, character: Constants.previewCharacter)
}
