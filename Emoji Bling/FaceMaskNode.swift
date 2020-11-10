//
//  FaceMaskNode.swift
//  Emoji Bling
//
//  Created by Laurent Azarnouche on 11/8/20.
//
import SceneKit

class FaceMaskNode: SCNNode {
  
  var options: [UIImage]
  var index = 0
  
  init(with options: [UIImage]) {
    self.options = options
    
    super.init()


    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Custom functions

extension FaceMaskNode {
  
  func updatePosition(for vectors: [vector_float3]) {
    let newPos = vectors.reduce(vector_float3(), +) / Float(vectors.count)
    position = SCNVector3(newPos)
  }
  
  func next() {
    index = (index + 1) % options.count
    
    if let plane = geometry as? SCNPlane {
      plane.firstMaterial?.diffuse.contents = options[index]
      plane.firstMaterial?.isDoubleSided = true
    }
  }
}

