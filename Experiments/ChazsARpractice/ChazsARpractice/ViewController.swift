//
//  ViewController.swift
//  ChazsARpractice
//
//  Created by Chaz Clark on 9/10/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    //var lastPoint = CGPoint.zeroPoint
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(ViewController.handleTap(gestureRecognize:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    
    
    @objc
    func handleTap(gestureRecognize: UITapGestureRecognizer)  {
        
        guard let currentFrame = sceneView.session.currentFrame else{
            return
        }
        
        
        //Create an image plane using a snapshot of the view
        let imagePlane = SCNPlane(width: sceneView.bounds.width/3000, height:sceneView.bounds.height/3000)
        imagePlane.firstMaterial?.diffuse.contents = sceneView.snapshot()
        imagePlane.firstMaterial?.lightingModel = .constant
        
        //Create a plane node and add it to the scene
        let planeNode = SCNNode(geometry: imagePlane)
        sceneView.scene.rootNode.addChildNode(planeNode)
        let satellite: SCNNode = SCNNode()
        
        satellite.geometry = SCNSphere(radius: 0.5)
        satellite.geometry?.firstMaterial?.diffuse.contents = sceneView.snapshot()
        satellite.scale = SCNVector3Make(0.05, 0.05, 0.05)
        sceneView.scene.rootNode.addChildNode(satellite)
        
        
        //Set transform of node to be 10cm infront of camera
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.25 //10cm
        planeNode.simdTransform = matrix_multiply(currentFrame.camera.transform, translation);
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
