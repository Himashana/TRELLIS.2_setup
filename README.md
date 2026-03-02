# TRELLIS.2_setup

You can use this script to simplify the Microsoft TRELLIS.2 installation process in Runpod GPU cloud.

You might need to perform manual inputs and accept licence agreements throughout the process. Therefore, read the instructions carefully and proceed accordingly. It is a requirement to have access to `dinov3-vitl16-pretrain-lvd1689m` and `RMBG-2.0` at HuggingFace, and you will be asked to enter the HuggingFace Access Token during the setup. Also, ensure that you are running the script in interactive mode with `bash -i setup.sh`

Reference: https://github.com/microsoft/TRELLIS.2

## Step 1

Download the setup script

```
wget https://raw.githubusercontent.com/Himashana/TRELLIS.2_setup/refs/heads/main/setup.sh
```

## Step 2: Execute the script in interactive mode

```
bash -i setup.sh
```
