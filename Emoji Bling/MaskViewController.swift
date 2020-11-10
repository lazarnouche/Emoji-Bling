//
//  ViewController.swift
//  Emoji Bling
//
//  Created by Laurent Azarnouche on 10/23/20.
//

import UIKit
import ARKit
let noseOptions = ["👃", "🐽", "💧"]
let maskOptions = [#imageLiteral(resourceName: "trump"), #imageLiteral(resourceName: "scorpio"),#imageLiteral(resourceName: "real_mask"),#imageLiteral(resourceName: "art"),#imageLiteral(resourceName: "stocks"),#imageLiteral(resourceName: "sf"),#imageLiteral(resourceName: "nefertiti"),#imageLiteral(resourceName: "math")]
let eyeOptions = ["👁", "🌕", "🌟", "🔥", "⚽️", "🔎", " "]
var currentIndex = 0


let planeWidth: CGFloat = 0.14
let planeHeight: CGFloat = 0.10
let nodeYPosition: Float = -0.04

class MaskViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    func someFunction() {
        self.mainLabel.text = "Salope!"
        }
    
    @IBOutlet var viewScen: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainLabel.text = "Let's Climb!!"
        guard ARFaceTrackingConfiguration.isSupported else {
          fatalError("Face tracking is not supported on this device")
        }
        viewScen.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: viewScen)

    
        let results = viewScen.hitTest(location, options: nil)
        
        guard let result = results.first else {
          return
        }
        if result.node.name == "face" {
          let node = result.node
          currentIndex = (currentIndex + 1) % maskOptions.count
          node.geometry?.firstMaterial?.diffuse.contents = maskOptions[currentIndex]
        }
 
    
//        if let result = results.first,
//          let node = result.node as? MaskNode {
//
//
//          node.next()
//          someFunction()
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
            
      // 1
      let configuration = ARFaceTrackingConfiguration()
            
      // 2
        viewScen.session.run(configuration)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
            
      // 1
        viewScen.session.pause()
    }
    func updateFeatures(for node: SCNNode, using anchor: ARFaceAnchor) {

      let child = node.childNode(withName: "nose", recursively: false) as? EmojiNode

      let vertices = [anchor.geometry.vertices[9]]
      
      child?.updatePosition(for: vertices)
    }


}


extension MaskViewController: ARSCNViewDelegate {
  func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
    
//    guard let sceneView = renderer as? ARSCNView,
//        anchor is ARFaceAnchor else { return nil }
//
    guard let _ = anchor as? ARFaceAnchor,
      let device = viewScen.device else {
      return nil
    }

    let faceGeometry = ARSCNFaceGeometry(device: device)!
    let material = faceGeometry.firstMaterial!
    

    material.diffuse.contents = maskOptions[0]// Example texture map image.
    material.lightingModel = .physicallyBased

    let mainNode = SCNNode(geometry: faceGeometry)
    mainNode.name = "face"



//    node.geometry?.firstMaterial?.fillMode = .lines

//    let maskNode = MaskNode(with: maskOptions )
//    print(node.boundingBox.max.z * 3 / 4)
//    maskNode.name = "mask"
//
//    node.addChildNode(maskNode)
////
//    node.geometry?.firstMaterial?.transparency = 0
//
//    updateFeatures(for: node, using: faceAnchor)

    return mainNode
  }
    
    
    func renderer(
      _ renderer: SCNSceneRenderer,
      didUpdate node: SCNNode,
      for anchor: ARAnchor) {
       
      // 2
      guard let faceAnchor = anchor as? ARFaceAnchor,
        let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
          return
      }
        
      // 3
      faceGeometry.update(from: faceAnchor.geometry)
      updateFeatures(for: node, using: faceAnchor)
    }
}


//    let glassesPlane = SCNPlane(width: planeWidth, height: planeHeight)
//    glassesPlane.firstMaterial?.isDoubleSided = true
//    glassesPlane.firstMaterial?.diffuse.contents = UIColor.red
//
//    let glassesNode = SCNNode()
//            glassesNode.geometry = glassesPlane
//
//
//
//    glassesPlane.firstMaterial?.diffuse.contents = UIImage(named: "real_mask")
//
////    let glassesPlane = SCNPlane(width: planeWidth, height: planeHeight)
//    glassesNode.position.z = node.boundingBox.max.z * 3 / 4
//    glassesNode.position.y = nodeYPosition
    
    
//    node.addChildNode(glassesNode)
//    zpostion:node.boundingBox.max.z * 3 / 4


//    let noseNode = EmojiNode(with: noseOptions)
//
//    noseNode.name = "nose"

//    node.addChildNode(noseNode)
    
//    let leftEyeNode = EmojiNode(with: eyeOptions)
//    leftEyeNode.name = "leftEye"
//    leftEyeNode.rotation = SCNVector4(0, 1, 0, GLKMathDegreesToRadians(180.0))
//    node.addChildNode(leftEyeNode)
//
//    let rightEyeNode = EmojiNode(with: eyeOptions)
//    rightEyeNode.name = "rightEye"
//    node.addChildNode(rightEyeNode)
