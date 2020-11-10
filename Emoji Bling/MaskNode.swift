//
//  MaskNode.swift
//  Emoji Bling
//
//  Created by Laurent Azarnouche on 11/7/20.
//


import SceneKit

class MaskNode: SCNNode {
  
  var options: [UIImage]
  var index = 0
  
  init(with options: [UIImage],zpostion: Float = 0.058 , width: CGFloat =  0.14, height: CGFloat = 0.10,
       ypostion: Float = -0.04) {
    self.options = options
    
    super.init()
    
    let plane = SCNPlane(width: width, height: height)
    plane.firstMaterial?.isDoubleSided = true
    plane.firstMaterial?.diffuse.contents = UIColor.red


    plane.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "real_mask")
    self.position.z = zpostion
    self.position.y = ypostion
    
    geometry = plane
    


    

    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Custom functions

extension MaskNode {
  
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

