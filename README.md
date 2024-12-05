# Inlet Tide Calculator App

## Overview
The **Inlet Tide Calculator** is a MATLAB-based graphical user interface (GUI) designed to simulate the tidal dynamics of a lagoon or bay connected to the ocean through an inlet. The app calculates the bay's tide response, considering factors such as inlet geometry, energy losses, and tidal propagation time. It uses **Keulegan's method** and the **Runge-Kutta 4th order integration** to solve for the tidal dynamics and visualize the results.

---

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

---

## Getting Started

### Prerequisites
To use this application, you need to have MATLAB installed. The app is compatible with MATLAB 2017a or later.

### Installation
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/pouyazarbipour/Inlet-Tide-Calculator-App.git

2. Open the repository folder in MATLAB.

3. Run the InletApp.m script to start the GUI:

---

## Input Fields
Enter the following parameters in the input fields:

- **Inlet Depth (m):** Depth of the inlet.
- **Inlet Width (m):** Width of the inlet.
- **Inlet Length (m):** Length of the inlet.
- **Bay Planform Area (km²):** Area of the bay in square kilometers.
- **Ocean Tide Amplitude (m):** Amplitude of the ocean tide.

---

## Buttons
- **Calculate:** Calculates the bay tide based on the input values and displays the results.
- **Reset:** Resets all input fields to their default values.
- **Graph:** The ocean tide and bay tide are plotted over time. The bay tide is smaller and lags behind the ocean tide, as expected from the model.

---

## Output After Calculation
After pressing **Calculate**, the app will display:

1. **Repletion Coefficient (K):** Represents the degree of restriction and coupling between the ocean and bay tides.
2. **Phase Lag (in degrees):** Shows how much the bay tide lags behind the ocean tide.
3. **Response Ratio:** The ratio of the bay tide to the ocean tide amplitude.

---

## Example
Set the following values in the input fields:
- **Inlet Depth:** 5.0 m
- **Inlet Width:** 150.0 m
- **Inlet Length:** 1200.0 m
- **Bay Planform Area:** 60.0 km²
- **Ocean Tide Amplitude:** 1.5 m

Press **Calculate** to obtain the bay tide simulation. The app will plot the ocean and bay tides and display the results.

---

## Results Interpretation
- The **bay tide** is smaller and lags behind the ocean tide.
- The **Repletion Coefficient (K)** represents the degree of restriction and coupling between the ocean and bay tides.
- The **Phase Lag (in degrees)** shows how much the bay tide lags the ocean tide.
- The **Response Ratio** indicates the proportion of the ocean tide amplitude that is observed in the bay.

---

## License  
This project is licensed under the MIT License. See the `LICENSE` file for details.  

---

## Contact  
For questions or feedback, please reach out to pouyazarbipour@gmail.com.
