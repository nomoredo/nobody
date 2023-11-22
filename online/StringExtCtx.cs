namespace nobody.online;

public static class StringExtCtx
{
    public static T get<T>(this string key)
    {
        return (T) nobody.core.Nobody.ctx_static[key];
    }

    public static string get_string(this string key)
    {
        return nobody.core.Nobody.ctx_static[key].ToString();
    }

    public static int get_int(this string key)
    {
        return (int) nobody.core.Nobody.ctx_static[key];
    }

    public static double get_double(this string key)
    {
        return (double) nobody.core.Nobody.ctx_static[key];
    }

    public static float get_float(this string key)
    {
        return (float) nobody.core.Nobody.ctx_static[key];
    }

    public static bool get_bool(this string key)
    {
        return (bool) nobody.core.Nobody.ctx_static[key];
    }


}