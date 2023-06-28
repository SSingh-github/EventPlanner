//
//  Hashtags.swift
//  EventPlanner
//
//  Created by Chicmic on 27/06/23.
//

import SwiftUI

struct HashTags: View {
    
    @Binding var hashtags: [String]
    
    var body: some View {
        VStack {
            ForEach(hashtags.indices, id: \.self) { index in
                HStack {
                    TextFieldView(placeholder: Constants.Labels.Placeholders.hashtag, text: $hashtags[index])
                    Button {
                        hashtags.remove(at: index)
                    } label: {
                        Image(systemName: Constants.Images.multiply)
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}
