using nobody.core;

namespace nobody.online;

public static class StringExtCtx
{
    public static T? get<T>(this string key) => Anybody.here.get<T>(key);
    public static bool has(this string key) => Anybody.here.has(key);
    public static void set(this string key, object value) => Anybody.here.set(key, value);
    public static T get_or<T>(this string key, Func<string, T> defaultValue) => Anybody.here.get_or(key, defaultValue);





}

