//
//  FlagImageView.swift
//  Guess the Flag
//
//  Created by Raj Mazumder on 22/06/22.
//

import SwiftUI

struct FlagImageView: View {
    let flagName: String
    
    var body: some View{
        Image(flagName)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 10)
    }
}
