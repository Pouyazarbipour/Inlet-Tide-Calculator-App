# Inlet Tide Calculator App

## Overview
The **Inlet Tide Calculator** is a MATLAB-based graphical user interface (GUI) designed to simulate the tidal dynamics of a lagoon or bay connected to the ocean through an inlet. The app calculates the bay's tide response, considering factors such as inlet geometry, energy losses, and tidal propagation time. It uses **Keulegan's method** and the **Runge-Kutta 4th order integration** to solve for the tidal dynamics and visualize the results.

### Key Features:
- **Tidal Wave Calculation**: Computes the tidal response in a bay, considering inlet geometry and energy losses.
- **Graphical User Interface**: Interactive GUI to input parameters and view results.
- **Visualization**: Plots both ocean and bay tides with corresponding phase lag.
- **Results Display**: Displays the repletion coefficient (K), phase lag (in degrees), and response ratio of the bay tide to the ocean tide.

## Methodology
The app uses **Keulegan's equation** to model the relationship between ocean tides and bay tides. The main factors influencing the bay tide include:
- **Inlet geometry**: Depth, width, and length of the inlet.
- **Bay planform area**: The area of the bay.
- **Energy losses**: Entrance loss, exit loss, and frictional losses.

The **repletion coefficient (K)** is a dimensionless number that governs the relationship between the ocean and bay tides. The app numerically solves the nonlinear equations using a **Runge-Kutta 4th order method** over three tidal cycles to reach steady-state results.

## Getting Started

### Prerequisites
To use this application, you need to have MATLAB installed. The app is compatible with MATLAB 2020a or later.

### Installation
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/inlet-tide-calculator.git
