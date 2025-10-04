# Sequence Diagram (.seq)

## Overview
Defines **message flow sequences** between blocks with operation/signal flows. Supports fragments for alternative and parallel flows.

## File Structure
- **ONE** `hdef sequenceset` per file
- **MULTIPLE** `def sequence` and `def fragment` statements
- Uses `from/to` refs to blocks and `flow` refs to operations/signals

## Valid Keywords
```
use, hdef, sequenceset, def, sequence, fragment, name, description, 
owner, tags, level, safetylevel, from, to, flow, fragmenttype, 
condition, when, ref, block, operation, signal
```

## Fragment Types
```
fragmenttype alt      # Alternative flow
fragmenttype else     # Else branch
fragmenttype parallel # Parallel execution
fragmenttype loop     # Loop iteration
```

## Example
```sylang
use block PerceptionControlModule
use block PlanningControlModule
use block VehicleControlModule
use operation EnvironmentModelUpdate
use operation PathPlanningRequest
use signal EmergencyStopSignal

hdef sequenceset AutonomousEmergencyBraking
  name "Autonomous Emergency Braking Sequence"
  description "Message flow sequence for emergency braking scenario"
  owner "Safety Systems Integration Team"
  safetylevel ASIL-D
  tags "emergency-braking", "sequence", "safety-critical", "AEB"
  
  // Main emergency braking sequence
  def sequence SEQ_001
    from ref block PerceptionControlModule
    to ref block PlanningControlModule
    flow ref operation EnvironmentModelUpdate
    
  def sequence SEQ_002
    from ref block PlanningControlModule
    to ref block VehicleControlModule
    flow ref operation PathPlanningRequest
    
  def sequence SEQ_003
    from ref block VehicleControlModule
    to ref block BrakeControlModule
    flow ref signal EmergencyStopSignal
    
  def sequence SEQ_004
    from ref block BrakeControlModule
    to ref block PerceptionControlModule
    flow ref signal BrakeEngagementConfirmation
    
  // Error handling fragment
  def fragment CommunicationFailure
    fragmenttype alt
    condition "Communication timeout > 100ms"
    
    def sequence SEQ_005
      from ref block VehicleControlModule
      to ref block FallbackControlModule
      flow ref signal SystemFailureAlert
      
  // Parallel status reporting fragment  
  def fragment StatusReporting
    fragmenttype parallel
    condition "All modules must report status concurrently"
    
    def sequence SEQ_006
      from ref block PerceptionControlModule
      to ref block SystemHealthMonitor
      flow ref signal PerceptionSystemStatus
      
    def sequence SEQ_007
      from ref block PlanningControlModule
      to ref block SystemHealthMonitor
      flow ref signal PlanningSystemStatus
```

---
See `.blk` for block and operation/signal definitions.

