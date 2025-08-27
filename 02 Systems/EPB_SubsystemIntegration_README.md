# EPB Subsystem Architecture Integration Guide

## Overview
This document describes the integration architecture for the Electric Parking Brake (EPB) subsystems, showing the interface relationships and data flow between the three main subsystems.

## Subsystem Hierarchy

```
EPB_ECU (Product Level)
├── EPB_InputProcessingSubsystem
├── EPB_ControlLogicSubsystem  
└── EPB_ActuatorOutputSubsystem
```

## Interface Mapping

### 1. External Inputs → Input Processing Subsystem

**From Vehicle Systems Interface:**
- `VehicleStateOutput` → `ProcessedVehicleState`
- `VehicleSpeedOutput` → `ProcessedVehicleSpeed`
- `SlopeAngleOutput` → `ProcessedSlopeAngle`
- `IgnitionStateOutput` → `ProcessedIgnitionState`
- `TransmissionStateOutput` → `ProcessedTransmissionState`

**From Driver Interface System:**
- `DriverEPBCommandOutput` → `ProcessedDriverCommand`
- `EPBSwitchPosition` → (processed within `ProcessedDriverCommand`)

**From Vehicle Network Interface:**
- `ActuatorFeedbackOutput` → `ProcessedActuatorFeedback`
- `ActuatorPositionOutput` → `ProcessedActuatorPosition`
- `ActuatorCurrentOutput` → `ProcessedActuatorCurrent`

### 2. Input Processing → Control Logic Subsystem

**Processed Inputs:**
- `ProcessedVehicleState` → Control algorithm input
- `ProcessedDriverCommand` → User intention interpretation
- `ProcessedActuatorFeedback` → Current state feedback
- `ProcessedVehicleSpeed` → Speed interlock logic
- `ProcessedSlopeAngle` → Adaptive force calculation
- `ProcessedIgnitionState` → Power state awareness
- `ProcessedTransmissionState` → Drivetrain integration
- `ProcessedActuatorPosition` → Position-based control
- `ProcessedActuatorCurrent` → Load monitoring

**Control Outputs:**
- `EPBControlCommand` → Unified control decisions
- `SafetyStatus` → System safety state
- `DiagnosticOutput` → Health monitoring
- `EPBEngagementCommand` → Engagement/release command
- `ForceTarget` → Desired holding force
- `SafetyInterlock` → Master safety enable
- `SystemHealth` → Overall system status
- `FaultStatus` → Active faults
- `ControlMode` → Current operation mode

### 3. Control Logic → Actuator Output Subsystem

**Control Commands:**
- `EPBControlCommand` → Motor control strategy
- `SafetyStatus` → Safety state monitoring
- `EPBEngagementCommand` → Engagement control
- `ForceTarget` → Force control loop
- `SafetyInterlock` → Safety cutoff

**Actuator Outputs:**
- `ActuatorControlOutput` → Motor drive commands
- `ActuatorDiagnosticOutput` → Actuator health data
- `MotorPWMCommand` → PWM control signal
- `MotorDirectionCommand` → Rotation direction
- `ActuatorEnable` → Power enable signal
- `ForceMonitor` → Force feedback
- `ActuatorPositionFeedback` → Position feedback
- `TemperatureMonitor` → Thermal monitoring
- `CurrentMonitor` → Current feedback
- `ActuatorFaultStatus` → Actuator-specific faults

## Subsystem Responsibilities

### EPB_InputProcessingSubsystem
- **Purpose:** Validate, condition, and process all external inputs
- **Key Functions:**
  - Signal validation and range checking
  - Noise filtering and debouncing
  - Sensor fusion for redundant signals
  - Input fault detection
  - Data format standardization

### EPB_ControlLogicSubsystem  
- **Purpose:** Implement core EPB control algorithms and safety logic
- **Key Functions:**
  - Engagement/release decision logic
  - Adaptive force control algorithms
  - Safety interlock evaluation
  - System mode management
  - Fault detection and response
  - Diagnostic data generation

### EPB_ActuatorOutputSubsystem
- **Purpose:** Control physical actuators and monitor performance
- **Key Functions:**
  - Motor PWM control
  - Position feedback control
  - Force control loop closure
  - Actuator safety monitoring
  - Thermal protection
  - Mechanical limit detection

## Safety Architecture Integration

### ASIL-D Safety Chain
1. **Input Processing:** Validates safety-critical inputs (vehicle speed, actuator position)
2. **Control Logic:** Implements safety interlocks and fail-safe logic
3. **Actuator Output:** Provides direct actuator safety cutoff capabilities

### Safety Interlocks
- **Speed Interlock:** Prevents engagement above threshold speed
- **Position Interlock:** Prevents over-travel and mechanical damage
- **Thermal Interlock:** Protects against overheating
- **Current Interlock:** Protects against overcurrent conditions
- **Master Safety Interlock:** Ultimate safety cutoff from control logic

## Interface Standards

### Message Interface Pattern
```
External Input → Processed Input → Control Decision → Actuator Command
```

### Signal Flow Pattern  
```
Raw Signal → Validated Signal → Control Signal → Output Signal
```

### Error Handling Pattern
```
Fault Detection → Fault Classification → Safety Response → Diagnostic Output
```

## Dependency Analysis

### Build Dependencies
1. `EPB_InputProcessingSubsystem` depends on external system blocks
2. `EPB_ControlLogicSubsystem` depends on `EPB_InputProcessingSubsystem`
3. `EPB_ActuatorOutputSubsystem` depends on `EPB_ControlLogicSubsystem`

### Runtime Dependencies  
- All subsystems share the `ElectricParkingBrakeFeatures` feature set
- Control Logic subsystem orchestrates overall system behavior
- Input Processing provides foundation data quality
- Actuator Output provides final safety barrier

## Integration Validation

### Interface Compatibility
✅ All message/signal interfaces properly defined
✅ No duplicate identifier conflicts between subsystems  
✅ Proper use statements for block dependencies
✅ Consistent safety level assignments (ASIL-D where required)

### Architecture Coherence
✅ Clear separation of concerns between subsystems
✅ Logical data flow from inputs to outputs
✅ Comprehensive safety interlock coverage
✅ Proper abstraction levels maintained

This subsystem architecture provides a robust, safety-compliant foundation for the EPB system implementation.
