hdef specification EPB_SystemSpecification
  name "Electric Parking Brake System Specification"
  owner "Systems Engineering Team"
  version "1.0"

def section INTRO
  name "Introduction"
  description "Overview of the Electric Parking Brake system requirements and architecture"

def section REQUIREMENTS
  name "Functional Requirements"
  description "All functional requirements for the EPB system"
  
  def spec REQ_CONTENT
    name "EPB Functional Requirements"
    description "Detailed functional requirements"
    source "EPB_FunctionalRequirements.req"
    where status = approved
    orderby identifier asc
  
  def table REQ_TABLE
    name "Requirements Summary Table"
    description "Table view of all requirements"
    source "EPB_FunctionalRequirements.req"
    where reqtype = functional
    columns identifier, name, status, safetylevel

def section FEATURES
  name "Feature Model"
  description "Product feature model and variability"
  
  def diagram FEATURE_DIAGRAM
    name "EPB Feature Model Diagram"
    description "Visual representation of features and their relationships"
    source "EPB_FeatureModel.fml"

def section SEQUENCE_DIAGRAM
  name "Use Case Diagram"
  description "Use case diagram for the EPB system"

  def diagram SEQUENCE_DIAGRAM
    name "EPB Sequence Diagram"
    description "Visual representation of sequence interactions"
    source "../02 Systems/03 InputProcessing/EPB_InputProcessingSubsystem.seq"

def section USE_DIAGRAM
  name "Use Case Diagram"
  description "Use case diagram for the EPB system"

  def diagram UC_DIAGRAM
    name "EPB Sequence Diagram"
    description "Visual representation of sequence interactions"
    source "../02 Systems/03 InputProcessing/EPB_InputProcessingSubsystem.ucd"
