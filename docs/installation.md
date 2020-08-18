## Installation  Guide 

Gettinng started with Metamorph (Standalone) <!-- omit in toc -->

## Contents <!-- omit in toc -->

<!-- Below is generated using VSCode yzhang.markdown-all-in-one >

<!-- TOC depthFrom:2 -->
- [Installation  Guide](#installation-guide)
- [Prerequisites](#prerequisites)
  - [Requirements](#requirements)
  - [Optional](#optional)
  - [Setting up Metmorph](#setting-up-metmorph)
- [Troubleshooting](#troubleshooting)
<!-- /TOC -->

## Prerequisites

### Requirements

- Linux 
- [kustomize]
- [Go]
- [Git]

### Optional
- [jq]

[go]: https://golang.org/dl/
[kustomize]: https://github.com/kubernetes-sigs/kustomize

### Setting up Metmorph 

  1. Download the latest and applicable version of Metamorph from using the following command 

   ```bash
   git clone https://github.com/bm-metamorph/MetaMorph.git
   ```

  2. Build the Metamorph executable 
     This should result in a `metamorph` executable build in the `<Metamorph directory>`

  ```bash
    cd <Metamorph directory>
    go build -o metamorph  main.go
  ``` 

  3. Ensure `config.yaml` is properly populated.

  4. Export environment variable `METAMORPH_CONFIGPATH` to match the location of `config.yaml`

  ```bash
  export METAMORPH_CONFIGPATH="<Location of config.yaml>"
  ```

  5. Run Metamorph controller using the following command  

  ```bash
  ./metamorph controller
  ```

  6. Check the logs to ensure controller has started and is working fine. 

  7. Open another seperate terminal and navigate to the `<Metamorph directory>`. Export the environmental variable `METAMORPH_CONFIGPATH` as specified above.
     Run the following command to start the Metamorph API server

  ```bash
  ./metamorph api 
  ```
  8. Check the logs to ensure API server  has started and is working fine. 

## Troubleshooting

Please refer to the [troubleshooting guide][troubleshooting].  
