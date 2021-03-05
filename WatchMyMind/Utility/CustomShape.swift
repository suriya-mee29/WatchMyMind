//
//  CustomShape.swift
//  WatchMyMind
//
//  Created by Suriya on 31/1/2564 BE.
//

import SwiftUI

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomRight,.topRight], cornerRadii: CGSize(width: 170, height: 170))
        return Path(path.cgPath)
    }
}

struct CustomShape_Previews: PreviewProvider {
    static var previews: some View {
        CustomShape()
    }
}
