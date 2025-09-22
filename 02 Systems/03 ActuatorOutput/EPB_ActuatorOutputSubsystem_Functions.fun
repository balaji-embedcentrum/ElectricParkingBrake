use featureset ElectricParkingBrakeFeatures

hdef functionset EPB_ActuatorOutputSubsystem_Functions
  name "EPB Actuator Output Subsystem Functions"
  description "Function definitions for actuator control, motor management, and force application within the EPB Actuator Output Subsystem"
  owner "Actuator Output Team"
  tags "actuator-control", "motor-management", "force-application", "ASIL-D"
  safetylevel ASIL-D
  level subsystem

  def function MotorControlImplementation
    name "Motor Control Implementation"
    description "Low-level motor control implementation including PWM generation, current control, and position control loops"
    owner "Motor Control Team"
    tags "motor-control", "PWM", "current-control", "position-control"
    enables ref feature BrakeEngagement
    safetylevel ASIL-D

  def function ForceCalculationImplementation
    name "Force Calculation Implementation"
    description "Calculates required brake force based on vehicle mass, slope angle, road surface, and environmental conditions"
    owner "Force Control Team"
    tags "force-calculation", "physics-model", "environmental-compensation"
    enables ref feature EngagementControl
    safetylevel ASIL-D

  def function PositionEstimationImplementation
    name "Position Estimation Implementation"
    description "Estimates actuator position using sensor fusion of multiple position sensors with fault detection"
    owner "Position Control Team"
    tags "position-estimation", "sensor-fusion", "fault-detection"
    enables ref feature PositionFeedback
    when ref config c_ComfortFeatures_AutomaticEngagement
    safetylevel ASIL-D

  def function ReleaseControlImplementation
    name "Release Control Implementation"
    description "Controls gradual force release with rollback prevention and smooth torque transition"
    owner "Release Control Team"
    tags "release-control", "rollback-prevention", "torque-transition"
    enables ref feature ControlledRelease
    safetylevel ASIL-D

  def function ForceMonitoringImplementation
    name "Force Monitoring Implementation"
    description "Continuously monitors actual brake force using multiple sensors and compensates for temperature drift and wear"
    owner "Force Monitoring Team"
    tags "force-monitoring", "temperature-compensation", "wear-compensation"
    enables ref feature HoldingForceMonitoring
    safetylevel ASIL-D

  def function SlopeEstimationImplementation
    name "Slope Estimation Implementation"
    description "Estimates vehicle slope using accelerometer, GPS, and vehicle dynamics to determine holding force requirements"
    owner "Slope Analysis Team"
    tags "slope-estimation", "accelerometer", "vehicle-dynamics"
    enables ref feature SlopeCompensation
    safetylevel ASIL-D

  def function MotorDiagnosticsImplementation
    name "Motor Diagnostics Implementation"
    description "Diagnoses motor health through current signature analysis, thermal monitoring, and mechanical wear detection"
    owner "Motor Diagnostics Team"
    tags "motor-diagnostics", "current-analysis", "thermal-monitoring"
    enables ref feature ActuatorDiagnostics
    safetylevel ASIL-D

  def function ThermalManagementImplementation
    name "Thermal Management Implementation"
    description "Manages thermal protection including motor temperature monitoring, duty cycle limiting, and thermal derating"
    owner "Thermal Management Team"
    tags "thermal-protection", "temperature-monitoring", "duty-cycle-limiting"
    enables ref feature SafetyFeatures
    safetylevel ASIL-D

  def function CalibrationManagementImplementation
    name "Calibration Management Implementation"
    description "Manages system calibration including actuator end-stop learning, force sensor calibration, and aging compensation"
    owner "Calibration Team"
    tags "calibration", "end-stop-learning", "aging-compensation"
    enables ref feature CoreEPBFeatures
    safetylevel ASIL-D