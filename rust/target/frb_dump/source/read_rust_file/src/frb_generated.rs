    /* AUTO INJECTED BY flutter_rust_bridge. This line may not be accurate, and you can change it according to your needs. */


    #![allow(non_camel_case_types, unused, non_snake_case, clippy ::
    needless_return, clippy :: redundant_closure_call, clippy ::
    redundant_closure, clippy :: useless_conversion, clippy :: unit_arg,
    clippy :: unused_unit, clippy :: double_parens, clippy :: let_and_return,
    clippy :: too_many_arguments)]
    use flutter_rust_bridge::for_generated::byteorder::{
        NativeEndian, ReadBytesExt, WriteBytesExt,
    };
    use flutter_rust_bridge::for_generated::transform_result_dco;
    use flutter_rust_bridge::{Handler, IntoIntoDart};
    pub trait CstDecode<T> {
        fn cst_decode(self)
        -> T;
    }
    impl<T, S> CstDecode<Option<T>> for *mut S where *mut S: CstDecode<T> {
        fn cst_decode(self) -> Option<T> {
            (!self.is_null()).then(|| self.cst_decode())
        }
    }
    pub trait SseDecode {
        fn sse_decode(deserializer:
            &mut ::flutter_rust_bridge::for_generated::SseDeserializer)
        -> Self;
        fn sse_decode_single(message:
                ::flutter_rust_bridge::for_generated::Dart2RustMessageSse)
            -> Self where Self: Sized {
            let mut deserializer =
                ::flutter_rust_bridge::for_generated::SseDeserializer::new(message);
            let ans = Self::sse_decode(&mut deserializer);
            deserializer.end();
            ans
        }
    }
    pub trait SseEncode {
        fn sse_encode(self,
        serializer: &mut ::flutter_rust_bridge::for_generated::SseSerializer);
    }
    fn transform_result_sse<T, E>(raw: Result<T, E>)
        ->
            Result<::flutter_rust_bridge::for_generated::Rust2DartMessageSse,
            ::flutter_rust_bridge::for_generated::Rust2DartMessageSse> where
        T: SseEncode, E: SseEncode {
        use ::flutter_rust_bridge::for_generated::{Rust2DartAction, SseCodec};
        match raw {
            Ok(raw) =>
                Ok(SseCodec::encode(Rust2DartAction::Success,
                        |serializer| { raw.sse_encode(serializer) })),
            Err(raw) =>
                Err(SseCodec::encode(Rust2DartAction::Error,
                        |serializer| { raw.sse_encode(serializer) })),
        }
    }
    pub struct StreamSink<T,
        Rust2DartCodec: ::flutter_rust_bridge::for_generated::BaseCodec =
        ::flutter_rust_bridge::for_generated::DcoCodec> {
        base: ::flutter_rust_bridge::for_generated::StreamSinkBase<T,
        Rust2DartCodec>,
    }
    #[automatically_derived]
    impl<T: ::core::clone::Clone, Rust2DartCodec: ::core::clone::Clone +
        ::flutter_rust_bridge::for_generated::BaseCodec> ::core::clone::Clone
        for StreamSink<T, Rust2DartCodec> {
        #[inline]
        fn clone(&self) -> StreamSink<T, Rust2DartCodec> {
            StreamSink { base: ::core::clone::Clone::clone(&self.base) }
        }
    }
    impl<T, Rust2DartCodec: ::flutter_rust_bridge::for_generated::BaseCodec>
        StreamSink<T, Rust2DartCodec> {
        pub fn new(base:
                ::flutter_rust_bridge::for_generated::StreamSinkBase<T,
                Rust2DartCodec>) -> Self {
            Self { base }
        }
        pub fn close(&self) -> bool { self.base.close() }
    }
    impl<T> StreamSink<T, ::flutter_rust_bridge::for_generated::DcoCodec> {
        pub fn add<T2>(&self, value: T) -> bool where
            T: ::flutter_rust_bridge::IntoIntoDart<T2>,
            T2: ::flutter_rust_bridge::IntoDart {
            self.base.add(::flutter_rust_bridge::for_generated::DcoCodec::encode(::flutter_rust_bridge::for_generated::Rust2DartAction::Success,
                    value.into_into_dart()))
        }
    }
    impl<T> StreamSink<T, ::flutter_rust_bridge::for_generated::SseCodec>
        where T: SseEncode {
        pub fn add(&self, value: T) -> bool {
            self.base.add(::flutter_rust_bridge::for_generated::SseCodec::encode(::flutter_rust_bridge::for_generated::Rust2DartAction::Success,
                    |serializer| value.sse_encode(serializer)))
        }
    }
    #[allow(missing_copy_implementations)]
    #[allow(non_camel_case_types)]
    #[allow(dead_code)]
    pub struct FLUTTER_RUST_BRIDGE_HANDLER {
        __private_field: (),
    }
    #[doc(hidden)]
    pub static FLUTTER_RUST_BRIDGE_HANDLER: FLUTTER_RUST_BRIDGE_HANDLER =
        FLUTTER_RUST_BRIDGE_HANDLER { __private_field: () };
    impl ::lazy_static::__Deref for FLUTTER_RUST_BRIDGE_HANDLER {
        type Target =
            ::flutter_rust_bridge::DefaultHandler<::flutter_rust_bridge::for_generated::SimpleThreadPool>;
        fn deref(&self)
            ->
                &::flutter_rust_bridge::DefaultHandler<::flutter_rust_bridge::for_generated::SimpleThreadPool> {
            #[inline(always)]
            fn __static_ref_initialize()
                ->
                    ::flutter_rust_bridge::DefaultHandler<::flutter_rust_bridge::for_generated::SimpleThreadPool> {
                ::flutter_rust_bridge::DefaultHandler::new_simple(Default::default())
            }
            #[inline(always)]
            fn __stability()
                ->
                    &'static ::flutter_rust_bridge::DefaultHandler<::flutter_rust_bridge::for_generated::SimpleThreadPool> {
                static LAZY:
                    ::lazy_static::lazy::Lazy<::flutter_rust_bridge::DefaultHandler<::flutter_rust_bridge::for_generated::SimpleThreadPool>>
                    =
                    ::lazy_static::lazy::Lazy::INIT;
                LAZY.get(__static_ref_initialize)
            }
            __stability()
        }
    }
    impl ::lazy_static::LazyStatic for FLUTTER_RUST_BRIDGE_HANDLER {
        fn initialize(lazy: &Self) { let _ = &**lazy; }
    }
    fn wire_my_custom_func_impl(port_:
            flutter_rust_bridge::for_generated::MessagePort,
        a: impl CstDecode<i32> + core::panic::UnwindSafe,
        b: impl CstDecode<i32> + core::panic::UnwindSafe) {
        FLUTTER_RUST_BRIDGE_HANDLER.wrap_normal::<flutter_rust_bridge::for_generated::DcoCodec,
            _,
            _>(flutter_rust_bridge::for_generated::TaskInfo {
                debug_name: "my_custom_func",
                port: Some(port_),
                mode: flutter_rust_bridge::for_generated::FfiCallMode::Normal,
            },
            move ||
                {
                    let api_a = a.cst_decode();
                    let api_b = b.cst_decode();
                    move |context|
                        {
                            transform_result_dco((move ||
                                            {
                                                Result::<_,
                                                        ()>::Ok(crate::api::simple::my_custom_func(api_a, api_b))
                                            })())
                        }
                })
    }
    impl CstDecode<i32> for i32 {
        fn cst_decode(self) -> i32 { self }
    }
    impl SseDecode for i32 {
        fn sse_decode(deserializer:
                &mut flutter_rust_bridge::for_generated::SseDeserializer)
            -> Self {
            deserializer.cursor.read_i32::<NativeEndian>().unwrap()
        }
    }
    impl SseDecode for () {
        fn sse_decode(deserializer:
                &mut flutter_rust_bridge::for_generated::SseDeserializer)
            -> Self {}
    }
    impl SseDecode for bool {
        fn sse_decode(deserializer:
                &mut flutter_rust_bridge::for_generated::SseDeserializer)
            -> Self {
            deserializer.cursor.read_u8().unwrap() != 0
        }
    }
    impl SseEncode for i32 {
        fn sse_encode(self,
            serializer:
                &mut flutter_rust_bridge::for_generated::SseSerializer) {
            serializer.cursor.write_i32::<NativeEndian>(self).unwrap();
        }
    }
    impl SseEncode for () {
        fn sse_encode(self,
            serializer:
                &mut flutter_rust_bridge::for_generated::SseSerializer) {}
    }
    impl SseEncode for bool {
        fn sse_encode(self,
            serializer:
                &mut flutter_rust_bridge::for_generated::SseSerializer) {
            serializer.cursor.write_u8(self as _).unwrap();
        }
    }
    #[cfg(not(target_family = "wasm"))]
    #[path = "frb_generated.io.rs"]
    mod io {
        use super::*;
        use flutter_rust_bridge::for_generated::byteorder::{
            NativeEndian, ReadBytesExt, WriteBytesExt,
        };
        use flutter_rust_bridge::for_generated::transform_result_dco;
        use flutter_rust_bridge::{Handler, IntoIntoDart};
        pub trait NewWithNullPtr {
            fn new_with_null_ptr()
            -> Self;
        }
        impl<T> NewWithNullPtr for *mut T {
            fn new_with_null_ptr() -> Self { std::ptr::null_mut() }
        }
        #[no_mangle]
        pub extern "C" fn dart_fn_deliver_output(call_id: i32, ptr_: *mut u8,
            rust_vec_len_: i32, data_len_: i32) {
            let message =
                unsafe {
                    flutter_rust_bridge::for_generated::Dart2RustMessageSse::from_wire(ptr_,
                        rust_vec_len_, data_len_)
                };
            FLUTTER_RUST_BRIDGE_HANDLER.dart_fn_handle_output(call_id,
                message)
        }
        #[no_mangle]
        pub extern "C" fn wire_my_custom_func(port_: i64, a: i32, b: i32) {
            wire_my_custom_func_impl(port_, a, b)
        }
    }
    #[cfg(not(target_family = "wasm"))]
    pub use io::*;