# README

## FIFO Verification Project

### Overview
This project implements and verifies a **16-depth, 8-bit wide FIFO (First-In-First-Out) buffer** using SystemVerilog. The verification includes directed, random, overflow, and underflow test cases, with error messages and pass/fail assertions.

---

## **FIFO Module**

### **Functionality**
- Implements a synchronous FIFO with **write** and **read** operations.
- Uses a **circular buffer** to store data.
- Tracks **full** and **empty** status flags.
- Handles **reset condition**, initializing all pointers and count values.

### **FIFO Ports**
| Signal  | Direction | Description |
|---------|----------|-------------|
| `clk`   | Input    | Clock signal |
| `rst`   | Input    | Reset signal |
| `wr_en` | Input    | Write enable |
| `rd_en` | Input    | Read enable |
| `data_in` | Input  | 8-bit input data |
| `data_out` | Output | 8-bit output data |
| `full` | Output | FIFO full flag |
| `empty` | Output | FIFO empty flag |

---

## **Testbench**

### **Testing Strategy**
1. **Directed Test Cases**
   - Writes **16 values** to the FIFO and reads them back.
   - Compares output against expected values and logs results.
   - Checks **empty condition after all reads**.

2. **Random Test Cases**
   - Writes random data into the FIFO and reads it back.
   - Uses assertions to check correctness.

3. **Overflow and Underflow Tests**
   - **Overflow:** Attempts to write **more than 16 entries** and checks `full` flag.
   - **Underflow:** Reads when FIFO is empty and verifies `empty` flag.

### **Pass/Fail Messages**
| Condition | Pass Message | Fail Message |
|-----------|-------------|--------------|
| Directed Test Case | `PASS Directed Test Cases: Expected: %0d, Got: %0d` | `FAIL: Mismatch Detected IN Directed Test Cases. Expected: %0d, Got: %0d` |
| Random Test Case | `PASS Random Testing: Expected: %0d, Got: %0d` | `FAIL: Mismatch Detected Random Testing. Expected: %0d, Got: %0d` |
| FIFO Full | `PASS Overflow and Underflow Tests: FIFO is full after 16 writes` | `FAIL Overflow and Underflow Tests: FIFO should be full` |
| FIFO Empty | `PASS: FIFO is empty after 16 reads` | `FAIL: FIFO should be empty` |

---

## **Expected Output**
- The FIFO should correctly store and retrieve data.
- **Error messages** appear if mismatches occur.
- **Final status checks** confirm FIFO is empty after reads.

