# ⏱ ZK-SNARK Hash Benchmarks 🏃🏽‍♂️

Benchmarks of the **Pedersen**, Poseidon, MiMC, and SHA256 hash functions in Circom circuits to help you weigh the trade offs of different ZK circuit hash algos.

 Test with different hash inputs in my [zkrepl](https://zkrepl.dev/?gist=233bd5f13fafc9638ca4bc81351f9aa0)!

## Installation
```bash
git clone https://github.com/colinnielsen/SNARK-hash-benchmark.git --recursive

# build: NOTE - this will download the powers of tau trusted setup
bash ./compile.sh
```

## Results


|              | Proof Size | Proover Time (M1 Macbook Air, 2020) | ETH Verification Gas Cost
| -------------| ---------- | ----------------------------------- |------------- 
| **Pedersen** | 4.2KB      | 2.123s                              | N/A (so inefficient implementation is infeasible)
| **Poseidon** | 112KB      | 3.124s                              | 50k-55k
| **MiMC**     | 203KB      | 2.617s                              | 55k-60k
| **SHA256**   | 19MB       | 64.492s                             | 30