# Vehicle Restrictions - FiveM
Simple, modern and easy to configure Vehicle Restrictions

## Dependency:
[ox_lib](https://github.com/overextended/ox_lib/releases/tag/v3.27.0) - Download the latest **Release**

## Installation:

### Prerequisite:
- Download and install [ox_lib](https://github.com/overextended/ox_lib/releases/tag/v3.27.0) *(place `start ox_lib` near the top of your server.cfg)*

--------------------- 
  
1. **Download the Latest [Release](https://github.com/blaaaak/vehicle-restrictions/releases)**:
   - Head to the [releases tab](https://github.com/blaaaak/vehicle-restrictions/releases).
   - Click on the latest release and download `vehicle-restrictions.zip`.

2. **Add to Your Resources**:
   - Extract the contents of the zip file.
   - Drag the `vehicle-restrictions` folder into your FiveM resources directory.

3. **Configure the Script**:
   - Open the `config.lua` file inside the `config` folder.
   - The config contains the main settings to the script. Individual vehicle restrictions are in a seperate file.
     
   - To find the vehicle configuration open the `vehicles.lua` file inside of the `config` folder.
   - The vehicles configuration is fully documented on how to set up.

4. **Ensure the Resource**:
   - Add `start vehicle-restrictions` to your `server.cfg` *(or your respective cfg for ensuring resources)* file.
   - Above this ensure that `ox_lib` is started BEFORE `vehicle-restrictions`, otherwise the resource will not work.

6. **Restart Your Server**:
   - Restart your FiveM server to apply the changes.

 ### Enjoy

**For support, questions, or suggestions, join our [discord](https://discord.gg/chromalabs)**
