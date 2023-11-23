using nobody.core;

namespace nobody.online;

public static class StringExtCtx
{
    public static T get<T>(this string key)
    {
        return (T)nobody.core.Nobody.ctx_static[key];
    }

    public static string get_string(this string key, string? default_value = null)
    {
        if (nobody.core.Nobody.ctx_static.has(key))
        {
            return nobody.core.Nobody.ctx_static.get_string(key);
        }
        else
        {
            if (default_value != null)
            {
                nobody.core.Nobody.ctx_static[key] = default_value;
                return default_value;
            }
            else
            {
                return nobody.core.Nobody.ctx_static.get_string(key);
            }
        }
    }


    public static int get_int(this string key)
    {
        return (int)nobody.core.Nobody.ctx_static[key];
    }

    public static double get_double(this string key)
    {
        return (double)nobody.core.Nobody.ctx_static[key];
    }

    public static float get_float(this string key)
    {
        return (float)nobody.core.Nobody.ctx_static[key];
    }

    public static bool get_bool(this string key)
    {
        return (bool)nobody.core.Nobody.ctx_static[key];
    }


    ///remember
    /// this is same like get_string however it will remember the value for next time
    /// it uses context to store the value
    public static string remember(this string key)
    {
        var value = nobody.core.Nobody.ctx_static[key].ToString();
        nobody.core.Nobody.ctx_static[key] = value;
        return value;
    }

    public static int remember_int(this string key)
    {
        var value = (int)nobody.core.Nobody.ctx_static[key];
        nobody.core.Nobody.ctx_static[key] = value;
        return value;
    }
}