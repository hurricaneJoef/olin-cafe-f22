# Learning from Professional Code

## ili94341 display controller

### Configuration FSM

There are 2 stored states: `cfg_state`, and `cfg_state_after_wait` (cfg_ omitted in explanation for lengthiness).

On reset the delay counter and ROM address are set to 0. `data_command_b`, which specifies between sending data and sending commands (1 for data, 0 for commands), is set to 1. Both `state` `state_after_wait` become `GET_DATA_SIZE`. In this next state the ROM address is increased by 1, `state_after_wait` becomes `GET_CMD` and `state` becomes `MEM_WAIT`. In the `MEM_WAIT` state `state` becomes `state_after_wait`. The state now transitions to the most recent state of `state_after_wait`, `GET_CMD`, where `state_after_wait` becomes `SEND_CMD` and `state` becomes `MEM_WAIT`. In `MEM_WAIT`, `state` is once again set to `state_after_wait`, which is now `SEND_CMD`. This elongated transition kills time since the memory has latency. Now in sending mode, for as long as the ROM data isn’t 0, `state_after_wait` becomes `GET_DATA` and `state` becomes `SPI_WAIT`. This SPI waiting state depends on the delay counter (which counts down to 0) or the SPI transaction wire `i_ready`. When either `i_ready` is true or the countdown ends, the counter is reset, `data_commandb` is set to 1 (data), and `state` becomes `state_after_wait`, triggering a transition to the `GET_DATA` state. Now the ROM address is iterated through in increments of 1, each time (with more delays built in) switching to the `SEND_DATA` state. When there are no more bytes of data remaining (with another state-change delay built in) the `DONE` state is triggered and the Main FSM starts.

### Main FSM

Once again there are two stored states: `state` and `state_after_wait`.

The first state of this FSM is set by the end of the previous FSM, beginning at `TX_PIXEL_DATA_START`. `data_comandb` is set to 0 (command) and after transitioning temporarily to the `WAIT_FOR_SPI` state to wait for `i_ready` to be true, the state is advanced to `TX_PIXEL_DATA_START` where `data_commandb` is set to 1 (data) and after another run through the waiting state `state` becomes `INCREMENT_PIXEL`. Now each pixel is incremented through column by column, row by row, with state-change delays (repeating the previous few state changes) between each pixel to make sure `i_ready` is true every time. When every pixel has been taken care of, `state` becomes `START_FRAME` where `data_commandb` is set to 0 (command), `state` is set to `WAIT_FOR_SPI` until `i_ready` is once again true, in which case the `START_FRAME` state begins the cycle anew.

## Ft6206 controller

### Main FSM

Once again there are two stored states: `state` and `state_after_wait`.

On reset the initial state is `INIT` where the state becomes `SET_THRESHOLD_REG`. Here `state_after_wait` becomes `SET_THRESHOLD_DATA` and `state` becomes `WAIT_FOR_I2C_WR` in which `state` becomes `state_after_wait` once `i_ready` is true. Once this is the case, `state` becomes `SET_THRESHOLD_DATA` where `state` becomes `IDLE` once waiting again for the I2C write. In the `IDLE` state, once `i_ready` and `ena` are true, the active register becomes `TD_STATUS` and the state transitions to `GET_REG_REG`. Now, after again waiting for I2C write, the state transitions to `GET_REG_DATA` which then takes a detour through `WAIT_FOR_I2C_RD` to make sure `i_ready` and `o_valid` are true before switching to `GET_REG_DONE`. In this state if `o_valid` is false it switches to `IDLE`. Otherwise the active register increments and some logic determines if there’s a touch, two touches, or no touches, otherwise it reads data from memory. When this process ends `state` becomes S_TOUCH_DONE` where some final touches are made like fixing the orientation. Once this is finished, `state` returns to `IDLE` and the process repeats.
