# Block Definition (.blk)

## Overview
The `.blk` file defines **hardware/software blocks** with their interfaces (operations, signals, parameters). It represents architectural elements in your system design.

## File Structure Rules
- **ONE** `hdef block` statement per file
- **MULTIPLE** `def operation`, `def signal`, `def parameter` statements
- Can `use` configsets, featuresets, functionsets, interfacesets
- Supports `needs`/`provides` for interfaces at hdef level
- Block relationships defined at hdef level

## Valid Keywords
```
use, hdef, block, def, operation, signal, parameter, characteristic,
name, description, designrationale, comment, owner, tags, level, 
safetylevel, blocktype, chartype, specification, tolerance, controlmethod,
measuringequipment, value, decomposesto, decomposesfrom, enables, needs, 
provides, requires, meets, when, ref, config, datatype, composedof
```

## Syntax Structure
```
use configset <ConfigSetName>
use featureset <FeatureSetName>
use functionset <FunctionSetName>
use interfaceset <InterfaceSetName>

hdef block <BlockName>
  name <string>
  description """multiline"""
  designrationale """multiline"""
  comment """multiline"""
  owner <string>
  level <enum>
  safetylevel <ASIL/SIL>
  tags <comma-separated>
  
  // Input interfaces (NEEDS - at hdef level)
  needs ref operation <OperationName>, <OperationName>
  needs ref signal <SignalName>, <SignalName>
  
  // Block relationships (at hdef level)
  composedof ref block <BlockName>, <BlockName>
  enables ref feature <FeatureName>
  when ref config <ConfigName>

  // Output operations (def statements)
  def operation <OperationName>
    name <string>
    description """multiline"""
    designrationale """multiline"""
    owner <string>
    requires ref datatype <DataTypeName>
    tags <comma-separated>
    when ref config <ConfigName>
    
  // Output signals (def statements)
  def signal <SignalName>
    name <string>
    description """multiline"""
    owner <string>
    requires ref datatype <DataTypeName>
    safetylevel <ASIL/SIL>
    tags <comma-separated>
    
  // Parameters (def statements)
  def parameter <ParameterName>
    name <string>
    description <string>
    owner <string>
    tags <comma-separated>
    value <string>
```

## Complete Example

```sylang
use configset AutonomousVehicleConfig
use featureset AutonomousVehicleFeatures
use functionset PerceptionProcessingFunctions
use interfaceset PerceptionInterfaces

hdef block AdvancedPerceptionControlModule
  name "Advanced Perception Control Module"
  description """
    Comprehensive perception processing unit for Level 4 autonomous vehicle 
    environmental awareness. Handles multi-sensor data fusion, object detection, 
    tracking, prediction, and environmental model generation.
    """
  designrationale """
    Centralized perception architecture enables optimal sensor fusion and 
    reduces computational redundancy. Hardware-software co-design approach 
    ensures deterministic real-time performance for safety-critical operations.
    """
  comment """
    This module represents the core perception system for autonomous vehicles,
    implementing ISO 26262 ASIL-D requirements for functional safety.
    """
  owner "Advanced Perception Engineering Team"
  level module
  safetylevel ASIL-D
  tags "perception", "sensor-fusion", "AI-processing", "safety-critical"
  
  // Input interfaces (NEEDS - what this block requires)
  needs ref operation CameraRawData, LidarPointCloud, RadarTargets
  needs ref operation CalibrationParameters, SystemConfiguration
  needs ref signal SystemClockSignal, PowerSupplyStatus
  needs ref signal CalibrationStatus, SystemHeartbeat
  
  // Block relationships
  composedof ref block CameraProcessingSubmodule, LidarProcessingSubmodule
  composedof ref block FusionProcessingSubmodule, AIInferenceSubmodule
  enables ref feature PerceptionSystem, ObjectDetection
  when ref config c_CoreAutonomousFeatures_PerceptionSystem_L4

  // Output operations (PROVIDES - what this block offers)
  def operation EnvironmentalModel
    name "Comprehensive Environmental Model"
    description """
      Complete 360-degree environmental model containing all detected objects,
      free space, lane markings, traffic signs, and dynamic hazards with 
      confidence levels and timestamps.
      """
    designrationale """
      Unified environmental representation enables consistent decision-making
      across all autonomous driving functions and provides standardized 
      interface for planning systems.
      """
    owner "Perception Data Architecture Team"
    requires ref datatype EnvironmentalModelStruct
    tags "environmental-model", "object-detection", "real-time"
    when ref config c_CoreAutonomousFeatures_PerceptionSystem_L4
    
  def operation ObjectTrackingData
    name "Multi-Object Tracking Results"
    description """
      Tracked objects with unique IDs, position history, velocity vectors,
      acceleration, classification confidence, and predicted trajectories.
      """
    owner "Object Tracking Team"
    requires ref datatype ObjectTrackingStruct
    tags "object-tracking", "trajectory-prediction"
    
  def operation HazardDetection
    name "Safety-Critical Hazard Alerts"
    description """
      Immediate hazard detection results including collision risks, 
      emergency vehicles, construction zones, and other safety-critical 
      environmental conditions.
      """
    owner "Safety Systems Team"
    requires ref datatype HazardDetectionStruct
    safetylevel ASIL-D
    tags "hazard-detection", "safety-critical"

  // Output signals (PROVIDES)
  def signal ProcessingHeartbeat
    name "Processing Cycle Heartbeat"
    description """
      High-frequency heartbeat signal indicating successful completion of
      each perception processing cycle with timing information.
      """
    owner "Real-time Systems Team"
    requires ref datatype uint32
    tags "heartbeat", "real-time", "monitoring"
    
  def signal SensorHealthStatus
    name "Multi-Sensor Health Monitoring"
    description """
      Aggregated health status of all perception sensors including 
      calibration drift, signal quality, and fault detection results.
      """
    owner "Sensor Integration Team"
    requires ref datatype SensorHealthEnum
    safetylevel ASIL-D
    tags "sensor-health", "fault-detection"
    
  // Parameters (configurable values)
  def parameter MaxDetectionRange
    name "Maximum Object Detection Range"
    description "Maximum distance in meters for object detection"
    owner "Perception Algorithm Team"
    tags "detection", "range", "configuration"
    value "150.0"
    
  def parameter ConfidenceThreshold
    name "Minimum Confidence Threshold"
    description "Minimum confidence level required for object detection (0.0-1.0)"
    owner "Perception Algorithm Team"
    tags "confidence", "threshold"
    value "0.85"
```

## Interface Patterns

### NEEDS (Inputs) - At hdef Level
```sylang
hdef block MyBlock
  // What this block needs from others
  needs ref operation InputOperation1, InputOperation2
  needs ref signal InputSignal1, InputSignal2, InputSignal3
```

### PROVIDES (Outputs) - Via def Statements
```sylang
  // What this block provides to others
  def operation OutputOperation
    description "Operation provided by this block"
    
  def signal OutputSignal
    description "Signal provided by this block"
```

## Block Relationships

### Composition (composedof)
```sylang
hdef block ParentModule
  composedof ref block ChildModule1, ChildModule2, ChildModule3
  # This block is composed of child blocks
```

### Decomposition (decomposesto/decomposesfrom)
```sylang
hdef block SystemBlock
  decomposesto ref block SubsystemBlock1, SubsystemBlock2
  # This block decomposes into subsystem blocks
```

### Feature Enablement
```sylang
hdef block VisionProcessingBlock
  enables ref feature CameraSystem, ObjectDetection
  # This block enables these features
```

## Level Hierarchy
```
level product          # Product level
level system           # System level
level subsystem        # Subsystem level
level component        # Component level
level subcomponent     # Subcomponent level
level module           # Module level
level submodule        # Submodule level
level part             # Part level
level subpart          # Subpart level
```

## Common Patterns

### ECU/Controller Block
```sylang
hdef block VehicleControllerECU
  level component
  safetylevel ASIL-D
  
  needs ref operation VehicleStateData
  needs ref signal SensorInputs
  
  composedof ref block ProcessorModule, MemoryModule, CommunicationModule
  
  def operation ControlCommands
    safetylevel ASIL-D
```

### Sensor Block
```sylang
hdef block RadarSensor
  level part
  safetylevel ASIL-C
  
  needs ref operation CalibrationData
  needs ref signal PowerSupply
  
  def signal RadarTargets
    safetylevel ASIL-C
    requires ref datatype RadarTargetList
```

### Processing Module
```sylang
hdef block SignalProcessingModule
  level module
  
  needs ref signal RawSensorData
  
  def operation ProcessedData
    requires ref datatype ProcessedDataStruct
```

## Validation Rules
✅ Exactly one `hdef block` per file  
✅ Multiple `def operation/signal/parameter` allowed  
✅ `needs` at hdef level for inputs  
✅ `def operation/signal` for outputs  
✅ Can use `when ref config` for conditional visibility  
✅ Multiline strings use `"""` triple quotes  
✅ Can reference datatypes via `requires ref datatype`  
❌ No `def port` (use `def operation` or `def signal`)  
❌ Input interfaces via `needs`, not `def`

---

**Next Steps**: Define functions in `.fun` files and requirements in `.req` files.

