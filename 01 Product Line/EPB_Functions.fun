use featureset ElectricParkingBrakeFeatures
use functionset EPB_ActuatorOutputSubsystem_Functions
use functionset EPB_ControlLogicSubsystem_Functions
use functionset EPB_InputProcessingSubsystem_Functions


hdef functionset ElectricParkingBrakeFunctions
  name "Electric Parking Brake Function Set"
  description "Application-layer function definitions for Electric Parking Brake system with ASIL-D safety functions"
  owner "Systems Engineering Team"
  tags "EPB-functions", "ASIL-D", "brake-control", "safety-functions"
  safetylevel ASIL-D
  level system
  needs ref signal StateChangeRequest
  needs ref signal SafetyStatus
  needs ref signal SystemHealth
  offers ref operation SetSystemState
  offers ref operation ProcessStateTransition
  offers ref operation HandleFaultState

  def function EPB_SystemStateManager
    name "EPB System State Manager"
    description "Manages overall EPB system state machine including IDLE, ENGAGING, ENGAGED, DISENGAGING, FAULT states"
    owner "Systems Engineering Team"
    tags "state-machine", "system-control", "mode-management"
    enables ref feature CoreEPBFeatures
    when ref config c_ComfortFeatures_AutomaticEngagement
    decomposesto ref function VehicleStateValidator, VehicleSpeedProcessor
    safetylevel ASIL-D
    needs ref operation GetSystemState
    needs ref operation ValidateStateTransition
    needs ref operation CheckSafetyConditions
    needs ref signal StateChangeRequest
    needs ref signal SafetyStatus
    needs ref signal SystemHealth
    offers ref operation SetSystemState
    offers ref operation ProcessStateTransition
    offers ref operation HandleFaultState
    offers ref signal CurrentSystemState
    offers ref signal StateTransitionComplete
    offers ref signal FaultDetected

  def function EPB_RequestProcessor
    name "EPB Request Processor" 
    description "Processes and validates driver requests, automatic engagement/disengagement requests, and emergency commands"
    owner "Systems Engineering Team"
    tags "request-processing", "command-validation", "input-handling"
    enables ref feature CoreEPBFeatures
    decomposesto ref function RequestProcessingImplementation, SwitchDebouncingImplementation, CANReceptionImplementation
    safetylevel ASIL-D

  def function EPB_MotorController
    name "EPB Motor Controller"
    description "Low-level motor control including PWM generation, current control, and position control loops"
    owner "Systems Engineering Team"
    tags "motor-control", "PWM", "current-control", "position-control"
    enables ref feature BrakeEngagement
    decomposesto ref function MotorControlImplementation
    safetylevel ASIL-D

  def function EPB_ForceCalculator
    name "EPB Force Calculator"
    description "Calculates required brake force based on vehicle mass, slope angle, road surface, and environmental conditions"
    owner "Systems Engineering Team"
    tags "force-calculation", "physics-model", "environmental-compensation"
    enables ref feature EngagementControl
    decomposesto ref function ForceCalculationImplementation, SlopeEstimationImplementation, ForceMonitoringImplementation
    safetylevel ASIL-D

  def function EPB_PositionEstimator
    name "EPB Position Estimator"
    description "Estimates actuator position using sensor fusion of multiple position sensors with fault detection"
    owner "Systems Engineering Team"
    tags "position-estimation", "sensor-fusion", "fault-detection"
    enables ref feature PositionFeedback
    when ref config c_ComfortFeatures_AutomaticEngagement
    decomposesto ref function PositionEstimationImplementation, SensorDiagnosticsImplementation, MotorDiagnosticsImplementation
    safetylevel ASIL-D

  def function EPB_SafetyValidator
    name "EPB Safety Validator"
    description "Validates safety conditions for disengagement including driver presence, vehicle state, and system readiness"
    owner "Functional Safety Team"
    tags "safety-validation", "interlock-checking", "condition-monitoring"
    enables ref feature SafetyInterlocks
    decomposesto ref function SafetyValidationImplementation, ProcessorMonitoringImplementation, CommunicationMonitoringImplementation, SensorDiagnosticsImplementation
    safetylevel ASIL-D

  def function EPB_ReleaseController
    name "EPB Release Controller"
    description "Controls gradual force release with rollback prevention and smooth torque transition"
    owner "Systems Engineering Team"
    tags "release-control", "rollback-prevention", "torque-transition"
    enables ref feature ControlledRelease
    decomposesto ref function ReleaseControlImplementation, MotorControlImplementation, ForceMonitoringImplementation, SafetyValidationImplementation
    safetylevel ASIL-D

  def function EPB_ForceMonitor
    name "EPB Force Monitor"
    description "Continuously monitors actual brake force using multiple sensors and compensates for temperature drift and wear"
    owner "Systems Engineering Team"
    tags "force-monitoring", "temperature-compensation", "wear-compensation"
    enables ref feature HoldingForceMonitoring
    decomposesto ref function ForceMonitoringImplementation, SensorDiagnosticsImplementation, ThermalManagementImplementation, MotorDiagnosticsImplementation
    safetylevel ASIL-D

  def function EPB_SlopeEstimator
    name "EPB Slope Estimator"
    description "Estimates vehicle slope using accelerometer, GPS, and vehicle dynamics to determine holding force requirements"
    owner "Systems Engineering Team"
    tags "slope-estimation", "accelerometer", "vehicle-dynamics"
    enables ref feature SlopeCompensation
    decomposesto ref function SlopeEstimationImplementation, SensorDiagnosticsImplementation, CANReceptionImplementation
    safetylevel ASIL-D

  def function EPB_MotorDiagnostics
    name "EPB Motor Diagnostics"
    description "Diagnoses motor health through current signature analysis, thermal monitoring, and mechanical wear detection"
    owner "Functional Safety Team"
    tags "motor-diagnostics", "current-analysis", "thermal-monitoring"
    enables ref feature ActuatorDiagnostics
    decomposesto ref function MotorDiagnosticsImplementation, ThermalManagementImplementation, ProcessorMonitoringImplementation, CANTransmissionImplementation
    safetylevel ASIL-D

  def function EPB_SensorDiagnostics
    name "EPB Sensor Diagnostics"
    description "Validates position sensors, force sensors, and temperature sensors using cross-checks and plausibility analysis"
    owner "Functional Safety Team"
    tags "sensor-diagnostics", "cross-validation", "plausibility-analysis"
    enables ref feature ActuatorDiagnostics
    decomposesto ref function SensorDiagnosticsImplementation, ProcessorMonitoringImplementation, CANTransmissionImplementation, IndicatorControlImplementation
    safetylevel ASIL-D

  def function EPB_ProcessorMonitor
    name "EPB Processor Monitor"
    description "Monitors ECU health including CPU load, memory integrity, watchdog functions, and stack overflow detection"
    owner "Functional Safety Team"
    tags "processor-monitoring", "watchdog", "memory-integrity"
    enables ref feature ECUDiagnostics
    decomposesto ref function ProcessorMonitoringImplementation
    decomposesto ref function CommunicationMonitoringImplementation
    decomposesto ref function CANTransmissionImplementation
    decomposesto ref function IndicatorControlImplementation
    safetylevel ASIL-D

  def function EPB_CommunicationMonitor
    name "EPB Communication Monitor"
    description "Monitors CAN bus health, operation timing, checksum validation, and communication fault detection"
    owner "Functional Safety Team"
    tags "communication-monitoring", "CAN-health", "operation-validation"
    enables ref feature ECUDiagnostics
    decomposesto ref function CommunicationMonitoringImplementation
    decomposesto ref function CANTransmissionImplementation
    decomposesto ref function CANReceptionImplementation
    decomposesto ref function IndicatorControlImplementation
    safetylevel ASIL-D

  def function EPB_EmergencyBrakeController
    name "EPB Emergency Brake Controller"
    description "Executes emergency brake engagement bypassing normal control path when system failures are detected"
    owner "Functional Safety Team"
    tags "emergency-control", "fail-safe", "bypass-control"
    enables ref feature EmergencyEngagement
    decomposesto ref function EmergencyBrakeControlImplementation
    safetylevel ASIL-D

  def function EPB_FailureManager
    name "EPB Failure Manager"
    description "Manages system behavior under component failures, implements degraded modes, and maintains safety functions"
    owner "Functional Safety Team"
    tags "failure-management", "degraded-modes", "safety-maintenance"
    enables ref feature FailSafeModes
    decomposesto ref function FailureManagementImplementation
    safetylevel ASIL-D

  def function EPB_CANTransmitter
    name "EPB CAN Transmitter"
    description "Formats and transmits EPB status, diagnostic data, and fault information over vehicle CAN network"
    owner "Systems Engineering Team"
    tags "CAN-transmission", "operation-formatting", "status-reporting"
    enables ref feature CANInterface
    decomposesto ref function CANTransmissionImplementation
    safetylevel ASIL-D

  def function EPB_CANReceiver
    name "EPB CAN Receiver"
    description "Receives and validates vehicle state information, driver commands, and configuration data from CAN network"
    owner "Systems Engineering Team"
    tags "CAN-reception", "operation-validation", "data-parsing"
    enables ref feature CANInterface
    decomposesto ref function CANReceptionImplementation
    safetylevel ASIL-D

  def function EPB_SwitchDebouncer
    name "EPB Switch Debouncer"
    description "Debounces driver switch inputs and detects short press, long press, and multi-press patterns"
    owner "Systems Engineering Team"
    tags "switch-debouncing", "pattern-detection", "input-filtering"
    enables ref feature SwitchInterface
    decomposesto ref function SwitchDebouncingImplementation
    safetylevel ASIL-D

  def function EPB_IndicatorController
    name "EPB Indicator Controller"
    description "Controls dashboard indicators, warning lights, and audio feedback based on EPB system state and faults"
    owner "Systems Engineering Team"
    tags "indicator-control", "warning-lights", "audio-feedback"
    enables ref feature StatusIndicators
    decomposesto ref function IndicatorControlImplementation
    safetylevel ASIL-D

  def function EPB_AutoEngageLogic
    name "EPB Auto Engage Logic"
    description "Implements automatic engagement logic based on ignition state, vehicle speed, transmission position, and timer delays"
    owner "Systems Engineering Team"
    tags "auto-engagement", "logic-processing", "timer-management"
    enables ref feature AutomaticEngagement
    decomposesto ref function AutoEngageLogicImplementation
    safetylevel QM

  def function EPB_AutoDisengageLogic
    name "EPB Auto Disengage Logic"
    description "Implements automatic disengagement logic based on driver readiness, accelerator input, and driving conditions"
    owner "Systems Engineering Team"
    tags "auto-disengagement", "driver-readiness", "condition-analysis"
    enables ref feature AutomaticDisengagement
    decomposesto ref function AutoDisengageLogicImplementation
    safetylevel QM

  def function EPB_HillHoldTimer
    name "EPB Hill Hold Timer"
    description "Manages hill hold assist timing, transition delays, and automatic release conditions on slopes"
    owner "Systems Engineering Team"
    tags "hill-hold", "timer-management", "transition-control"
    enables ref feature HillHoldAssist
    decomposesto ref function HillHoldTimerImplementation
    safetylevel ASIL-B

  def function EPB_CalibrationManager
    name "EPB Calibration Manager"
    description "Manages system calibration including actuator end-stop learning, force sensor calibration, and aging compensation"
    owner "Systems Engineering Team"
    tags "calibration", "end-stop-learning", "aging-compensation"
    enables ref feature CoreEPBFeatures
    decomposesto ref function CalibrationManagementImplementation
    safetylevel ASIL-D

  def function EPB_ThermalManager
    name "EPB Thermal Manager"
    description "Manages thermal protection including motor temperature monitoring, duty cycle limiting, and thermal derating"
    owner "Systems Engineering Team"
    tags "thermal-protection", "temperature-monitoring", "duty-cycle-limiting"
    enables ref feature SafetyFeatures
    decomposesto ref function ThermalManagementImplementation
    safetylevel ASIL-D
