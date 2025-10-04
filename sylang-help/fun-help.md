# Function Definition (.fun)

## Overview
Defines **functional behavior** and decomposition. Maps features to executable functions with conditional visibility based on configurations.

## File Structure
- **ONE** `hdef functionset` per file
- **MULTIPLE** `def function` statements
- Can `use` featuresets, configsets
- Supports functional decomposition

## Valid Keywords
```
use, hdef, functionset, def, function, name, description, owner, tags, 
level, safetylevel, functiontype, enables, decomposesto, allocatedto, 
when, ref, config, needs, provides
```

## Example
```sylang
use featureset AutonomousVehicleFeatures
use configset AutonomousVehicleConfig

hdef functionset AutonomousPerceptionFunctions
  name "Autonomous Vehicle Perception Functions"
  description "Core perception functions for environmental awareness"
  owner "Perception Systems Team"
  safetylevel ASIL-D

  def function CameraImageProcessing
    name "Camera Image Processing Function"
    description "Real-time processing of stereo and mono camera feeds"
    owner "Computer Vision Team"
    enables ref feature CameraSystem
    safetylevel ASIL-D
    when ref config c_CameraSystem

  def function LidarPointCloudProcessing
    name "LiDAR Point Cloud Processing Function"
    description "3D point cloud processing for precise distance measurement"
    owner "LiDAR Processing Team"
    enables ref feature LidarSystem
    safetylevel ASIL-C
    when ref config c_LidarSystem

  def function SensorFusion
    name "Multi-Sensor Fusion Function"
    description "Fusion of camera, LiDAR, and radar data"
    owner "Sensor Fusion Team"
    enables ref feature PerceptionSystem
    safetylevel ASIL-D
    decomposesto ref function CameraImageProcessing, LidarPointCloudProcessing
```

## Function Types
```
functiontype solution         # Solution-level function
functiontype function         # Standard function
functiontype solutionelement  # Solution element function
```

## Relationships
- `enables ref feature` - Enables a feature
- `decomposesto ref function` - Decomposes to other functions
- `allocatedto ref block` - Allocated to a block
- `when ref config` - Conditional visibility

---
See `.fml` for feature definitions and `.blk` for block definitions.

