# Third-party theorem statements

Lean Golf extracts formal Lean 4 statements from the pinned sources below. Each
imported theorem packet identifies its source file, license, and credit. The
packets rename theorem declarations for Lean Golf and replace proof bodies with a
placeholder. Where a statement requires a source-provided answer or supporting
definition, the packet includes that data as trusted statement context.

- **miniF2F** is the MIT-licensed Lean 4 port at `5746b7d6c478`. The port's
  copyright notice credits Meta Platforms, Inc. and affiliates. Its README also
  credits the original miniF2F benchmark. [Pinned source](https://github.com/yangky11/miniF2F-lean4/tree/5746b7d6c47855ce1294bed87329618ff7f1bc31) · [License](LICENSES/miniF2F-MIT.txt)
- **PutnamBench** is the Apache-2.0-licensed Lean 4 portion of PutnamBench at
  `a635813f5edf`, by George Tsoukalas, Jasper Lee, John Jennings, Jimmy Xin,
  Michelle Ding, Michael Jennings, Amitayush Thakur, and Swarat Chaudhuri.
  The formal statements were extracted and reformatted. Where the source gives
  a factored answer as a Lean comment, Lean Golf uses it in the statement
  context. [Pinned source](https://github.com/trishullab/PutnamBench/tree/a635813f5edf297d928f9bd5ef8324a26bdde09c/lean4) · [License](LICENSES/PutnamBench-Apache-2.0.txt)
- **Compfiles** is the Apache-2.0-licensed catalog by the Compfiles contributors
  at `a2b17da334d7`. The formal statements were extracted and reformatted.
  Per-file author and copyright notices are retained in the packet metadata
  where present. [Pinned source](https://github.com/dwrensha/compfiles/tree/a2b17da334d7dd125cc63d5fe557ab4c9dcc786a) · [License](LICENSES/Compfiles-Apache-2.0.txt)
- **ProofNet** uses Rahul Vishwakarma's MIT-licensed Lean 4 port at
  `6deae98b3895`, based on the original ProofNet dataset. [Pinned source](https://github.com/rahul3613/ProofNet-lean4/tree/6deae98b38954dadf732746d023e8be65c56f246) · [Original ProofNet](https://github.com/zhangir-azerbayev/ProofNet) · [License](LICENSES/ProofNet-MIT.txt)

These notices cover the imported Lean formalizations. Separate informal corpora
and benchmark proof submissions are outside this import.
