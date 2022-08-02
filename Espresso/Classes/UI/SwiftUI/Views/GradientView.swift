//
//  GradientView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/22/22.
//

//import SwiftUI
//
///// Gradient view with configurable colors, stops, & direction.
//public struct GradientView: UIViewRepresentable {
//
//    public typealias UIViewType = UIGradientView
//
//    @Binding private var colors: [UIColor]
//    @Binding private var direction: UIGradientView.Direction
//    @Binding private var stops: UIGradientView.StopMode
//    
//    public init(colors: Binding<[UIColor]> = .value([.black, .clear]),
//                direction: Binding<UIGradientView.Direction> = .value(.up),
//                stops: Binding<UIGradientView.StopMode> = .value(.linear)) {
//
//        self._colors = colors
//        self._direction = direction
//        self._stops = stops
//
//    }
//
//    public func makeUIView(context: Context) -> UIGradientView {
//
//        return UIGradientView(
//            colors: self.colors,
//            direction: self.direction
//        )
//
//    }
//
//    public func updateUIView(_ uiView: UIGradientView,
//                             context: Context) {
//
//        uiView.colors = self.colors
//        uiView.direction = self.direction
//        uiView.stops = self.stops
//
//    }
//
//}
