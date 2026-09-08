# Hyperbolic CORDIC — Pipelined RTL Implementation

A **pipelined Hyperbolic CORDIC (COordinate Rotation DIgital Computer)** implementation for **rotational and vectoring computations**, including **hyperbolic function and square-root computation**.

The design uses a **16-stage pipelined datapath architecture** based on fixed-point, shift-and-add arithmetic. **Hardwired bit selection is used in the datapath to realize the required power-of-two scaling without explicit shift operators**, providing a hardware-oriented implementation .

---

## Overview

CORDIC is a hardware-efficient algorithm for performing mathematical computations using **addition, subtraction, and power-of-two scaling** rather than conventional multiplication and division.

This project implements a **pipelined Hyperbolic CORDIC architecture** with dedicated datapath units. The design supports:

* Hyperbolic rotation
* Hyperbolic vectoring
* Hyperbolic function computation
* Square-root computation

Each CORDIC operation is mapped to a dedicated pipeline stage, enabling high-throughput hardware computation.

---

## Key Features

* Hyperbolic CORDIC algorithm
* **16-stage pipelined architecture**
* Rotational and vectoring modes
* Hyperbolic function computation
* Square-root computation
* Fixed-point arithmetic
* Shift-and-add based computation
* **Hardwired bit selection for power-of-two scaling**
* Avoids explicit shift operations in the datapath
* Dedicated CORDIC datapath modules
* Top-level module for pipeline integration
* No conventional multiplier or divider in the CORDIC datapath
* RTL simulation and functional verification
* **RTL synthesis**
* High-throughput architecture

---

# Architecture

The design consists of **16 cascaded pipelined datapath units**.

The physical pipeline implements CORDIC iterations from **1 to 14**, with **iterations 4 and 13 repeated twice** as required for hyperbolic CORDIC convergence.

```text
Input
  │
  ▼
┌──────┐   ┌──────┐   ┌──────┐   ┌──────┐   ┌──────┐
│ DP 1 │ → │ DP 2 │ → │ DP 3 │ → │ DP 4 │ → │ DP 4 │
└──────┘   └──────┘   └──────┘   └──────┘   └──────┘
                                                   │
                                                   ▼
                                             ┌──────┐
                                             │ DP 5 │
                                             └──┬───┘
                                                │
                                               ...
                                                │
                                                ▼
                                             ┌──────┐   ┌──────┐   ┌──────┐
                                             | DP13 │ → │ DP13 │ → │ DP14 │
                                             └──────┘   └──────┘   └──┬───┘
                                                                      │
                                                                      ▼
                                                                    Output
```

Each datapath stage performs its assigned CORDIC transformation and registers the resulting `X`, `Y`, and `Z` values before passing them to the next stage.

There is **no separate FSM or iteration counter**. The CORDIC iterations are realized spatially through the cascaded datapath modules.

---

## Datapath

Each CORDIC datapath module performs the required computation using:

* Fixed-point `X`, `Y`, and `Z` data
* Hardwired bit selection for power-of-two scaling
* Addition/subtraction
* CORDIC constants
* Pipeline registers

### Hardwired Scaling

Instead of using explicit Verilog shift operators for terms such as \(2^{-i}X\) or \(2^{-i}Y\), the required shifted bit positions are obtained through **hardware wiring/bit selection**.

This realizes the power-of-two scaling directly in the datapath and avoids additional shift logic.

Conceptually:

```text
              ┌─────────────────────────┐
 X_in ───────►│                         │──────► X_out
 Y_in ───────►│    CORDIC DATAPATH     │──────► Y_out
 Z_in ───────►│                         │──────► Z_out
              │                         │
              │ Hardwired Bit Selection │
              │ + Add/Subtract          │
              │ + CORDIC Constant       │
              └─────────────────────────┘
```

The output of each datapath is connected directly to the input of the following pipeline stage.

---

## Mathematical Foundation

The hyperbolic CORDIC transformation is given by:

$$
x_{i+1}=x_i+d_i(y_i2^{-i})
$$

$$
y_{i+1}=y_i+d_i(x_i2^{-i})
$$

$$
z_{i+1}=z_i-d_i\{atanh}(2^{-i})
$$

where \(d_i\) determines the direction of the CORDIC operation.

The terms \(x_i2^{-i}\) and \(y_i2^{-i}\) are realized using **hardwired bit selection**, while the remaining computation is performed using addition/subtraction and CORDIC constants.

---

## Operating Modes

### Rotation Mode

In rotation mode, the input vector is rotated through a specified hyperbolic angle.

This mode can be used for computing:

$$
\sinh(x),\qquad \cosh(x),\qquad \tanh(x)
$$

### Vectoring Mode

In vectoring mode, the input vector is iteratively transformed toward the y-axis.

The vectoring operation can also be configured for **square-root computation** using an appropriate CORDIC transformation.

---

## Pipelined Design

The architecture uses **16 registered datapath stages**, allowing multiple input samples to be processed simultaneously at different stages of the pipeline.

This provides:

* High throughput
* Pipeline-level parallelism
* Predictable latency
* Regular and modular datapath structure

Once the pipeline is filled, successive input samples can be processed through the pipeline at the operating clock rate.

---

## Fixed-Point Arithmetic

The design uses **fixed-point arithmetic** for efficient hardware implementation.

The numerical precision and supported range depend on the selected word length and fractional-bit representation.

> **Note:** Specify the exact fixed-point format used in the RTL, such as `Qm.n`.

---

# RTL Design

The RTL is organized into **individual CORDIC datapath modules** and a **top-level module**.

### Datapath Modules

Each datapath module implements its assigned CORDIC iteration using:

* Hardwired bit selection
* Addition/subtraction
* Fixed-point arithmetic
* CORDIC constants
* Pipeline registers

### Top Module

The top module connects the **16 datapath units** to form the complete pipelined Hyperbolic CORDIC architecture.

```text
Input
  │
  ▼
DP1 → DP2 → DP3 → DP4 → DP4 → DP5 → ... → DP13 → DP13 → DP14
                                                                  │
                                                                  ▼
                                                               Output
```

---

# Testbench

A dedicated RTL testbench is used to **verify the functional correctness** of the Hyperbolic CORDIC design, including rotation, vectoring, hyperbolic function, square-root, and pipelined operations.

---

# Simulation Results

Simulation waveforms demonstrate the propagation of `X`, `Y`, and `Z` values through the 16 pipeline stages and the resulting computed outputs.


# Synthesis

The design has been **synthesized for the Xilinx Artix-7 FPGA device `xc7a50tcpg236-1`**.

| Metric            | Description                        |
| ----------------- | ---------------------------------- |
| LUTs / Logic      | Combinational resource utilization |
| Flip-Flops        | Pipeline register utilization      |
| DSP Usage         | Dedicated DSP resources, if any    |
| Maximum Frequency | Achievable operating frequency     |
| Latency           | Pipeline latency                   |
| Throughput        | Output rate                        |

---

# Project Structure

```text
Hyperbolic-CORDIC/
│
├── Architecture/
│
├── RTL/
│   ├── datapath_1.v
│   ├── datapath_2.v
│   ├── datapath_3.v
│   ├── datapath_4.v
│   ├── ...
│   ├── datapath_14.v
│   └── top.v
│
├── Testbench/
│
├── Simulation_Results/
│
├── Synthesis/
│
└── README.md
```

---

## Tools & Technologies

* **HDL:** Verilog / SystemVerilog
* **Architecture:** 16-stage Pipelined RTL
* **Algorithm:** Hyperbolic CORDIC
* **Arithmetic:** Fixed-point, shift-and-add
* **Scaling:** Hardwired bit selection
* **Simulation:** RTL simulation
* **Synthesis:** Xilinx Vivado
* **Target Device:** Xilinx Artix-7 `xc7a50tcpg236-1`

---

# Future Improvements

* Improve numerical precision through optimized fixed-point representation
* Optimize pipeline latency and resource utilization
* Perform detailed FPGA timing and resource analysis
* Explore higher-throughput CORDIC architectures
* Compare pipelined and iterative implementations
* Explore ASIC/VLSI implementation and optimization
