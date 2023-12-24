#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
// EXTRA BEGIN
typedef struct DartCObject *WireSyncRust2DartDco;
typedef struct WireSyncRust2DartSse {
  uint8_t *ptr;
  int32_t len;
} WireSyncRust2DartSse;
// EXTRA END
typedef struct _Dart_Handle* Dart_Handle;

typedef struct wire_cst_list_prim_u_8 {
  uint8_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_8;

typedef struct wire_cst_list_String {
  struct wire_cst_list_prim_u_8 **ptr;
  int32_t len;
} wire_cst_list_String;

void dart_fn_deliver_output(int32_t call_id,
                            uint8_t *ptr_,
                            int32_t rust_vec_len_,
                            int32_t data_len_);

void wire_download_driver(int64_t port_, struct wire_cst_list_prim_u_8 *driver_dir);

void wire_get_app_home_dir(int64_t port_);

void wire_get_driver_dir(int64_t port_);

void wire_get_driver_path(int64_t port_);

void wire_get_edge_version(int64_t port_);

void wire_init_driver(int64_t port_);

void wire_is_webdriver_running(int64_t port_);

void wire_start_webdriver(int64_t port_);

void wire_get_files(int64_t port_);

void wire_my_custom_func(int64_t port_, int32_t a, int32_t b);

void wire_show(int64_t port_, struct wire_cst_list_prim_u_8 *name);

void rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockWebDriver(const void *ptr);

void rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockWebDriver(const void *ptr);

struct wire_cst_list_String *cst_new_list_String(int32_t len);

struct wire_cst_list_prim_u_8 *cst_new_list_prim_u_8(int32_t len);
static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) cst_new_list_String);
    dummy_var ^= ((int64_t) (void*) cst_new_list_prim_u_8);
    dummy_var ^= ((int64_t) (void*) dart_fn_deliver_output);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    dummy_var ^= ((int64_t) (void*) rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockWebDriver);
    dummy_var ^= ((int64_t) (void*) rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockWebDriver);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) wire_download_driver);
    dummy_var ^= ((int64_t) (void*) wire_get_app_home_dir);
    dummy_var ^= ((int64_t) (void*) wire_get_driver_dir);
    dummy_var ^= ((int64_t) (void*) wire_get_driver_path);
    dummy_var ^= ((int64_t) (void*) wire_get_edge_version);
    dummy_var ^= ((int64_t) (void*) wire_get_files);
    dummy_var ^= ((int64_t) (void*) wire_init_driver);
    dummy_var ^= ((int64_t) (void*) wire_is_webdriver_running);
    dummy_var ^= ((int64_t) (void*) wire_my_custom_func);
    dummy_var ^= ((int64_t) (void*) wire_show);
    dummy_var ^= ((int64_t) (void*) wire_start_webdriver);
    return dummy_var;
}
