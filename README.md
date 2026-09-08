# NTI-Verilog-Projects
Digital Design and Verilog HDL projects completed during the training program at the National Telecommunication Institute (NTI), Egypt. Includes RTL design, testbenches, and simulation for various digital systems.

## 1. 2-Bit Full Adder
* **Description:** Designed and simulated a 2-bit full adder logic circuit in Verilog using Gate-Level, Structural, and Behavioral modeling.

* **Simulation Waveform:**
  ![2-Bit Full Adder Waveform](2bit_full_adder/waveform.png)

* **Simulation Transcript:**
```text
Time=0  | a=00 b=00 cin=0 | GL: s=00 cout=0 | ST: s=00 cout=0 | BH: s=00 cout=0
Time=10 | a=00 b=01 cin=0 | GL: s=01 cout=0 | ST: s=01 cout=0 | BH: s=01 cout=0
Time=20 | a=01 b=01 cin=0 | GL: s=10 cout=0 | ST: s=10 cout=0 | BH: s=10 cout=0
Time=30 | a=01 b=10 cin=0 | GL: s=11 cout=0 | ST: s=11 cout=0 | BH: s=11 cout=0
Time=40 | a=10 b=10 cin=0 | GL: s=00 cout=1 | ST: s=00 cout=1 | BH: s=00 cout=1
Time=50 | a=11 b=01 cin=0 | GL: s=00 cout=1 | ST: s=00 cout=1 | BH: s=00 cout=1
Time=60 | a=11 b=11 cin=0 | GL: s=10 cout=1 | ST: s=10 cout=1 | BH: s=10 cout=1
Time=70 | a=11 b=11 cin=1 | GL: s=11 cout=1 | ST: s=11 cout=1 | BH: s=11 cout=1
