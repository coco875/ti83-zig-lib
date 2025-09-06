/// @returns True if the USB bus is powered by a host.
pub extern fn boot_USBBusPowered() bool;

/// @returns True if the USB bus is self-powered.
pub extern fn boot_USBSelfPowered() bool;

/// Resets the USB controller.
pub extern fn boot_USBResetChip() void;

/// Disables the USB Timers.
pub extern fn boot_USBDisableTimers() void;

/// Enables the USB Timers.
pub extern fn boot_USBEnableTimers() void;

/// Resets the USB Timers.
pub extern fn boot_USBResetTimers() void;

/// Gets some status after a control request.
/// @return Some status in the range [0, 3].
pub extern fn os_USBGetRequestStatus() i8;
