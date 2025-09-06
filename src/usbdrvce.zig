const std = @import("std");
const int24 = @import("int24.zig");
const FlexibleArrayType = @import("std").zig.c_translation.FlexibleArrayType;

inline fn USB_INIT_FLSZ(x: anytype) @TypeOf((x & 3) << 2) {
    _ = &x;
    return (x & 3) << 2;
}

pub inline fn USB_INIT_ASST(x: anytype) @TypeOf((x & 3) << 8) {
    _ = &x;
    return (x & 3) << 8;
}
pub inline fn USB_INIT_EOF1(x: anytype) @TypeOf((x & 3) << 10) {
    _ = &x;
    return (x & 3) << 10;
}
pub inline fn USB_INIT_EOF2(x: anytype) @TypeOf((x & 3) << 12) {
    _ = &x;
    return (x & 3) << 12;
}

const usb_init_flags = enum(c_int) {
    /// Use part of the default C heap.
    /// @warning Do not use this unless you
    /// changed your program's bss/heap to end
    /// at 0xD10000!
    USB_USE_C_HEAP = 1 << 0,
    /// Use the application heap area.
    USB_USE_OS_HEAP = 1 << 1,
    /// Init Frame List Size to 1024.
    USB_INIT_FLSZ_1024 = USB_INIT_FLSZ(0),
    /// Init Frame List Size to  512.
    USB_INIT_FLSZ_512 = USB_INIT_FLSZ(1),
    /// Init Frame List Size to  256.
    USB_INIT_FLSZ_256 = USB_INIT_FLSZ(2),
    /// Disable Frame List.
    /// @warning This also disables
    /// support for periodic transfers
    /// and hubs!
    USB_INIT_FLSZ_0 = USB_INIT_FLSZ(3),
    /// Init Async Sched Sleep Timer to 0.
    USB_INIT_ASST_0 = USB_INIT_ASST(0),
    /// Init Async Sched Sleep Timer to 1.
    USB_INIT_ASST_1 = USB_INIT_ASST(1),
    /// Init Async Sched Sleep Timer to 2.
    USB_INIT_ASST_2 = USB_INIT_ASST(2),
    /// Init Async Sched Sleep Timer to 3.
    USB_INIT_ASST_3 = USB_INIT_ASST(3),
    /// Init EOF 1 Timing to 0.
    USB_INIT_EOF1_0 = USB_INIT_EOF1(0),
    /// Init EOF 1 Timing to 1.
    USB_INIT_EOF1_1 = USB_INIT_EOF1(1),
    /// Init EOF 1 Timing to 2.
    USB_INIT_EOF1_2 = USB_INIT_EOF1(2),
    /// Init EOF 1 Timing to 3.
    USB_INIT_EOF1_3 = USB_INIT_EOF1(3),
    /// Init EOF 2 Timing to 0.
    USB_INIT_EOF2_0 = USB_INIT_EOF2(0),
    /// Init EOF 2 Timing to 1.
    USB_INIT_EOF2_1 = USB_INIT_EOF2(1),
    /// Init EOF 2 Timing to 2.
    USB_INIT_EOF2_2 = USB_INIT_EOF2(2),
    /// Init EOF 2 Timing to 3.
    USB_INIT_EOF2_3 = USB_INIT_EOF2(3),
    USB_INIT_UNKNOWN = 1 << 15,
    USB_DEFAULT_INIT_FLAGS = .USB_USE_OS_HEAP | .USB_INIT_FLSZ_256 | .USB_INIT_ASST_1 | .USB_INIT_EOF1_3 | .USB_INIT_EOF2_0 | .USB_INIT_UNKNOWN,
};

const usb_event = enum(c_int) {
    /// event_data Pointer to the new usb_role_t state.
    USB_ROLE_CHANGED_EVENT,
    /// event_data The usb_device_t that was disconnected.
    USB_DEVICE_DISCONNECTED_EVENT,
    /// event_data The usb_device_t that was connected.
    USB_DEVICE_CONNECTED_EVENT,
    /// event_data The usb_device_t that was disabled.
    USB_DEVICE_DISABLED_EVENT,
    /// event_data The usb_device_t that was enabled.
    USB_DEVICE_ENABLED_EVENT,
    /// event_data The usb_device_t for the hub that stopped using bus power.
    USB_HUB_LOCAL_POWER_GOOD_EVENT,
    /// event_data The usb_device_t for the hub that started using bus power.
    USB_HUB_LOCAL_POWER_LOST_EVENT,
    /// event_data The usb_device_t that was resumed.
    USB_DEVICE_RESUMED_EVENT,
    /// event_data The usb_device_t that was suspended.
    USB_DEVICE_SUSPENDED_EVENT,
    /// event_data The usb_device_t that deactivated overcurrent condition.
    USB_DEVICE_OVERCURRENT_DEACTIVATED_EVENT,
    /// event_data The usb_device_t that activated overcurrent condition.
    USB_DEVICE_OVERCURRENT_ACTIVATED_EVENT,
    /// This event triggers when a host sends a control setup packet.  Return
    /// USB_IGNORE if you scheduled a response manually.  Return USB_SUCCESS
    /// to have standard requests handled automatically (You can modify the setup
    /// first, but that probably isn't useful).
    /// event_data The usb_control_setup_t/// that was sent by the host.
    USB_DEFAULT_SETUP_EVENT,
    /// This event triggers when the calculator is configured by a host.
    /// event_data The const usb_configuration_descriptor_t/// that was selected
    /// by the host.
    USB_HOST_CONFIGURE_EVENT,
    // Temp debug events:
    USB_DEVICE_INTERRUPT,
    USB_DEVICE_CONTROL_INTERRUPT,
    USB_DEVICE_DEVICE_INTERRUPT,
    USB_OTG_INTERRUPT,
    USB_HOST_INTERRUPT,
    USB_CONTROL_ERROR_INTERRUPT,
    USB_CONTROL_ABORT_INTERRUPT,
    USB_FIFO0_SHORT_PACKET_INTERRUPT,
    USB_FIFO1_SHORT_PACKET_INTERRUPT,
    USB_FIFO2_SHORT_PACKET_INTERRUPT,
    USB_FIFO3_SHORT_PACKET_INTERRUPT,
    USB_DEVICE_ISOCHRONOUS_ERROR_INTERRUPT,
    USB_DEVICE_ISOCHRONOUS_ABORT_INTERRUPT,
    USB_DEVICE_DMA_FINISH_INTERRUPT,
    USB_DEVICE_DMA_ERROR_INTERRUPT,
    USB_DEVICE_IDLE_INTERRUPT,
    USB_DEVICE_WAKEUP_INTERRUPT,
    USB_B_SRP_COMPLETE_INTERRUPT,
    USB_A_SRP_DETECT_INTERRUPT,
    USB_A_VBUS_ERROR_INTERRUPT,
    USB_B_SESSION_END_INTERRUPT,
    USB_OVERCURRENT_INTERRUPT,
    USB_HOST_PORT_CONNECT_STATUS_CHANGE_INTERRUPT,
    USB_HOST_PORT_ENABLE_DISABLE_CHANGE_INTERRUPT,
    USB_HOST_PORT_OVERCURRENT_CHANGE_INTERRUPT,
    USB_HOST_PORT_FORCE_PORT_RESUME_INTERRUPT,
    USB_HOST_SYSTEM_ERROR_INTERRUPT,
};

const usb_error = enum(c_int) {
    USB_SUCCESS,
    USB_IGNORE,
    USB_ERROR_SYSTEM,
    USB_ERROR_INVALID_PARAM,
    USB_ERROR_SCHEDULE_FULL,
    USB_ERROR_NO_DEVICE,
    USB_ERROR_NO_MEMORY,
    USB_ERROR_NOT_SUPPORTED,
    USB_ERROR_OVERFLOW,
    USB_ERROR_TIMEOUT,
    USB_ERROR_FAILED,
    USB_USER_ERROR = 100,
};

const usb_transfer_status = enum(c_int) {
    /// The transfer completed successfully.
    /// @note A transfer will complete when the end of a packet is detected, or the
    /// buffer is full, whichever happens first.  Therefore just because a transfer
    /// completes doesn't mean the entire buffer's worth of data was transferred.
    USB_TRANSFER_COMPLETED = 0,
    /// The transfer stalled.  If this is a control transfer, then this request is
    /// not supported, and any pending requests continue as normal.  Otherwise,
    /// the endpoint's halt condition is automatically cleared and any pending
    /// transfers are cancelled.
    USB_TRANSFER_STALLED = 1 << 0,
    /// Lost the connection with the device.  It was probably unplugged.  This
    /// always counts as a cancellation.
    USB_TRANSFER_NO_DEVICE = 1 << 1,
    /// The results of the transaction were missed due to host hold-off.
    /// @note This probably indicates a bug in this library.
    USB_TRANSFER_HOST_ERROR = 1 << 2,
    /// This is caused by multiple consecutive usb bus errors.  It is reasonable
    /// in this case to keep retrying the transfer until some timeout condition
    /// occurs.
    USB_TRANSFER_ERROR = 1 << 3,
    /// More bytes were received than can fit in the transfer buffer and were lost.
    /// @note This can be avoided by ensuring that receive buffer lengths are
    /// always a multiple of the endpoint's maximum packet length.
    USB_TRANSFER_OVERFLOW = 1 << 4,
    /// The memory bus could not be accessed in a timely enough fashion to transfer
    /// the data.
    /// @note This probably means that non-default cpu speed or lcd parameters are
    /// in effect.
    USB_TRANSFER_BUS_ERROR = 1 << 5,
    /// The transfer failed for some reason, usually indicated by another bit.
    USB_TRANSFER_FAILED = 1 << 6,
    /// The transfer was cancelled.  In that case, any other set bits refer to the
    /// transfer that caused the cancellation.  If no other bits are set, then it
    /// was manually cancelled.
    USB_TRANSFER_CANCELLED = 1 << 7,
};

const usb_device_flags = enum(c_int) {
    /// Return all devices
    USB_SKIP_NONE = 0,
    /// Don't return disabled devices.
    USB_SKIP_DISABLED = 1 << 0,
    /// Don't return enabled devices.
    USB_SKIP_ENABLED = 1 << 1,
    /// Don't return non-hubs.
    USB_SKIP_DEVICES = 1 << 2,
    /// Don't return hubs.
    USB_SKIP_HUBS = 1 << 3,
    /// Only return devices directly attached to
    /// any of the hubs through which \c from is
    /// connected.  This skips recursing over
    /// devices attached to other hubs.
    USB_SKIP_ATTACHED = 1 << 4,
};

const usb_find_device_flags = enum(c_int) {
    /// Return all devices
    USB_SKIP_NONE = 0,
    /// Don't return disabled devices.
    USB_SKIP_DISABLED = 1 << 0,
    /// Don't return enabled devices.
    USB_SKIP_ENABLED = 1 << 1,
    /// Don't return non-hubs.
    USB_SKIP_DEVICES = 1 << 2,
    /// Don't return hubs.
    USB_SKIP_HUBS = 1 << 3,
    /// Only return devices directly attached to
    /// any of the hubs through which \c from is
    /// connected. This skips recursing over
    /// devices attached to other hubs.
    USB_SKIP_ATTACHED = 1 << 4,
};

const usb_endpoint_flags = enum(c_int) {
    /// For transfers that are a multiple of
    /// the endpoint's maximum packet length,
    /// don't automatically terminate outgoing
    /// ones with a zero-length packet and
    /// don't require incoming ones to be
    /// terminated with a zero-length packet.
    /// @note This allows you to send or
    /// receive partial transfers in multiples
    /// of the endpoint's maximum packet
    /// length, but requires that transfers
    /// which are a multiple of the endpoint's
    /// maximum packet length to be manually
    /// terminated with an explicit zero-length
    /// transfer.
    USB_MANUAL_TERMINATE = 0 << 0,
    /// For transfers that are a multiple of
    /// the endpoint's maximum packet length,
    /// automatically terminate outgoing ones
    /// with a zero-length packet and require
    /// incoming ones to be terminated with a
    /// zero-length packet or fail with
    /// USB_TRANSFER_OVERFLOW.
    USB_AUTO_TERMINATE = 1 << 0,
};

const usb_role = enum(c_int) {
    /// Acting as usb host.
    USB_ROLE_HOST = 0 << 4,
    /// Acting as usb device.
    USB_ROLE_DEVICE = 1 << 4,
    /// Plug A plugged in.
    USB_ROLE_A = 0 << 5,
    /// Plug B plugged in.
    USB_ROLE_B = 1 << 5,
};

const usb_speed_flags = enum(c_int) {
    USB_SPEED_UNKNOWN = -1,
    /// 12 Mb/s
    USB_SPEED_FULL = 0 << 4,
    /// 1.5 Mb/s
    USB_SPEED_LOW = 1 << 4,
};

const usb_transfer_direction = enum(c_int) {
    USB_HOST_TO_DEVICE = 0 << 7,
    USB_DEVICE_TO_HOST = 1 << 7,
};

const usb_request_type = enum(c_int) {
    USB_STANDARD_REQUEST = 0 << 5,
    USB_CLASS_REQUEST = 1 << 5,
    USB_VENDOR_REQUEST = 2 << 5,
};

const usb_recipient = enum(c_int) {
    USB_RECIPIENT_DEVICE,
    USB_RECIPIENT_INTERFACE,
    USB_RECIPIENT_ENDPOINT,
    USB_RECIPIENT_OTHER,
};

const usb_request = enum(c_int) {
    USB_GET_STATUS_REQUEST,
    USB_CLEAR_FEATURE_REQUEST,
    USB_SET_FEATURE_REQUEST = 3,
    USB_SET_ADDRESS_REQUEST = 5,
    USB_GET_DESCRIPTOR_REQUEST,
    USB_SET_DESCRIPTOR_REQUEST,
    USB_GET_CONFIGURATION_REQUEST,
    USB_SET_CONFIGURATION_REQUEST,
    USB_GET_INTERFACE_REQUEST,
    USB_SET_INTERFACE_REQUEST,
    USB_SYNC_FRAME_REQUEST,
};

const usb_feature = enum(c_int) {
    USB_ENDPOINT_HALT_FEATURE,
    USB_DEVICE_REMOTE_WAKEUP_FEATURE,
    USB_DEVICE_TEST_MODE_FEATURE,
};

const usb_device_status = enum(c_int) {
    USB_DEVICE_SELF_POWERED_STATUS = 1 << 0,
    USB_DEVICE_REMOTE_WAKEUP_STATUS = 1 << 1,
};

const usb_endpoint_status = enum(c_int) {
    USB_ENDPOINT_HALT_STATUS = 1 << 0,
};

const usb_descriptor_type = enum(c_int) {
    USB_DEVICE_DESCRIPTOR = 1,
    USB_CONFIGURATION_DESCRIPTOR,
    USB_STRING_DESCRIPTOR,
    USB_INTERFACE_DESCRIPTOR,
    USB_ENDPOINT_DESCRIPTOR,
    USB_HUB_DESCRIPTOR = 0x29,
};

const usb_class = enum(c_int) {
    USB_INTERFACE_SPECIFIC_CLASS,
    USB_AUDIO_CLASS,
    USB_COMM_CLASS,
    USB_HID_CLASS,
    USB_PHYSICAL_CLASS = 5,
    USB_IMAGE_CLASS,
    USB_PRINTER_CLASS,
    USB_STORAGE_CLASS,
    USB_HUB_CLASS,
    USB_CDC_DATA_CLASS,
    USB_SMART_CARD_CLASS,
    USB_CONTENT_SECURITY_CLASS,
    USB_VIDEO_CLASS,
    USB_PERSONAL_HEALTCARE_CLASS,
    USB_AUDIO_VIDEO_CLASS,
    USB_BILLBOARD_CLASS,
    USB_TYPE_C_BRIDGE_CLASS,
    USB_DIAGNOSTIC_DEVICE_CLASS = 0xDC,
    USB_WIRELESS_CONTROLLER_CLASS = 0xE0,
    USB_MISCELLANEOUS_CLASS = 0xEF,
    USB_APPLICATION_SPECIFIC_CLASS = 0xFE,
    USB_VENDOR_SPECIFIC_CLASS = 0xFF,
};

const usb_configuration_attributes = enum(c_int) {
    USB_NO_REMOTE_WAKEUP = 0 << 5,
    USB_REMOTE_WAKEUP = 1 << 5,
    USB_BUS_POWERED = 0 << 6,
    USB_SELF_POWERED = 1 << 6,
    USB_CONFIGURATION_ATTRIBUTES = 1 << 7,
};

const usb_usage_type = enum(c_int) {
    USB_DATA_ENDPOINT = 0 << 4,
    USB_FEEDBACK_ENDPOINT = 1 << 4,
    USB_IMPLICIT_FEEDBACK_DATA_ENDPOINT = 2 << 4,
};

const usb_synchronization_type = enum(c_int) {
    USB_NO_SYNCHRONIZATION = 0 << 2,
    USB_ASYNCHRONOUS = 1 << 2,
    USB_ADAPTIVE = 2 << 2,
    USB_SYNCHRONOUS = 3 << 2,
};

const usb_transfer_type = enum(c_int) {
    USB_UNKNOWN_TRANSFER = -1,
    USB_CONTROL_TRANSFER,
    USB_ISOCHRONOUS_TRANSFER,
    USB_BULK_TRANSFER,
    USB_INTERRUPT_TRANSFER,
};

const usb_control_setup = struct {
    /// direction, type, and recipient
    bmRequestType: u8 = 0,
    /// usb_request
    bRequest: u8 = 0,
    /// request specific
    wValue: u16 = 0,
    /// request specific
    wIndex: u16 = 0,
    /// transfer length
    wLength: u16 = 0,
};

const usb_descriptor = struct {
    bLength: u8 align(1) = 0,
    bDescriptorType: u8 = 0,
    pub fn data(self: anytype) FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 2)));
    }
};

const usb_device_descriptor = struct {
    /// 18
    bLength: u8 = 0,
    /// USB_DEVICE_DESCRIPTOR
    bDescriptorType: u8 = 0,
    /// usb specification version
    bcdUSB: u16 = 0,
    /// usb_class
    bDeviceClass: u8 = 0,
    /// usb class specific
    bDeviceSubClass: u8 = 0,
    /// usb class specific
    bDeviceProtocol: u8 = 0,
    /// 8, 16, 32, or 64
    bMaxPacketSize0: u8 = 0,
    /// usb assigned vendor id
    idVendor: u16 = 0,
    /// usb assigned product id
    idProduct: u16 = 0,
    /// device version
    bcdDevice: u16 = 0,
    /// index of manufacturer string descriptor
    iManufacturer: u8 = 0,
    /// index of product string descriptor
    iProduct: u8 = 0,
    /// index of serial number string descriptor
    iSerialNumber: u8 = 0,
    /// how many valid configuration indices
    bNumConfigurations: u8 = 0,
};

const usb_device_qualifier_descriptor = struct {
    /// 10
    bLength: u8 = 0,
    /// USB_DEVICE_QUALIFIER_DESCRIPTOR
    bDescriptorType: u8 = 0,
    /// usb specification version
    bcdUSB: u16 = 0,
    /// usb_class
    bDeviceClass: u8 = 0,
    /// usb class specific
    bDeviceSubClass: u8 = 0,
    /// usb class specific
    bDeviceProtocol: u8 = 0,
    /// 8, 16, 32, or 64
    bMaxPacketSize0: u8 = 0,
    /// how many valid configuration indices
    bNumConfigurations: u8 = 0,
    /// must be 0
    bReserved: u8 = 0,
};

const usb_configuration_descriptor = struct {
    /// 9
    bLength: u8 = 0,
    /// USB_CONFIGURATION_DESCRIPTOR
    bDescriptorType: u8 = 0,
    /// total length of combined descriptors
    wTotalLength: u16 = 0,
    /// how many interface descriptors follow
    bNumInterfaces: u8 = 0,
    /// value used to select this configuration
    bConfigurationValue: u8 = 0,
    /// index of description string descriptor
    iConfiguration: u8 = 0,
    /// usb_configuration_attributes
    bmAttributes: u8 = 0,
    /// units of 2mA
    bMaxPower: u8 = 0,
};

const usb_interface_descriptor = struct {
    /// 9
    bLength: u8 = 0,
    /// USB_INTERFACE_DESCRIPTOR
    bDescriptorType: u8 = 0,
    /// zero-based interface index
    bInterfaceNumber: u8 = 0,
    /// value used to select this alt setting
    bAlternateSetting: u8 = 0,
    /// how many endpoint descriptors follow
    bNumEndpoints: u8 = 0,
    /// usb_class
    bInterfaceClass: u8 = 0,
    /// usb class specific
    bInterfaceSubClass: u8 = 0,
    /// usb class specific
    bInterfaceProtocol: u8 = 0,
    /// index of description string descriptor
    iInterface: u8 = 0,
};

const usb_endpoint_descriptor = struct {
    /// 7
    bLength: u8 = 0,
    /// USB_ENDPOINT_DESCRIPTOR
    bDescriptorType: u8 = 0,
    /// endpoint direction and number
    bEndpointAddress: u8 = 0,
    /// usb_usage_type |
    /// usb_synchronization_type |
    /// usb_transfer_type
    bmAttributes: u8 = 0,
    /// transfer type specific
    wMaxPacketSize: u16 = 0,
    /// transfer type specific
    bInterval: u8 = 0,
};

const usb_string_descriptor = struct {
    /// byte length, not character length
    bLength: u8 align(1) = 0,
    /// USB_STRING_DESCRIPTOR
    bDescriptorType: u8 = 0,
    /// UTF-16 string, no null termination
    pub fn bString(self: anytype) FlexibleArrayType(@TypeOf(self), u16) {
        const Intermediate = FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = FlexibleArrayType(@TypeOf(self), u16);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 2)));
    }
};

const usb_standard_descriptors = struct {
    /// Pointer to device descriptor which must be in RAM
    device: ?*const usb_device_descriptor = null,
    /// Pointer to array of device->bNumConfigurations pointers to complete
    /// configuration descriptors. Each one should point to
    /// \c {(*configurations)[i]->wTotalLength} bytes of RAM.
    configurations: [*c]const [*c]const usb_configuration_descriptor = undefined,
    /// Pointer to array of langids, formatted like a string descriptor, with each
    /// wchar_t containing a langid, and which must be in RAM.
    langids: [*c]const usb_string_descriptor = undefined,
    /// Number of strings per langid.
    numStrings: u8 = 0,
    /// Pointer to array of \c {numStrings * (langids->bLength / 2 - 1)} pointers
    /// to string descriptors, each of which must be in RAM, starting with
    /// numStrings pointers for the first langid, then for the next langid, etc.
    strings: [*c]const [*c]const usb_string_descriptor = undefined,
};

pub const usb_device = opaque {};
pub const usb_endpoint = opaque {};
pub const usb_device_t = ?*usb_device;
pub const usb_endpoint_t = ?*usb_endpoint;

pub const USB_RETRY_FOREVER = 0xFFFFFF;

pub inline fn usb_RootHub() usb_device_t {
    return @ptrFromInt(0xD13FE0);
}

/// A pointer to \c usb_callback_data_t is passed to the \c usb_event_callback_t.
/// The default is void *, but this can be changed by doing:
/// \code
/// #define usb_callback_data_t struct my_usb_callback_data
/// #include <usbdrvce.h>
/// \endcode
pub const usb_callback_data_t = anyopaque;
/// A pointer to \c usb_device_data_t can be associated with devices.
/// The default is void *, but this can be changed by doing:
/// \code
/// #define usb_device_data_t struct my_usb_device_data
/// #include <usbdrvce.h>
/// \endcode
pub const usb_device_data_t = anyopaque;
/// A pointer to \c usb_endpoint_data_t can be associated with endpoints.
/// The default is void *, but this can be changed by doing:
/// \code
/// #define usb_endpoint_data_t struct my_usb_endpoint_data
/// #include <usbdrvce.h>
/// \endcode
pub const usb_endpoint_data_t = anyopaque;
/// A pointer to \c usb_transfer_data_t is passed to \c usb_transfer_callback_t.
/// The default is void *, but this can be changed by doing:
/// \code
/// #define usb_transfer_data_t struct my_usb_transfer_data
/// #include <usbdrvce.h>
/// \endcode
pub const usb_transfer_data_t = anyopaque;

/// Type of the function to be called when a usb device event occurs.
/// @return Return USB_SUCCESS to initialize the device, USB_IGNORE to ignore it
/// without erroring, or any other value to abort and return from
/// usb_ProcessEvents() with that value.
pub const usb_event_callback_t = ?*const fn (
    /// Event type.
    usb_event,
    /// Event specific data.
    ?*anyopaque,
    /// callback_data Opaque pointer passed to usb_Init().  By default is of
    /// type void *, but that can be changed by doing:
    /// \code
    /// #define usb_device_callback_data_t struct mystruct
    /// #include <usbdrvce.h>
    /// \endcode
    ?*anyopaque,
) callconv(.c) usb_error;

/// Type of the function to be called when a transfer finishes.
/// @return Return USB_SUCCESS to free the transfer.  Return USB_IGNORE to
/// restart it, which is only possible if USB_TRANSFER_FAILED is set.
/// Return any other value to abort and return from usb_ProcessEvents() with that
/// value.
pub const usb_transfer_callback_t = ?*const fn (
    /// The transfer endpoint.
    usb_endpoint_t,
    /// Status of the transfer.
    usb_transfer_status,
    /// transferred The number of bytes transferred.
    /// Only valid if \p status was USB_TRANSFER_COMPLETED.
    usize,
    /// Opaque pointer passed to usb_Schedule*Transfer().  By default is
    /// of type void *, but that can be changed by doing:
    /// \code
    /// #define usb_transfer_callback_data_t struct mystruct
    /// #include <usbdrvce.h>
    /// \endcode
    ?*anyopaque,
) callconv(.c) usb_error;

/// This struct represents a timed callback.  It must be allocated by the user.
/// The only public member is handler, which must be initialized before use.
/// If you want to access other data from the callback, allocate a larger
/// struct with this struct as its first member and cast like in the usb_timer
/// example.
pub const usb_timer_t = usb_timer;

/// Type of the function to be called when a timer expires.
/// @return Return USB_SUCCESS or any other value to abort and return from
/// usb_ProcessEvents() with that error.
pub const usb_timer_callback_t = ?*const fn (
    /// Timer pointer.
    [*c]usb_timer_t,
) callconv(.c) usb_error;

pub const usb_timer = extern struct {
    /// private
    tick: u32 = 0,
    /// private
    next: [*c]usb_timer_t = undefined,
    handler: usb_timer_callback_t = null,
};

/// Initializes the usb driver.
/// @return USB_SUCCESS if initialization succeeded.
/// @note This must be called before any other function, and can be called again
/// to cancel all transfers and disable all devices.
pub extern fn usb_Init(
    /// Function to be called when a usb event happens.
    handler: usb_event_callback_t,
    /// Opaque pointer to be passed to \p handler.
    data: ?*anyopaque,
    /// A pointer to the device descriptors to use, or
    /// NULL to use the calculator's defaults.
    device_descriptors: [*c]const usb_standard_descriptors,
    /// Which areas of memory to use.
    flags: usb_init_flags,
) usb_error;

/// Uninitializes the usb driver.
/// @note This must be called after calling usb_Init() and before the program
/// exits, even if usb_Init returns an error, or else TIOS gets angry.
pub extern fn usb_Cleanup() void;

/// This calls any transfer callbacks that have triggered.
/// It is not necessary to call this function, because
/// completed transfers will trigger in any other event
/// dispatch function at the end of the frame.  However,
/// this function may be useful for polling for transfers
/// that may complete early in a frame, without having to wait
/// for the frame to end.  For reference, a frame lasts 1ms.
/// @return An error returned by a callback or USB_SUCCESS.
pub extern fn usb_PollTransfers() usb_error;

/// Calls any device or transfer callbacks that have triggered.
/// @return An error returned by a callback or USB_SUCCESS.
pub extern fn usb_HandleEvents() usb_error;

/// Waits for any device or transfer events to occur, then calls their associated
/// callbacks.
/// @return An error returned by a callback or USB_SUCCESS.
pub extern fn usb_WaitForEvents() usb_error;

/// Waits for any interrupt or usb event to occur, then calls any device or
/// transfer callbacks that may have triggered.
/// @return An error returned by a callback or USB_SUCCESS.
pub extern fn usb_WaitForInterrupt() usb_error;

/// This function may be called to prevent \p device from being automatically
/// freed after its correspending \c USB_DEVICE_DISCONNECTED_EVENT returns.
/// This allows you to continue passing it to other API functions, although
/// many will error with \c USB_ERROR_NO_DEVICE.
/// @return device
pub extern fn usb_RefDevice(
    /// The device to increase the reference count of.
    device: usb_device_t,
) usb_device_t;

/// Once this function has been called the same number of times that
/// usb_RefDevice() was called on \p device and the event callback has returned
/// from processing a corresponding \c USB_DEVICE_DISCONNECTED_EVENT, \p device
/// becomes an invalid pointer and may no longer be passed to any API function.
/// @return NULL
pub extern fn usb_UnrefDevice(
    /// The device to decrease the reference count of.
    device: usb_device_t,
) usb_device_t;

/// Gets the hub that \p device is attached to, or NULL if \p device is the root
/// hub.
/// @return The hub device or NULL.
pub extern fn usb_GetDeviceHub(
    /// Device to get the hub of.
    device: usb_device_t,
) usb_device_t;

/// Sets the user data associated with \p device.
pub extern fn usb_SetDeviceData(
    /// Device to set the user data of.
    device: usb_device_t,
    /// Data to set.
    data: ?*anyopaque,
) void;

/// Gets the user data associated with \p device.
/// @return The user data last set with \c usb_SetDeviceData.
pub extern fn usb_GetDeviceData(
    /// Device to get the user data of.
    device: usb_device_t,
) ?*anyopaque;

/// This returns the same flags that are used by usb_FindDevice() for a given
/// \p device.  Note that \c USB_SKIP_ATTACHED is not part of these flags.
/// @return The \c usb_device_flags_t flags associated with \p device.
pub extern fn usb_GetDeviceFlags(
    /// The device to get the flags of.
    device: usb_device_t,
) usb_device_flags;

/// Finds the next device connected through \p root after \p from satisfying
/// \p flags, or \c NULL if no more matching devices.
///
/// To enumerate all devices, excluding all hubs:
/// \code
/// usb_device_t device = NULL;
/// while ((device = usb_FindDevice(NULL, device, USB_SKIP_HUBS))) {
///   handle(device);
/// }
/// \endcode
///
/// To enumerate all hubs and devices, including the root hub:
/// \code
/// usb_device_t device = NULL;
/// while ((device = usb_FindDevice(NULL, device, USB_SKIP_NONE))) {
///   handle(device);
/// }
/// \endcode
///
/// To enumerate all hubs and devices except the root hub:
/// \code
/// usb_device_t device = NULL; // same as using usb_RootHub()
/// while ((device = usb_FindDevice(usb_RootHub(), device, USB_SKIP_NONE))) {
///   handle(device);
/// }
/// \endcode
///
/// To enumerate all devices below a specific hub:
/// \code
/// usb_device_t device = NULL; // same as using hub
/// while ((device = usb_FindDevice(hub, device, USB_SKIP_NONE))) {
///   handle(device);
/// }
/// \endcode
///
/// To enumerate all disabled hubs directly attached to a specific hub:
/// \code
/// usb_device_t device = NULL; // must not use hub or else USB_SKIP_ATTACHED
///                             // will skip all devices attached to hub!
/// while ((device = usb_FindDevice(hub, device, USB_SKIP_ENABLED |
///                                 USB_SKIP_DEVICES | USB_SKIP_ATTACHED))) {
///   handle(device);
/// }
/// \endcode
/// @return The next device connected through \p root after \p from satisfying
/// \p flags or \c NULL if none.
pub extern fn usb_FindDevice(
    /// Hub below which to limit search, or \c NULL to search all
    /// devices including the root hub.
    root: usb_device_t,
    /// The device to start the search from, or \c NULL to start from
    /// \p root and include devices attached to root even with \c USB_SKIP_ATTACHED.
    from: usb_device_t,
    /// What kinds of devices to return.
    flags: usb_find_device_flags,
) usb_device_t;

/// Performs an asynchronous usb reset on a device. This triggers a device
/// enabled event when the reset is complete.
/// @return USB_SUCCESS if the transfer succeeded or an error.
pub extern fn usb_ResetDevice(
    /// The device to reset.
    device: usb_device_t,
) usb_error;

/// Forces a device to become disabled. This triggers a device disabled event
/// when it finishes.
/// @return USB_SUCCESS if the transfer succeeded or an error.
pub extern fn usb_DisableDevice(
    /// The device to disable.
    device: usb_device_t,
) usb_error;

/// Gets the usb address of a \p device, or 0 if disabled.
/// @return The usb address or 0.
pub extern fn usb_GetDeviceAddress(
    /// The device to communicate with.
    device: usb_device_t,
) u8;

/// Gets the speed of a device, or USB_SPEED_UNKNOWN if unknown.
/// @return The \c usb_speed_t.
pub extern fn usb_GetDeviceSpeed(
    /// The device to communicate with.
    device: usb_device_t,
) i8;

/// Determines how large of a buffer would be required to receive the complete
/// configuration descriptor at \p index.
/// @note Blocks while the configuration descriptor is fetched.
/// @return The total length in bytes of the combined configuration descriptor or
/// 0 on error.
pub extern fn usb_GetConfigurationDescriptorTotalLength(
    /// The device to communicate with.
    device: usb_device_t,
    /// Which configuration descriptor to query.
    index: u8,
) usize;

/// Gets the descriptor of a \p device of \p type at \p index.
/// @note Blocks while the descriptor is fetched.
/// @return USB_SUCCESS if the transfer succeeded or an error.
pub extern fn usb_GetDescriptor(
    /// The device to communicate with.
    device: usb_device_t,
    /// The \c usb_descriptor_type to fetch.
    @"type": usb_descriptor_type,
    /// Descriptor index to fetch.
    index: u8,
    /// Returns the fetched descriptor.
    descriptor: ?*anyopaque,
    /// The maximum number of bytes to receive.
    /// The \p descriptor buffer must be at least this large.
    length: usize,
    /// transferred NULL or returns the number of bytes actually received.
    transferred: [*c]usize,
) usb_error;

/// Macro of usb_GetDescriptor() using USB_DEVICE_DESCRIPTOR for the type.
/// @see usb_GetDescriptor()
pub inline fn usb_GetDeviceDescriptor(device: usb_device_t, descriptor: ?*anyopaque, length: usize, transferred: [*c]usize) usb_error {
    return usb_GetDescriptor(device, usb_descriptor_type.USB_DEVICE_DESCRIPTOR, 0, descriptor, length, transferred);
}

/// Macro of usb_GetDescriptor() using USB_CONFIGURATION_DESCRIPTOR for the type.
/// @see usb_GetDescriptor()
pub inline fn usb_GetConfigurationDescriptor(device: usb_device_t, index: u8, descriptor: ?*anyopaque, length: usize, transferred: [*c]usize) usb_error {
    return usb_GetDescriptor(device, usb_descriptor_type.USB_CONFIGURATION_DESCRIPTOR, index, descriptor, length, transferred);
}

/// Changes the descriptor at \p index.
/// @note Blocks while the descriptor is changed.
/// @note Devices do not usually support this.
/// @return USB_SUCCESS if the transfer succeeded or an error.
pub extern fn usb_SetDescriptor(
    /// The device to communicate with.
    device: usb_device_t,
    /// The \c usb_descriptor_type to change.
    @"type": usb_descriptor_type,
    /// The descriptor index to change.
    index: u8,
    /// The new descriptor.
    descriptor: ?*const anyopaque,
    /// The number of bytes in the new descriptor.
    /// The \p descriptor buffer must be this large.
    length: usize,
) usb_error;

/// Macro of usb_SetDescriptor() using USB_DEVICE_DESCRIPTOR for the type.
/// @see usb_SetDescriptor()
pub inline fn usb_SetDeviceDescriptor(device: usb_device_t, descriptor: ?*const anyopaque, length: usize) usb_error {
    _ = &device;
    _ = &descriptor;
    _ = &length;
    return usb_SetDescriptor(device, usb_descriptor_type.USB_DEVICE_DESCRIPTOR, @as(c_int, 0), descriptor, length);
}

/// Macro of usb_SetDescriptor() using USB_CONFIGURATION_DESCRIPTOR for the type.
/// @see usb_SetDescriptor()
pub inline fn usb_SetConfigurationDescriptor(device: usb_device_t, index: u8, descriptor: ?*const anyopaque, length: usize) usb_error {
    return usb_SetDescriptor(device, usb_descriptor_type.USB_CONFIGURATION_DESCRIPTOR, index, descriptor, length);
}

/// Gets the string descriptor at \p index and \p langid.
/// @note Blocks while the descriptor is fetched.
/// @return USB_SUCCESS if the transfer succeeded or an error.
pub extern fn usb_GetStringDescriptor(
    /// The device to communicate with.
    device: usb_device_t,
    /// Descriptor index to fetch.
    index: u8,
    /// Language ID to fetch.
    langid: u16,
    /// Returns the fetched descriptor.
    descriptor: [*c]usb_string_descriptor,
    /// The number of bytes to transfer.
    /// The \p descriptor buffer must be at least this large.
    length: usize,
    /// NULL or returns the number of bytes actually received.
    transferred: [*c]usize,
) usb_error;

/// Sets the string descriptor at \p index and \p langid.
/// @note Blocks while the descriptor is changed.
/// @note Devices do not usually support this.
/// @return USB_SUCCESS if the transfer succeeded or an error.
pub extern fn usb_SetStringDescriptor(
    /// The device to communicate with.
    device: usb_device_t,
    /// Descriptor index to change.
    index: u8,
    /// Language ID to change.
    langid: u16,
    /// The new descriptor.
    descriptor: [*c]const usb_string_descriptor,
    /// The number of bytes to transfer.
    /// The \p descriptor buffer must be this large.
    length: usize,
) usb_error;

/// Gets the currently active configuration of a device.
/// @return USB_SUCCESS if the transfer succeeded or an error.
pub extern fn usb_GetConfiguration(
    /// The device to communicate with.
    device: usb_device_t,
    /// Returns the current configuration value, or 0 if unconfigured.
    index: [*c]u8,
) usb_error;

/// Selects the configuration specified by the \p configuration_descriptor.
/// This must be called before pipes other than the default control pipe can be
/// accessed.  Calling this function invalidates all \c usb_endpoint_t pointers
/// corresponding with \p device except for any referring to its default control
/// pipe.
/// @return USB_SUCCESS if the transfer succeeded or an error.
pub extern fn usb_SetConfiguration(
    /// The device to communicate with.
    device: usb_device_t,
    /// A complete combined configuration descriptor fetched with
    /// usb_GetDescriptor().
    descriptor: [*c]const usb_configuration_descriptor,
    /// The total length of the configuration descriptor.
    length: usize,
) usb_error;

/// Gets the current alternate setting in use on the specified interface.
/// @return USB_SUCCESS if the transfer succeeded or an error.
pub extern fn usb_GetInterface(
    /// The device to communicate with.
    device: usb_device_t,
    /// Interface index to query.
    interface: u8,
    /// Returns the alternate setting in use.
    alternate_setting: [*c]u8,
) usb_error;

/// Sets the alternate setting to use for its corresponding interface.  Calling
/// this function invalidates any \p usb_endpoint_t pointers corresponding with
/// the endpoints that were part of the previously selected alternate setting.
/// @return USB_SUCCESS if the transfer succeeded or an error.
pub extern fn usb_SetInterface(
    /// The device to communicate with.
    device: usb_device_t,
    /// The interface descriptor describing the alternate
    /// setting to select within a configuration descriptor.
    descriptor: [*c]const usb_interface_descriptor,
    /// The remaining length of the configuration descriptor after
    /// the beginning of the \p interface_descriptor.
    length: usize,
) usb_error;

/// Sets halt condition on \p endpoint.  This is only supported by bulk and
/// interrupt endpoints.  If acting as usb host, this may only be called if there
/// are no pending transfers.  This also has the sife effect of asynchronously
/// cancelling all pending transfers to \p endpoint.
/// @return USB_SUCCESS if the transfer succeeded or an error.
pub extern fn usb_SetEndpointHalt(
    /// The endpoint to set the halt condition of.
    endpoint: usb_endpoint_t,
) usb_error;

/// Clears halt condition on \p endpoint.  This is only supported by bulk and
/// interrupt endpoints.  If acting as usb host, this may only be called if there
/// are no pending transfers.  If any non-control transfer stalls, this is called
/// automatically, so you only need to call this if you need to clear an endpoint
/// halt for a reason other than a stalled transfer. This function blocks until
/// the halt condition is cleared.
/// @return USB_SUCCESS if the transfer succeeded or an error.
pub extern fn usb_ClearEndpointHalt(
    /// The endpoint to clear the halt condition of.
    endpoint: usb_endpoint_t,
) usb_error;

/// Gets the endpoint of a \p device with a given \p address, or NULL if that
/// address is unused.
/// @return The specified endpoint or NULL.
pub extern fn usb_GetDeviceEndpoint(
    /// Device to get the user data of.
    device: usb_device_t,
    /// Address of the endpoint to get.
    address: u8,
) usb_endpoint_t;

/// Gets the device that \p endpoint is connected to.
/// @return The device for an \p endpoint.
pub extern fn usb_GetEndpointDevice(
    /// Endpoint to get the device of.
    endpoint: usb_endpoint_t,
) usb_device_t;

/// Sets the user data associated with \p endpoint.
pub extern fn usb_SetEndpointData(
    /// Endpoint to set the user data of.
    endpoint: usb_endpoint_t,
    /// Data to set.
    data: ?*usb_endpoint_data_t,
) void;

/// Gets the user data associated with \p endpoint.
/// @return The user data last set with \c usb_SetEndpointData.
pub extern fn usb_GetEndpointData(
    /// Endpoint to get the user data of.
    endpoint: usb_endpoint_t,
) ?*usb_endpoint_data_t;

/// Gets the address of an endpoint.
/// @return The address of an \p endpoint or 0xFF on error.
pub extern fn usb_GetEndpointAddress(
    /// The endpoint to get the address of.
    endpoint: usb_endpoint_t,
) u8;

/// Gets the transfer type of an endpoint.
/// @return The \c usb_transfer_type of an endpoint.
pub extern fn usb_GetEndpointTransferType(
    /// The endpoint to get the transfer type of.
    endpoint: usb_endpoint_t,
) i8;

/// Gets the maximum packet size of an endpoint.
/// @return The \c wMaxPacketSize of an \p endpoint.
pub extern fn usb_GetEndpointMaxPacketSize(
    /// The endpoint to get the maximum packet size of.
    endpoint: usb_endpoint_t,
) usize;

/// Gets the interval of an endpoint.
/// @return The actual \c bInterval of an \p endpoint, which is rounded down to
/// the nearest power of two from the descriptor, or 0 for asynchronous
/// endpoints.
pub extern fn usb_GetEndpointInterval(
    /// The endpoint to get the endpoint of.
    endpoint: usb_endpoint_t,
) u8;

/// Sets the flags for an endpoint.
pub extern fn usb_SetEndpointFlags(
    /// The endpoint to set the flags of.
    endpoint: usb_endpoint_t,
    /// The \c usb_endpoint_flags_t to set.
    flags: usb_endpoint_flags,
) void;

/// Gets the flags for an endpoint.
/// @return The \c usb_endpoint_flags_t last set with \c usb_SetEndpointFlags.
pub extern fn usb_GetEndpointFlags(
    /// The endpoint to get the flags of.
    endpoint: usb_endpoint_t,
) usb_endpoint_flags;

/// Returns the current role the usb hardware is operating in.
/// @return The \c usb_role of the current role.
pub extern fn usb_GetRole() usb_role;

/// Returns the current 11-bit frame number, as last broadcast by the current
/// host, multiplied by 8.  This value ranges from 0x0000 to 0x3FF8, increases by
/// 8 every 1 ms, is truncated to 14 bits, and is synchronized with the host usb
/// clock.
/// @warning The bottom 3 bits are usually 0, but this is not guaranteed because
/// random mmio writes could affect those bits.
/// @note If the hardware supported full speed usb, the lower 3 bits would be the
/// microframe number.
/// @return usb_frame_number << 3
pub extern fn usb_GetFrameNumber() c_uint;

/// Schedules a transfer to the pipe connected to \p endpoint, in the direction
/// indicated by \p setup->bmRequestType, using \p buffer as the data buffer,
/// \p setup->wLength as the buffer length, and then waits for it to complete.
/// If acting as usb host and using a control pipe, \p setup is used as the setup
/// packet, otherwise all fields not mentioned above are ignored.
/// @return USB_SUCCESS if the transfer succeeded or an error.
pub extern fn usb_ControlTransfer(
    /// The endpoint to communicate with, which also specifies the
    /// direction for non-control transfers.
    endpoint: usb_endpoint_t,
    /// Indicates the transfer direction and buffer length.  If acting
    /// as usb host and using a control pipe, also used as the setup packet to send.
    setup: [*c]const usb_control_setup,
    /// Data to transfer that must reside in RAM and have room for at
    /// least \p setup->wLength bytes.
    buffer: ?*anyopaque,
    /// How many times to retry the transfer before timing out.
    /// If retries is USB_RETRY_FOREVER, the transfer never times out.
    retries: c_uint,
    /// NULL or returns the number of bytes actually received.
    transferred: [*c]usize,
) usb_error;

// got tired

pub extern fn usb_Transfer(
    endpoint: usb_endpoint_t,
    buffer: ?*anyopaque,
    length: usize,
    retries: c_uint,
    transferred: [*c]usize,
) usb_error;

pub extern fn usb_ScheduleControlTransfer(
    endpoint: usb_endpoint_t,
    setup: [*c]const usb_control_setup,
    buffer: ?*anyopaque,
    handler: usb_transfer_callback_t,
    data: ?*anyopaque,
) usb_error;

pub extern fn usb_ScheduleTransfer(
    endpoint: usb_endpoint_t,
    buffer: ?*anyopaque,
    length: usize,
    handler: usb_transfer_callback_t,
    data: ?*anyopaque,
) usb_error;

pub extern fn usb_MsToCycles(
    ms: u16,
) u32;

pub extern fn usb_StopTimer(
    timer: [*c]usb_timer_t,
) void;

pub extern fn usb_StartTimerCycles(
    timer: [*c]usb_timer_t,
    timeout_cycles: u32,
) void;

pub extern fn usb_RepeatTimerCycles(
    timer: [*c]usb_timer_t,
    interval_cycles: u32,
) void;

pub extern fn usb_GetCycleCounter() u32;

pub extern fn usb_GetCounter() int24.uint24;
