//
//  XView.swift
//  X-O Game
//
//  Created by Alex Larin on 21.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit
// класс отрисовки View крестика
public class XView: MarkView {
    
    internal override func updateShapeLayer() {
        super.updateShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.25 * bounds.width, y: 0.25 * bounds.height))
        path.addLine(to: CGPoint(x: 0.75 * bounds.width, y: 0.75 * bounds.height))
        path.move(to: CGPoint(x: 0.75 * bounds.width, y: 0.25 * bounds.height))
        path.addLine(to: CGPoint(x: 0.25 * bounds.width, y: 0.75 * bounds.height))
        shapeLayer.path = path.cgPath
    }
}
