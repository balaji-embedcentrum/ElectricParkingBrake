# Requirement Definition (.req)

## Overview
Defines **system requirements** with complete traceability to functions, blocks, and tests. Supports hierarchical requirement refinement.

## File Structure
- **ONE** `hdef requirementset` per file
- **MULTIPLE** `def requirement` statements (hierarchical)
- Can `use` functionsets, configsets, parameters

## Valid Keywords
```
use, hdef, requirementset, def, requirement, name, description, owner, 
tags, level, rationale, verificationcriteria, status, reqtype, safetylevel, 
refinedfrom, derivedfrom, implements, allocatedto, when, ref, config
```

## Example
```sylang
use functionset AutonomousPerceptionFunctions
use configset AutonomousVehicleConfig
use parameter MaxDetectionRange, ConfidenceThreshold

hdef requirementset AutonomousPerceptionRequirements
  name "Autonomous Vehicle Perception System Requirements"
  description "Safety and functional requirements for perception system"
  owner "Perception Safety Engineering Team"
  safetylevel ASIL-D

  def requirement REQ_PERC_001
    name "Environmental Detection Performance"
    description """
      WHEN the perception system is active THE system SHALL detect 
      stationary objects ≥20cm at distances up to 200m with ≥99.9% accuracy.
      """
    rationale """
      Ensures reliable object detection for collision avoidance. Critical
      for ASIL-D compliance and passenger safety in Level 3 autonomous operation.
      """
    verificationcriteria """
      Statistical testing with calibrated test objects at various distances.
      Minimum 10,000 test cases across different environmental scenarios.
      """
    status approved
    reqtype functional
    safetylevel ASIL-D
    implements ref function ObjectClassification

    def requirement REQ_PERC_001_1
      name "Object Classification Accuracy"
      description "THE system SHALL classify detected objects with ≥95% accuracy within 100ms"
      rationale "Accurate classification enables appropriate collision avoidance responses"
      verificationcriteria "ML model validation with annotated test datasets"
      status approved
      reqtype functional
      safetylevel ASIL-D
      refinedfrom ref requirement REQ_PERC_001
      implements ref function ObjectClassification

  def requirement REQ_PERC_002
    name "Sensor Fusion Latency"
    description "Fusion algorithm SHALL output environmental model within 50ms"
    status approved
    reqtype performance
    safetylevel ASIL-D
    implements ref function SensorFusion
```

## Requirement Types
```
reqtype functional      # Functional requirement
reqtype non-functional  # Non-functional requirement
reqtype system          # System requirement
reqtype software        # Software requirement
reqtype hardware        # Hardware requirement
reqtype interface       # Interface requirement
reqtype safety          # Safety requirement
```

## Status Values
```
status draft       # Draft status
status review      # Under review
status approved    # Approved
status deprecated  # Deprecated
status implemented # Implemented
```

## Traceability
- `refinedfrom ref requirement` - Refinement relationship
- `derivedfrom ref requirement` - Derivation relationship
- `implements ref function` - Implementation link
- `allocatedto ref block` - Allocation to architecture
- `when ref config` - Conditional visibility

---
See `.tst` for test cases that satisfy requirements.

