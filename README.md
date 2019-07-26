# BinaryWard.ContextDSC

## Context Desired State Configuration (ContextDSC)

Influenced from the Microsoft Desired State Configuration (DSC) a project to define many desired configuration states which upon a context change one of the desired state configurations is applied.  For example a laptop being able to adapt network settings based upon the different networks it may connect.  Enter a secure network state for specific or unknown networks or enter a more open configuration state for known trusted networks.

A context desired configuration state must be reactive and apply the configuration state when the context changes.  A context change is best handled like an event but could be a polled. 

The project is to explore how a desired configuration state may enhance security and work for computers not in static environents.  For example a laptop switching between a trusted and untrusted network should be able to enter an expected desired configuration state.  The laptop is taken into different environments.  The desired configuration state should adapt to the environment the laptop is in.

The supported desired state configuration resources supported at this time.

* Set network adapter binding settings
* Set the network connection profile network category

### Context: On Network Connection

BinaryWard.ContextDSC is able to change network adapter binding settings and the network connection profile network category when network connection changes are detected.

Upon the network event the user defined configuration may use network name or interface alias.

### Windows Desired State Configuration (DSC)

BinaryWard-ContextDSC does not utilize the Windows DSC management platform and is not able to use DSC configurations or use existing DSC Resources.  The supported resources are adapted to fit within this project.
If a method to utilize Windows DSC management platform would improve the resources available.  This is under research.
