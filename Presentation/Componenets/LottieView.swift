//
//  LottieView.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import Foundation
import SwiftUI
import Lottie
import AppKit

struct LottieView: NSViewRepresentable {
    var name : String
    var loopMode: LottieLoopMode
    
    init(jsonName: String = "", loopMode : LottieLoopMode = .loop){
        self.name = jsonName
        self.loopMode = loopMode
    }
    
    func makeNSView(context: NSViewRepresentableContext<LottieView>) -> some NSView {
        let view = NSView(frame: .zero)
        let animationView = LottieAnimationView()
        var animation = LottieAnimation.named(name)
        let fileLocation = Bundle.main.url(forResource: name,
                                           withExtension: "json")!
        
        if animation == nil,
            let data = try? Data(contentsOf: fileLocation) {
            animation = try? LottieAnimation.from(data: data)

        }
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        animationView.loopMode = .loop
        animationView.play()
        
        return view
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        
    }
}
